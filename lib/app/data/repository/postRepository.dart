import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';

class PostRepository {
  final AppWritePostProvider appWritePostProvider;

  PostRepository(this.appWritePostProvider);

  Future<void> createPost(
      Map<String, dynamic> blogData, List<String> imagePaths) {
    return appWritePostProvider.createPost(blogData, imagePaths);
  }

  Future<List<Map<String, dynamic>>> fetchPosts() {
    return appWritePostProvider.fetchPosts();
  }

  Future<List<Map<String, dynamic>>> fetchPostsByUserId(String id) {
    return appWritePostProvider.fetchPostsByUserId(id);
  }
}
