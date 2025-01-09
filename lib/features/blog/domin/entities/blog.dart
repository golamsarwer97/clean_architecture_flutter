class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String posterId;
  final List<String> topics;
  final DateTime updateAt;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.posterId,
    required this.topics,
    required this.updateAt,
  });
}
