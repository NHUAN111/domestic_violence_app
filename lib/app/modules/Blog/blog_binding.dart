import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';
import 'package:project_domestic_violence/app/data/repository/blogRepository.dart';
import 'package:project_domestic_violence/app/modules/Blog/blog_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(
      () => BlogController(BlogRepository(AppWritePostProvider())),
    );
  }
}
