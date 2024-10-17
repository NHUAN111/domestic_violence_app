import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/repository/blogRepository.dart';
import 'package:project_domestic_violence/app/models/blog.dart';

class BlogController extends GetxController {
  final BlogRepository blogRepository;

  BlogController(this.blogRepository);

  var posts = <Map<String, dynamic>>[].obs;

  Future<void> createPost(
      Map<String, dynamic> blogData, List<String> imagePaths) async {
    try {
      await blogRepository.createPost(blogData, imagePaths);
      print("Blog post created successfully!");
    } catch (e) {
      print("Error creating blog post: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    return await blogRepository.fetchPosts();
  }
}
