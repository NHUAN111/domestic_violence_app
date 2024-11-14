class UserModel {
  String? userName;
  String? email;
  String? password;
  String? accountId;

  UserModel({
    this.userName,
    this.email,
    this.password,
    this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'accountId': accountId,
    };
  }

  // Đảm bảo rằng bạn có thể khởi tạo từ JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      accountId: json['accountId'],
    );
  }
}
