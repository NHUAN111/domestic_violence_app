part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const signup = _Paths.signup;
  static const signin = _Paths.signin;
  static const settingPhone = _Paths.settingPhone;
  static const detailPost = _Paths.detailPost;
  static const detaiPhone = _Paths.detaiPhone;
  static const splash = _Paths.splash;
  static const profileDetail = _Paths.profileDetail;
  static const profileEdit = _Paths.profileEdit;
  static const sosview = _Paths.sosview;
  static const callpoliceview = _Paths.callpolice;
  static const smsconfig = _Paths.smsconfig;
  static const smsaddtitle = _Paths.smsaddtitle;
  static const recordfirst = _Paths.recordfirst;
  static const recordsecond = _Paths.recordsecond;
  static const recordthird = _Paths.recordthird;
  static const recordlist = _Paths.recordlist;
  static const locationmap = _Paths.locationmap;
  static const sharelocationview = _Paths.sharelocationview;
  static const safeplacesview = _Paths.safeplacesview;
  static const calmconnerScreen = _Paths.calmconnerScreen;
  static const test = _Paths.test;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const signup = '/signup';
  static const signin = '/signin';
  static const settingPhone = '/settingPhone';
  static const detailPost = '/detailPost';
  static const detaiPhone = '/detaiPhone';
  static const splash = '/splash';
  static const profileDetail = '/profileDetail';
  static const profileEdit = '/profileEdit';
  static const sosview = '/sosview';
  static const callpolice = '/callpolice';
  static const smsconfig = '/smsconfig';
  static const smsaddtitle = '/smsaddtitle';
  static const recordfirst = '/recordfirst';
  static const recordsecond = '/recordsecond';
  static const recordthird = '/recordthird';
  static const recordlist = '/recordlist';
  static const locationmap = '/locationmap';
  static const sharelocationview = '/sharelocationview';
  static const safeplacesview = '/safeplacesview';
  static const calmconnerScreen = '/calmconnerScreen';
  static const test = '/test';
}
