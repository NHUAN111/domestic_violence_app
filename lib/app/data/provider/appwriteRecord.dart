import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:project_domestic_violence/app/data/provider/config.dart';
import 'package:project_domestic_violence/app/models/record.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppwriteRecord {
  Client client = Client();
  Databases? databases;
  Storage? storage;

  AppwriteRecord() {
    // Initialize client
    client
        .setEndpoint(Config.endpoint)
        .setProject(Config.projectId)
        .setSelfSigned(status: true);

    databases = Databases(client);
    storage = Storage(client);
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> fileIds = [];

    for (String imagePath in imagePaths) {
      try {
        final fileName = imagePath.split('/').last;
        final file = await storage!.createFile(
          bucketId: Config.recordbucketId,
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

  Future<void> createRecord(RecordModel record, List<String> imagePaths) async {
    // Step 1: Upload images first
    List<String> imageIds = await uploadImages(imagePaths);

    if (imageIds.isEmpty) {
      print('Cannot create record because image upload failed.');
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
      // Create the record in the database
      final response = await databases!.createDocument(
        databaseId: Config.databaseId,
        collectionId: Config.recordCollectionId,
        documentId: ID.unique(),
        data: {
          'userId': userId,
          'name': record.name,
          'sex': record.sex,
          'address': record.address,
          'desc': record.desc,
          'images': imageIds,
        },
      );
      print('Record created successfully: ${response.data}');
    } catch (e) {
      print('Error creating record: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchRecordsByUserId(String userId) async {
    List<Map<String, dynamic>> records = [];

    try {
      final response = await databases!.listDocuments(
        databaseId: Config.databaseId,
        collectionId: Config.recordCollectionId,
        queries: [
          Query.equal('userId', userId) // Filter by userId
        ],
      );

      for (var document in response.documents) {
        String name = document.data['name'] ?? "No Name";
        int sex = document.data['sex'] ?? 0;
        String address = document.data['address'] ?? "No Address";
        String desc = document.data['desc'] ?? "No Description";

        List<dynamic>? imageIds = document.data['images'];
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

        records.add({
          'id': document.$id,
          'name': name,
          'sex': sex,
          'address': address,
          'desc': desc,
          'images': imageUrls,
        });
      }
    } catch (e) {
      print('Error fetching records: $e');
    }

    return records;
  }

  Future<String> getImageUrl(String imageId) async {
    try {
      final file = await storage!.getFile(
        bucketId: Config.recordbucketId,
        fileId: imageId,
      );
      if (file.$id != null) {
        String imageUrl =
            "${Config.endpoint}/storage/buckets/${Config.recordbucketId}/files/${file.$id}/view?project=${Config.projectId}&mode=admin";
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
}
