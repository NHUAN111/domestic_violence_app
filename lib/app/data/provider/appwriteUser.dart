import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:project_domestic_violence/app/data/provider/config.dart';
import 'package:project_domestic_violence/app/models/user.dart';

class AppWriteUserProvider {
  Client client = Client();

  Account? account;
  Databases? databases;

  AppWriteUserProvider() {
    client
        .setEndpoint(Config.endpoint)
        .setProject(Config.projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
  }

  Future<models.User> signup(Map map) async {
    try {
      final response = await account!.create(
        userId: map["userId"],
        email: map["email"],
        password: map["password"],
        name: map["name"],
      );

      await databases!.createDocument(
        databaseId: Config.databaseId,
        collectionId: Config.userCollectionId,
        documentId: ID.unique(),
        data: {
          'username': map['name'],
          'email': map['email'],
          'password': map['password'],
          'accountID': response.$id,
        },
      );

      return response;
    } catch (e) {
      print("Error in signup: $e");
      throw e;
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final session = await account!.createEmailPasswordSession(
        email: email,
        password: password,
      );

      final user = await account!.get();
      final userModel = UserModel.fromJson({
        'userName': user.name,
        'email': user.email,
        'password': password,
        'accountId': user.$id,
      });

      return userModel;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
