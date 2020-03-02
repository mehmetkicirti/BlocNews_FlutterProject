import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui_2/blocs/news/bloc.dart';
import 'package:flutterui_2/locator.dart';
import 'package:flutterui_2/widgets/landing_page.dart';

void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowMaterialGrid: false,
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 41, 189, 193),
        primaryColor: Color.fromARGB(255, 145, 63, 146),
        accentColor: Color.fromARGB(255, 234, 255, 123),
        fontFamily: "PlayfairDisplay",
      ),
      debugShowCheckedModeBanner: false,
      title: "Flutter UI New App",
      home: BlocProvider<NewsBloc>(create: (context)=>NewsBloc(),child: LandingPage()),
    );
  }
}



