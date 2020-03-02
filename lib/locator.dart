
import 'package:flutterui_2/data/newsRepository.dart';
import 'package:flutterui_2/data/news_api_client.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();


void setupLocator(){
  locator.registerLazySingleton(()=>NewsAPIClient());
  locator.registerLazySingleton(()=>NewsRepository());
}