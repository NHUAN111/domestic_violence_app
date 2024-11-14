import 'dart:convert';
import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:project_domestic_violence/app/data/provider/config.dart';
import 'package:project_domestic_violence/app/models/post.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWritePostProvider {
  Client client = Client();
  Databases? databases;
  Storage? storage;
  Realtime? realtime;
  StreamSubscription? postSubscription;

  AppWritePostProvider() {
    // Initialize client
    client
        .setEndpoint(Config.endpoint)
        .setProject(Config.projectId)
        .setSelfSigned(status: true);

    databases = Databases(client);
    storage = Storage(client);
    realtime = Realtime(client);
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> fileIds = [];

    for (String imagePath in imagePaths) {
      try {
        final fileName = imagePath.split('/').last;
        final file = await storage!.createFile(
          bucketId: Config.bucketId,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: imagePath, filename: fileName),
        );
        print('Image uploaded successfully: ${file.$id}');
        fileIds.add(file.$id);
      } catch (e) {
        print('Error uploading image: $e');
        throw Exception('Cannot upload image: $e');
      }
    }

    return fileIds;
  }

  Future<void> createPost(
      Map<String, dynamic> map, List<String> imagePaths) async {
    // Step 1: Upload images first
    List<String> imageIds = await uploadImages(imagePaths);

    if (imageIds.isEmpty) {
      print('Cannot create post because image upload failed.');
      return;
    }

    // Step 2: Fetch the user ID from local storage (SharedPreferences)
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(Constant.USER);
    if (userJson == null) {
      print('User not logged in or user data is unavailable.');
      return;
    }

    final userMap = Map<String, dynamic>.from(jsonDecode(userJson));
    String? userId = userMap['accountId'];
    print('User ID: $userId');

    if (userId == null || userId.isEmpty) {
      print('User ID is missing.');
      return;
    }

    try {
      final response = await databases!.createDocument(
        databaseId: Config.databaseId,
        collectionId: Config.postCollectionId,
        documentId: ID.unique(),
        data: {
          'type': map['type'],
          'title': map['title'],
          'content': map['content'],
          'image': imageIds,
          'userId': userId,
        },
      );
      print('Post created successfully: ${response.data}');
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  Stream<List<Post>> subscribeToRealtimePost() {
    final controller = StreamController<List<Post>>();

    fetchPosts().then((initialPosts) {
      List<Post> currentPosts =
          initialPosts.map((data) => Post.fromJson(data)).toList();

      // Phát dữ liệu ban đầu
      controller.add(List<Post>.from(currentPosts));

      realtime!
          .subscribe([
            'databases.${Config.databaseId}.collections.${Config.postCollectionId}.documents'
          ])
          .stream
          .listen((event) {
            final payload = event.payload;
            Map<String, dynamic> postData = payload;

            // Đảm bảo có dữ liệu
            if (postData.isNotEmpty) {
              Post post = Post.fromJson(postData);

              if (event.events.any((e) => e.contains('create'))) {
                // Xử lý sự kiện thêm mới
                currentPosts.add(post);
                print("Post created: ${post.id}");
              } else if (event.events.any((e) => e.contains('update'))) {
                // Xử lý sự kiện cập nhật
                int index = currentPosts.indexWhere((p) => p.id == post.id);
                if (index != -1) {
                  currentPosts[index] = post;
                  print("Post updated: ${post.id}");
                } else {
                  print("Update event but post not found: ${post.id}");
                }
              } else if (event.events.any((e) => e.contains('delete'))) {
                // Xử lý sự kiện xóa
                currentPosts.removeWhere((p) => p.id == post.id);
                print("Post deleted: ${post.id}");
              }
            } else {
              print("Received empty payload.");
            }

            // Phát danh sách cập nhật
            controller.add(List<Post>.from(currentPosts));
          });
    });

    return controller.stream;
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    List<Map<String, dynamic>> posts = [];

    try {
      final response = await databases!.listDocuments(
        databaseId: Config.databaseId,
        collectionId: Config.postCollectionId,
      );

      for (var document in response.documents) {
        String title = document.data['title'] ?? "No Title";
        String content = document.data['content'] ?? "No Content";
        int type = document.data['type'] ?? 0;

        List<dynamic>? imageIds = document.data['image'];
        List<String> imageUrls = [];

        if (imageIds != null) {
          for (var imageId in imageIds) {
            if (imageId != null) {
              String imageUrl = await getImageUrl(imageId);
              imageUrls.add(imageUrl);
            } else {
              print('Image ID is null, skipping.');
            }
          }
        }

        posts.add({
          'id': document.$id,
          'title': title,
          'content': content,
          'images': imageUrls,
          'type': type,
        });
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }

    return posts;
  }

  Future<List<Map<String, dynamic>>> fetchPostsByUserId(String userId) async {
    List<Map<String, dynamic>> posts = [];

    try {
      final response = await databases!.listDocuments(
        databaseId: Config.databaseId,
        collectionId: Config.postCollectionId,
        queries: [
          Query.equal('userId', userId) // Filter by userId
        ],
      );

      for (var document in response.documents) {
        String title = document.data['title'] ?? "No Title";
        String content = document.data['content'] ?? "No Content";
        int type = document.data['type'] ?? 0;

        List<dynamic>? imageIds = document.data['image'];
        List<String> imageUrls = [];

        if (imageIds != null) {
          for (var imageId in imageIds) {
            if (imageId != null) {
              String imageUrl = await getImageUrl(imageId);
              imageUrls.add(imageUrl);
            } else {
              print('Image ID is null, skipping.');
            }
          }
        }

        posts.add({
          'id': document.$id,
          'title': title,
          'content': content,
          'images': imageUrls,
          'type': type,
        });
      }
    } catch (e) {
      print('Error fetching posts by userId: $e');
    }

    return posts;
  }

  Future<String> getImageUrl(String imageId) async {
    try {
      final file = await storage!.getFile(
        bucketId: Config.bucketId,
        fileId: imageId,
      );
      if (file.$id != null) {
        String imageUrl =
            "${Config.endpoint}/storage/buckets/${Config.bucketId}/files/${file.$id}/view?project=${Config.projectId}&mode=admin";
        return imageUrl;
      } else {
        print('File not found for image ID: $imageId');
        return '';
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
  }

  void dispose() {
    // Clean up the real-time subscription
    postSubscription?.cancel();
  }
}
