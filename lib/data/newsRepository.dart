import 'package:flutterui_2/data/news_api_client.dart';
import 'package:flutterui_2/locator.dart';
import 'package:flutterui_2/models/news.dart';

class NewsRepository{
  NewsAPIClient _apiClient = locator<NewsAPIClient>();
  Future<News> getNewsByCategory(String categoryName,bool country) async{
    return _apiClient.getByCategoryNews(categoryName,country);
  }
  Future<News> getNewsBySearch(String searchNew,bool country) async{
    return _apiClient.getBySearchNameNews(searchNew,country);
  }
  Future<News> getInitialNews(bool country) async{
    return _apiClient.getInitialNews(country);
  }
}