import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterui_2/models/news.dart';

abstract class NewsState extends Equatable {
  const NewsState([List props = const []]):super();
}

class InitialNewsState extends NewsState {
  @override
  List<Object> get props => [];
}
class LoadingNewsState extends NewsState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class LoadedNewsState extends NewsState{
  final News news;
  LoadedNewsState({@required this.news}):super([news]);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ErrorNewsState extends NewsState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}