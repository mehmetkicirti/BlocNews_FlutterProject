import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent([List props = const []]);
}
class FetchByCategoryNewsEvent extends NewsEvent{
  final String categoryName;
  final bool country;
  FetchByCategoryNewsEvent({@required this.categoryName,this.country}):super([categoryName,country]);
  @override
  List<Object> get props => [];
}
class FetchByNameNewsEvent extends NewsEvent{
  @override
  List<Object> get props => [];
  final String newsName;
  final bool country;
  FetchByNameNewsEvent({this.newsName,this.country}):super([newsName,country]);
}
class FetchInitialNewsEvent extends NewsEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
  final bool country;
  FetchInitialNewsEvent({this.country}):super([country]);
}