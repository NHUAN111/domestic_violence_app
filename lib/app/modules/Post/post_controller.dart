import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/repository/postRepository.dart';

class PostController extends GetxController {
  final PostRepository postRepository;

  PostController(this.postRepository);

  var posts = <Map<String, dynamic>>[].obs;

  Future<void> createPost(
      Map<String, dynamic> blogData, List<String> imagePaths) async {
    try {
      await postRepository.createPost(blogData, imagePaths);
      print("Blog post created successfully!");
    } catch (e) {
      print("Error creating blog post: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    return await postRepository.fetchPosts();
  }

  Future<List<Map<String, dynamic>>> fetchPostsByUserId(String id) async {
    return await postRepository.fetchPostsByUserId(id);
  }
}
