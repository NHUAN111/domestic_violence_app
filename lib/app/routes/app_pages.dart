import 'package:get/get.dart';
import 'package:project_domestic_violence/app/modules/Phone/phone_detail_view.dart';
import 'package:project_domestic_violence/app/modules/Phone/phone_view.dart';
import 'package:project_domestic_violence/app/modules/Profile/profile_detail_view.dart';
import 'package:project_domestic_violence/app/modules/Profile/profile_edit_view.dart';
import 'package:project_domestic_violence/app/modules/Realtime/realtime_screen.dart';
import 'package:project_domestic_violence/app/modules/SignIn/signin_binding.dart';
import 'package:project_domestic_violence/app/modules/SignIn/signin_view.dart';
import 'package:project_domestic_violence/app/modules/SignUp/signup_binding.dart';
import 'package:project_domestic_violence/app/modules/SignUp/signup_view.dart';
import 'package:project_domestic_violence/app/modules/Splash/splash_view.dart';
import 'package:project_domestic_violence/app/modules/ViewAfterDelay/callpolice_view.dart';
import 'package:project_domestic_violence/app/modules/ViewAfterDelay/sos_view.dart';
import 'package:project_domestic_violence/app/modules/main_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const MainView(),
      binding: null,
    ),
    GetPage(
        name: _Paths.signup,
        page: () => const SignUpView(),
        binding: SignUpBinding()),
    GetPage(
      name: _Paths.detailPost,
      page: () => const SignUpView(),
      binding: null,
    ),
    GetPage(
        name: _Paths.signin,
        page: () => const SignInView(),
        binding: SignInBinding()),
    GetPage(
      name: _Paths.settingPhone,
      page: () => PhoneView(),
      binding: null,
    ),
    GetPage(
      name: _Paths.detaiPhone,
      page: () => PhoneDetailView(),
      binding: null,
    ),
    GetPage(
      name: _Paths.splash,
      page: () => SplashView(),
      binding: null,
    ),
    GetPage(
      name: _Paths.profileDetail,
      page: () => ProfileDetailView(),
      binding: null,
    ),
    GetPage(
      name: _Paths.profileEdit,
      page: () => ProfileEditView(),
      binding: null,
    ),
    GetPage(
      name: _Paths.test,
      page: () => RealtimeScreen(),
      binding: null,
    ),
    GetPage(
      name: _Paths.sosview,
      page: () => SoSViewAnimation(),
      binding: null,
    ),
    GetPage(
      name: _Paths.callpolice,
      page: () => CallPoliceView(),
      binding: null,
    ),
  ];
}
