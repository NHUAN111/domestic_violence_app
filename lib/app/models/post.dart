class Post {
  final String id;
  late final String title;
  late final String content;
  late final List<String> image;
  late final int type;

  Post({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      type: json['type'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'images': image,
      'type': type,
    };
  }
}
