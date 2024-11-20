class SMSModel {
  int? smsId;
  String? userId;

  String? desc;

  SMSModel({
    this.smsId,
    this.userId,
    this.desc,
  });

  factory SMSModel.fromJson(Map<String, dynamic> json) {
    return SMSModel(
      smsId: json['smsId'],
      userId: json['userId'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'smsId': smsId,
      'userId': userId,
      'desc': desc,
    };
  }
}
