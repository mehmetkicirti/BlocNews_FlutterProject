import 'package:flutter/material.dart';
import 'package:flutterui_2/models/news.dart';
import 'package:flutterui_2/widgets/news_page.dart';

class NewsCard extends StatelessWidget {

  final Article article;

  NewsCard({this.article});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.0,
      height: 300.0,
      child: Hero(
        tag: article.url != null ? article.title : article.url,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage(article: article,)));
          },
          child: Card(
            elevation: 25.0,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: LayoutBuilder(
              builder: (context,constraint){
                var _height = constraint.maxHeight;
                var _width = constraint.maxWidth;
                return Stack(
                  children: <Widget>[
                    article.urlToImage != null ? ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                      child: FadeInImage.assetNetwork(
                          fadeInDuration: Duration(milliseconds: 1000),
                          fadeInCurve: Curves.ease,
                          placeholder: "assets/images/loading.gif",
                          image: article.urlToImage,
                          fit: BoxFit.fill,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.27),

                    ) :
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FlutterLogo(
                          style: FlutterLogoStyle.stacked,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 1000),
                          size: 100,
                          textColor: Colors.indigoAccent,
                        ),
                      ),
                    ),
                    Positioned(
                      top: (_height*0.4),
                      left: _width*0.2,
                      child: ClipPath(
                        child: Container(
                          height: _height*0.2,
                          width: _width*0.8,
                          color: Colors.white.withOpacity(0.7),
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Text(
                              article.author != null ? article.author: "No Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        clipper: buildCardCustomClipper(),
                      ),
                    ),
                    Positioned(
                      top: _height*0.62,
                      left: 10,
                      right: 10,
                      child: Container(
                        width: _width*0.9,
                        child: Text(
                          article.description.length>50 ? article.description.substring(0,50) + "..." : article.description,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(1,1),
                                blurRadius: 3
                              )
                            ],
                            fontSize: 18,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2,2),
                                color: Colors.black,
                                blurRadius: 5
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Continue",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 10,),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class buildCardCustomClipper extends CustomClipper<Path>{
  final double distanceFromWall = 12;
  final double controlPointDistanceFromWall = 2;
  @override
  Path getClip(Size size) {
    final double height = size.height;
    final double halfHeight = size.height * 0.4;
    final double width = size.width;
    final Path _path = Path();
    _path.moveTo(0, halfHeight);
    _path.lineTo(0, height - distanceFromWall);
    _path.quadraticBezierTo(0 + controlPointDistanceFromWall,
        height - controlPointDistanceFromWall, 0 + distanceFromWall, height);
    _path.lineTo(width, height);
    _path.lineTo(width, 0 + 40.0);
    _path.quadraticBezierTo(width - 10, 0 + 10.0, width - 50, 0 + 15.0);

    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>true;
}
