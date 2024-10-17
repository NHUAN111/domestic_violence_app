import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteUser.dart';
import 'package:project_domestic_violence/app/data/repository/authRepository.dart';
import 'package:project_domestic_violence/app/modules/SignIn/signin_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(AuthRepository(AppWriteUserProvider())),
    );
  }
}
