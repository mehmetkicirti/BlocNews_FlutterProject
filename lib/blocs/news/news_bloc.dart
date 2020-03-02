import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui_2/data/newsRepository.dart';
import 'package:flutterui_2/locator.dart';
import 'package:flutterui_2/models/news.dart';
import './bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  @override
  NewsState get initialState => InitialNewsState();
  final NewsRepository _newsRepository = locator<NewsRepository>();
  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if(event is FetchByNameNewsEvent){
      yield LoadingNewsState();

      try{
        //get news
        final News news = await _newsRepository.getNewsBySearch(event.newsName,event.country);
        yield LoadedNewsState(news: news);
      }catch(e){
        debugPrint("Search Hata : $e");
        yield ErrorNewsState();
      }
    }else if(event is FetchByCategoryNewsEvent){
      yield LoadingNewsState();
      try{
        final News news = await _newsRepository.getNewsByCategory(event.categoryName,event.country);
        yield LoadedNewsState(news: news);
      }catch(e){
        debugPrint("Category Hata : $e");
        yield ErrorNewsState();
      }
    }else if (event is FetchInitialNewsEvent){
      yield LoadingNewsState();
      try{
        final News news = await _newsRepository.getInitialNews(event.country);
        yield LoadedNewsState(news: news);
      }catch(e){
        debugPrint("Initial Hata : $e");
        yield ErrorNewsState();
      }
    }
  }
}
