import 'dart:convert';

import 'package:flutterui_2/models/news.dart';
import 'package:http/http.dart' as http;

class NewsAPIClient{
  //97eaea2e1b774ce7842767ba172f2e31 => api key news
  static const apiKey="apiKey=97eaea2e1b774ce7842767ba172f2e31";
  static const baseURL = "https://newsapi.org/v2/top-headlines";
  final http.Client httpClient = http.Client();

  Future<News> getByCategoryNews(String categoryName,bool country) async{
    String lang = country ? "tr" : "us";
    final categoryURL = "$baseURL?category=$categoryName&country=$lang&$apiKey";
    var response = await httpClient.get(categoryURL);
    if(response.statusCode != 200){
      throw Exception("When is fetching data,occurred an issue.");
    }
    final responseJSON = jsonDecode(response.body);
    return News.fromMap(responseJSON);
  }
  Future<News> getBySearchNameNews(String searchNews,bool country) async{
    String lang = country ? "tr": "us";
    final searchURL = "$baseURL?q=$searchNews&country=$lang&$apiKey";
    var response = await httpClient.get(searchURL);
    if(response.statusCode != 200){
      throw Exception("When is fetching data,occurred an issue.");
    }
    final responseJSON = jsonDecode(response.body);
    return News.fromMap(responseJSON);
  }

  Future<News> getInitialNews(bool country) async{
    String year = DateTime.now().year.toString();
    String month= DateTime.now().month.toString();
    String day= DateTime.now().day.toString();
    String beforeDay = ((DateTime.now().day)-1).toString();
    String lang = country ? "tr" : "us";
    final initialUrl = "$baseURL?country=$lang&from=$year-$month-$day&to=$year-$month-$beforeDay&$apiKey";
    var response = await httpClient.get(initialUrl);
    if(response.statusCode != 200){
      throw Exception("When is fetching data,occurred an issue.");
    }
    final responseJSON = jsonDecode(response.body);
    return News.fromMap(responseJSON);
  }
}