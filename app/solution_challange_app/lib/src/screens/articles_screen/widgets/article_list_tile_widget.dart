import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/article.dart';

class ArticleListTileWidget extends StatelessWidget {
  final Article article;

  const ArticleListTileWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/show-one-article", arguments: article);
      },
      child: Card(
        child: ListTile(
            title: Text(
              article.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.body,
                  maxLines: 4,
                  overflow: TextOverflow.fade,
                ),
              ],
            )),
      ),
    );
  }
}
