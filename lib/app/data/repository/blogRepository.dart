import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';

class BlogRepository {
  final AppWritePostProvider appWritePostProvider;

  BlogRepository(this.appWritePostProvider);

  // Updated createPost method to support multiple images
  Future<void> createPost(
      Map<String, dynamic> blogData, List<String> imagePaths) {
    return appWritePostProvider.createPost(blogData, imagePaths);
  }

  Future<List<Map<String, dynamic>>> fetchPosts() {
    return appWritePostProvider.fetchPosts();
  }
}
