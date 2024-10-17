import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteUser.dart';
import 'package:project_domestic_violence/app/data/repository/authRepository.dart';
import 'package:project_domestic_violence/app/modules/SignUp/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(AuthRepository(AppWriteUserProvider())),
    );
  }
}
