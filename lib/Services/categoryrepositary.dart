import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/Model/news_article_model.dart';
import 'package:http/http.dart' as http;

class CategoryNews {
  List<NewsArticleModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=3b24d25b40e04143903f2a4c2d7f95ae';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          NewsArticleModel newsarticleModel = NewsArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          news.add(newsarticleModel);
        }
      });
    }
  }
}
