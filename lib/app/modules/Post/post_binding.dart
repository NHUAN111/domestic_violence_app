import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';
import 'package:project_domestic_violence/app/data/repository/postRepository.dart';
import 'package:project_domestic_violence/app/modules/Post/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(PostRepository(AppWritePostProvider())),
    );
  }
}
