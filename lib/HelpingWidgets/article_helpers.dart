import 'package:clima_app/Screens/Article/article_desc.dart';
import 'package:flutter/material.dart';
class ArticleBlogTile extends StatefulWidget {
  final String imgUrl,title,source, postUrl,desc;
  ArticleBlogTile({@required this.imgUrl, @required this.title, @required this.source, @required this.desc, @required this.postUrl});
  @override
  _ArticleBlogTileState createState() => _ArticleBlogTileState();
}

class _ArticleBlogTileState extends State<ArticleBlogTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>ArticleDescription(
            imgUrl: widget.imgUrl,
            title: widget.title,
            source: widget.source,
            desc: widget.desc,
            postUrl: widget.postUrl)));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(widget.imgUrl,
                  width: MediaQuery.of(context).size.width - 25,
                  height: 180,
                  fit: BoxFit.cover,),
              ),
            ),
            SizedBox(height: 5.0),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width / 1.25 - 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text(
                        widget.source,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}
