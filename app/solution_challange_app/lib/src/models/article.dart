class Article {
  String title;
  String body;
  String source;

  Article({required this.title, required this.body, required this.source});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json["title"], body: json["article"], source: json["source"]);
  }
}
