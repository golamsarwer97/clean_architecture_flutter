import '../../domin/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.posterId,
    required super.topics,
    required super.updateAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'poster_id': posterId,
      'topics': topics,
      'update_at': updateAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      posterId: map['poster_id'] as String,
      topics: List<String>.from((map['topics'] ?? [])),
      updateAt: map['update_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['update_at']),
    );
  }
}
