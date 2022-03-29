import 'package:flutter/material.dart';

class NewsArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;

  NewsArticleModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  });
}
