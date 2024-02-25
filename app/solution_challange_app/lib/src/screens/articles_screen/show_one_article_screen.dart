import 'package:flutter/material.dart';
import 'package:solution_challange_app/src/models/article.dart';

class ShowOneArticleScreen extends StatelessWidget {
  const ShowOneArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Article article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(40,70,40,40),
          child: Column(children: [
            Container(
              child: Text(
                article.title,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              child: Text(
                article.body,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Container(
              child: Text(
                "Source: ${article.source}",
                style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
