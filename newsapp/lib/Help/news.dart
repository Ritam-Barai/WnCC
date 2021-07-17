
import 'dart:convert';

import 'package:newsapp/model/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi/newsapi.dart';
class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    int index = 0;

    /*var response= await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=1adfc07e906349308f08a2ee742da953'));
    var jsonData =jsonDecode(response.body);
    if(jsonData["status"]=='ok'){
      jsonData["articles"].forEach((element){

        if(element["urlTOImage"]!= null && element["description"]!= null){

          ArticleModel articleModel= ArticleModel(
            title: element['title'],
            author:element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content']
          );

          news.add(articleModel);
        }
      });*/
    var newsApi = NewsApi(
      //  dioOptions: dioOptions,
      //  interceptors: interceptors,
      debugLog: true,
      apiKey: 'foo',
    );


    newsApi.apiKey = '1adfc07e906349308f08a2ee742da953';
    ArticleResponse topHeadlines = await newsApi.topHeadlines(
    country: 'in',
//    category: category,
//    sources: sources,
//    q: q,
      language: 'en',
//    pageSize: pageSize,
//    page: page,
    );
    for(index=0;index<20;index++){
        if(topHeadlines.articles[index].urlToImage!= null && topHeadlines.articles[index].description!= null) {
          ArticleModel articleModel = ArticleModel(
              title: topHeadlines.articles[index].title,
              author: topHeadlines.articles[index].author,
              description: topHeadlines.articles[index].description,
              url: topHeadlines.articles[index].url,
              urlToImage: topHeadlines.articles[index].urlToImage,
              content: topHeadlines.articles[index].content
          );


          news.add(articleModel);
        }
        }




  }
}


class CategoryNewsClass{
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    int index = 0;

    var newsApi = NewsApi(
      //  dioOptions: dioOptions,
      //  interceptors: interceptors,
      debugLog: true,
      apiKey: 'foo',
    );


    newsApi.apiKey = '1adfc07e906349308f08a2ee742da953';
    ArticleResponse topHeadlines = await newsApi.topHeadlines(
      country: 'in',
     category: 'category',
//    sources: sources,
//    q: q,
      language: 'en',
//    pageSize: pageSize,
//    page: page,
    );
    for(index=0;index<20;index++){
      if(topHeadlines.articles[index].urlToImage!= null && topHeadlines.articles[index].description!= null) {
        ArticleModel articleModel = ArticleModel(
            title: topHeadlines.articles[index].title,
            author: topHeadlines.articles[index].author,
            description: topHeadlines.articles[index].description,
            url: topHeadlines.articles[index].url,
            urlToImage: topHeadlines.articles[index].urlToImage,
            content: topHeadlines.articles[index].content
        );


        news.add(articleModel);
      }
    }




  }
}

