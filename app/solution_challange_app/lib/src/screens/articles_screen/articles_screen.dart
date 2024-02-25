import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/screens/articles_screen/widgets/articles_list_view_widget.dart';
import 'package:solution_challange_app/src/services/article_service.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ArticleListViewWidget(articlesFuture: ArticleService().getAllArticles(),);
  }
}