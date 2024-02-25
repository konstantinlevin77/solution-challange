import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:solution_challange_app/src/models/article.dart';

class ArticleService {
  Future<List<Article>> getAllArticles() async {
    final jsonString = await rootBundle.loadString("assets/articles.json");
    final List<dynamic> jsonList = jsonDecode(jsonString);

    final articleList = jsonList.map((e) => Article.fromJson(e)).toList();
    return articleList;
  }
}
