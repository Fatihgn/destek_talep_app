class Posts {
  final List<PostModel> posts;
  Posts({required this.posts});

  factory Posts.fromJson(Map<String, dynamic>? json) {
    List<PostModel> posts = [];
    if (json != null) {
      if (json["posts"] != null) {
        for (var i in json['posts']) {
          posts.add(PostModel.fromJson(i));
        }
      }
    }

    return Posts(posts: posts);
  }
}

class PostModel {
  final String title, description, date, id;
  final bool isCheck;
  PostModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.id,
      required this.isCheck});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        title: json['title'],
        description: json['description'],
        date: json['date'],
        id: json['id'],
        isCheck: json['isCheck']);
  }
}
