class RecordModel {
  String? userId;
  List<String>? images;
  String name;
  int sex;
  String address;
  String desc;

  // Constructor
  RecordModel({
    this.userId,
    this.images,
    required this.name,
    required this.sex,
    required this.address,
    required this.desc,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      userId: json['userId'],
      images: List<String>.from(json['images'] ?? []),
      name: json['name'],
      sex: json['sex'],
      address: json['address'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'images': images,
      'name': name,
      'sex': sex,
      'address': address,
      'desc': desc,
    };
  }
}
