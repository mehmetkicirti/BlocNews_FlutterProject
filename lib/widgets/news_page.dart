import 'package:flutter/material.dart';
import 'package:flutterui_2/models/news.dart';
import 'package:url_launcher/url_launcher.dart';
class NewsPage extends StatelessWidget {
  final Article article;

  NewsPage({@required this.article});

  String printWithoutExtra(String extra){
    String newSentence=extra;
    if(extra.indexOf("[")>=0){
      newSentence = extra.substring(0,extra.indexOf("["));
    }
    return newSentence;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        var _height = constraint.maxHeight;
        var _width = constraint.maxWidth;
        return Stack(
          children: <Widget>[
            NestedScrollView(
              headerSliverBuilder: (context,innerBoxIsScrolled){
                return<Widget>[
                  SliverAppBar(
                    expandedHeight: 300.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(article.author,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        background: Hero(
                  tag:  article.url != null ? article.title : article.url,
                          child: Image.network(
                            article.urlToImage!=null?article.urlToImage : FlutterLogo(),
                            fit: BoxFit.cover,
                          ),
                        )),
                    elevation: 20,
                    forceElevated: true,
                    stretch: true,
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: _width*0.9,
                      child: Text(
                        printWithoutExtra(article.content),
                        style: TextStyle(
                          fontSize: 27,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _width*0.1,horizontal:_width*0.2 ),
                      height: _height*0.085,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(2,3),
                            blurRadius: 7
                          )
                        ],
                        color: Theme.of(context).backgroundColor.withOpacity(0.7),
                      ),
                      child: InkWell(
                        onTap: () async=>_goSite(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Go Site",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                              ),
                            ),
                            SizedBox(width: 25,),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 28,
                              color: Colors.white,
                            )
                          ] ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
  _goSite() async{

    if (await canLaunch(article.url)) {
      await launch(article.url);
    } else {
      throw 'Could not launch ${article.url}';
    }
  }
}
