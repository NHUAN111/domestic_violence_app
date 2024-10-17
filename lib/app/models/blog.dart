class Blog {
  final String id;
  final String title;
  final String content;
  final List<String> image;
  final int type;

  Blog(
      {required this.id,
      required this.type,
      required this.title,
      required this.content,
      required this.image});

  // Factory method to create a Blog instance from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      type: json['type'],
      id: json['id'] ?? '', // Ensure id is a string
      title: json['title'] ?? '', // Ensure title is a string
      content: json['content'] ?? '', // Ensure content is a string
      image: List<String>.from(json['images'] ?? []), // Default to empty list
    );
  }
}
