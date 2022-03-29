import 'package:flutter/material.dart';
import 'package:newsapp/Pages/article.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  NewsTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ),
          ),
        );
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//3b24d25b40e04143903f2a4c2d7f95ae