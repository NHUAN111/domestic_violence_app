part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const signup = _Paths.signup;
  static const signin = _Paths.signin;
  static const settingPhone = _Paths.settingPhone;
  static const detailPost = _Paths.detailPost;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const signup = '/signup';
  static const signin = '/signin';
  static const settingPhone = '/settingPhone';
  static const detailPost = '/detailPost';
}
