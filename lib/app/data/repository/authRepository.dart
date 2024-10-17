import 'package:appwrite/models.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteUser.dart';
import 'package:project_domestic_violence/app/models/user.dart';

class AuthRepository {
  final AppWriteUserProvider appWriteProvider;
  AuthRepository(this.appWriteProvider);

  Future<User> signup(Map map) => appWriteProvider.signup(map);

  Future<UserModel> signin(String email, String password) =>
      appWriteProvider.login(email, password);
}
