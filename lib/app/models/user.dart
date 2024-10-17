class UserModel {
  String? userName;
  String? email;
  String? accountId;

  UserModel({
    this.userName,
    this.email,
    this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'accountId': accountId,
    };
  }

  // Đảm bảo rằng bạn có thể khởi tạo từ JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      accountId: json['accountId'],
    );
  }
}
