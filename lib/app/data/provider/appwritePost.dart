import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:project_domestic_violence/app/data/provider/config.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWritePostProvider {
  Client client = Client();
  Databases? databases;
  Storage? storage;

  AppWritePostProvider() {
    client
        .setEndpoint(Config.endpoint)
        .setProject(Config.projectId)
        .setSelfSigned(
            status: true); // Self-signed certificates (for local dev)

    databases = Databases(client);
    storage = Storage(client);
  }

  // Function to upload images to Appwrite storage bucket
  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> fileIds = []; // List to store the uploaded file IDs

    for (String imagePath in imagePaths) {
      try {
        final fileName =
            imagePath.split('/').last; // Extract file name from path
        final file = await storage!.createFile(
          bucketId: Config.bucketId,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: imagePath, filename: fileName),
        );
        print('Image uploaded successfully: ${file.$id}');
        fileIds.add(file.$id); // Add the uploaded file ID to the list
      } catch (e) {
        print('Error uploading image: $e');
        throw Exception('Không thể tải lên hình ảnh: $e');
      }
    }

    return fileIds; // Return the list of uploaded file IDs
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

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    List<Map<String, dynamic>> posts = [];

    try {
      final response = await databases!.listDocuments(
        databaseId: Config.databaseId,
        collectionId: Config.postCollectionId,
      );

      for (var document in response.documents) {
        // Use null-aware operators to prevent accessing null values
        String title = document.data['title'] ?? "No Title"; // Default title
        String content =
            document.data['content'] ?? "No Content"; // Default content

        // Assuming the 'image' field contains a list of image IDs
        List<dynamic>? imageIds =
            document.data['image']; // Fetching image IDs, allowing null
        List<String> imageUrls = [];

        if (imageIds != null) {
          // Fetch the URLs for each image if imageIds is not null
          for (var imageId in imageIds) {
            if (imageId != null) {
              String imageUrl =
                  await getImageUrl(imageId); // Get URL for each image
              imageUrls.add(imageUrl);
            } else {
              print('Image ID is null, skipping.');
            }
          }
        }

        // Add the post to the list with checks
        posts.add({
          'id': document.$id,
          'title': title,
          'content': content,
          'images': imageUrls,
          'type': 1,
        });
      }

      // print('Posts fetched successfully: $posts');
    } catch (e) {
      print('Error fetching posts 11: $e');
    }

    return posts;
  }

  // Function to get image URL from the storage bucket
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
        return ''; // Return an empty string if file not found
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return ''; // Return an empty string on error
    }
  }
}
