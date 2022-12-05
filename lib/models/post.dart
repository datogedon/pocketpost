class Post {
  final String id;
  final String title;
  final String content;

  Post({required this.id, required this.title, required this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

}
