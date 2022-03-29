import 'package:flutter/material.dart';
import 'package:newsapp/Model/news_article_model.dart';
import 'package:newsapp/Services/categoryrepositary.dart';
import 'package:newsapp/Widgets/Newswidget.dart';
import 'package:flutter_share/flutter_share.dart';

class Category extends StatefulWidget {
  final String category;
  Category({this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NewsArticleModel> articles = new List<NewsArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newnews = CategoryNews();
    await newnews.getNews(widget.category);
    articles = newnews.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.5,
        actions: [IconButton(icon: Icon(Icons.share), onPressed: share)],
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                children: <Widget>[
                  //News
                  Container(
                    padding: EdgeInsets.only(
                        top: 16, left: 15, right: 20, bottom: 15),
                    child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                        );
                      },
                    ),
                  ),
                ],
              )),
            ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }
}
