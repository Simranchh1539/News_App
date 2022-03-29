import 'package:flutter/material.dart';
import 'package:newsapp/Model/category_model.dart';
import 'package:newsapp/Model/news_article_model.dart';
import 'package:newsapp/Services/NewsRepositary.dart';
import 'package:newsapp/Services/data.dart';
import 'package:newsapp/Widgets/Newswidget.dart';
import 'package:newsapp/Widgets/tilefront.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> category = new List<CategoryModel>();
  List<NewsArticleModel> articles = new List<NewsArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    category = getcategories();
    getNews();
  }

  getNews() async {
    NewsRepositary newnews = NewsRepositary();
    await newnews.getNews();
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
                color: Colors.pink[300],
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                //padding: EdgeInsets.only(top: 16, left: 20, right: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      height: 70,
                      child: ListView.builder(
                        itemCount: category.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return TileFront(
                            imageUrl: category[index].imageUrl,
                            categoryname: category[index].categoryname,
                          );
                        },
                      ),
                    ),

                    //News
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 20, right: 20),
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        //scrollDirection: Axis.vertical,
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
                ),
              ),
            ),
    );
  }
}
