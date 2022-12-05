class PostRequest {
  final String title;
  final String content;

  PostRequest({ required this.title, required this.content});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

}
