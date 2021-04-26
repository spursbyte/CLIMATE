import 'package:clima_app/Constants/articles_constant.dart';
import 'package:clima_app/HelpingWidgets/article_helpers.dart';
import 'package:flutter/material.dart';

class ArticleHome extends StatefulWidget {
  @override
  _ArticleHomeState createState() => _ArticleHomeState();
}

class _ArticleHomeState extends State<ArticleHome> {
  List<Map<String, String>> articleData = articleBlogData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(child: Container(
            child: ListView.builder(
                itemCount: articleData.length,
                itemBuilder: (context, index) {
                  return ArticleBlogTile(
                      imgUrl: articleData[index]['imgUrl'],
                      title: articleData[index]['title'],
                      source: articleData[index]['source'],
                      desc: articleData[index]['desc'],
                      postUrl: articleData[index]['postUrl']);
                }),
          )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
