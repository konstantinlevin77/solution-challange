import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/article.dart';
import 'package:solution_challange_app/src/screens/articles_screen/widgets/article_list_tile_widget.dart';

class ArticleListViewWidget extends StatelessWidget {
  final Future<List<Article>> articlesFuture;

  const ArticleListViewWidget({Key? key, required this.articlesFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Article>>(
        future: articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No articles available.');
          } else {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleListTileWidget(article: articles[index]);
              },
            );
          }
        },
      ),
    );
  }
}