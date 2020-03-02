import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui_2/blocs/news/bloc.dart';
import 'package:flutterui_2/custom_shape_clipper.dart';
import 'package:flutterui_2/models/category.dart';
import 'package:flutterui_2/widgets/news_card.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {

  var _searchKey = TextEditingController();
  bool _showFirst = true;
  List<Category> _categories;
  int selectedIndex = 6;
  bool _switchControl = false;
  var textHolder = "USA";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _categories = List.generate(
          categories.length,
          (index) =>
              Category(categories[index].categoryName, categories[index].icon));

    });
  }
  void toggleSwitch(bool value){

  }


  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<NewsBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 216, 157, 149),
              Color.fromARGB(255, 160, 186, 187),
              Color.fromARGB(255, 175, 145, 169),
            ],begin: Alignment.centerLeft,end: Alignment.bottomRight
          )
        ),
        child: Stack(
          children: <Widget>[
            buildClipPath(context),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildSearchBar(context, _bloc),
              ],
            ),
            Positioned(
              left: 10,
              right: 10,
              top: 100,
              child: Container(
                height: 175,
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;

                      });
                      _bloc.add(FetchByCategoryNewsEvent(
                          categoryName: _categories[index].categoryName,country: _switchControl));
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.easeOutSine,
                      height: selectedIndex == index ? 175 : 50,
                      width: selectedIndex == index ? 175 : 150,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid),
                          boxShadow: [
                            BoxShadow(
                                color: selectedIndex == index
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.black.withOpacity(0.3),
                                blurRadius: 20.0)
                          ],
                          color: Colors.white.withOpacity(0.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          AnimatedContainer(
                              duration: Duration(milliseconds: 1500),
                              curve: Curves.bounceOut,
                              height: 50,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.7),
                                    blurRadius: 20.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 5.0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      10.0, // horizontal, move right 10
                                      10.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Icon(
                                _categories[index].icon,
                                size: 48,
                              )),
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 1500),
                            curve: Curves.bounceIn,
                            child: Text(_categories[index].categoryName),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "PlayfairDisplay",
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: _categories.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  var height = constraint.maxHeight;
                  var width = constraint.maxWidth;
                  return Container(
                    margin:
                        EdgeInsets.only(bottom: height * 0.02, left: width * 0.3),
                    height: height * 0.52,

                    width: width * 0.8,
                    child: BlocBuilder(
                      bloc: _bloc,
                      builder: (context, NewsState state) {
                        if (state is InitialNewsState) {
                          _bloc.add(FetchInitialNewsEvent(country: _switchControl));
                          return Center(
                            child: Text("haber sec"),
                          );
                        } else if (state is LoadingNewsState) {
                          return Center(
                            child: CircularProgressIndicator(backgroundColor: Colors.black,),
                          );
                        } else if (state is LoadedNewsState) {
                          final news = state.news;
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return NewsCard(
                                article: news.articles[index],
                              );
                            },
                            itemCount: news.articles.length,
                            scrollDirection: Axis.horizontal,
                          );
                        } else {
                          return Center(
                            child: Container(
                              child: Image.asset("assets/images/error.gif"),
                              alignment: Alignment.center,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              bottom: 20,
              child: Transform.rotate(
                angle: -1.575,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.2,
                      horizontal: 0),
                  width: 130,
                  height: 70,
                  child: Text(
                    "NEWS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1,bottom: MediaQuery.of(context).size.width*0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Switch(
                    onChanged: (deger){
                      if(deger){
                        setState(() {
                          _switchControl = !_switchControl;
                          textHolder="TR";
                        });
                        _bloc.add(FetchInitialNewsEvent(country: _switchControl));
                      }else{
                        setState(() {
                          _switchControl = !_switchControl;
                          textHolder = "USA";
                        });
                        _bloc.add(FetchInitialNewsEvent(country: _switchControl));
                      }
                    },
                    value: _switchControl,
                    activeColor: Theme.of(context).accentColor,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                  Text(
                    "$textHolder",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    _bloc.close();
  }

  AnimatedCrossFade buildSearchBar(BuildContext context, NewsBloc _bloc) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 1500),
      firstChild: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: MediaQuery.of(context).size.width * 0.42),
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              color: Colors.white12),
          child: IconButton(
            color: Colors.white,
            iconSize: 35,
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                if (_searchKey != null) {
                  _searchKey.text = "";
                }
                _showFirst = !_showFirst;
              });
            },
          ),
        ),
      ),
      firstCurve: Curves.easeIn,
      secondChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: TextFormField(
          controller: _searchKey,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _showFirst = !_showFirst;
                  });
                  if (_searchKey.text != null) {
                    _bloc.add(FetchByNameNewsEvent(newsName: _searchKey.text,country: _switchControl));
                  }
                },
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              fillColor: Colors.white,
              filled: true,
              hintText: "Search a new .."),
        ),
      ),
      secondCurve: Curves.fastOutSlowIn,
      crossFadeState:
          _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  ClipPath buildClipPath(BuildContext context) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).backgroundColor
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      ),
    );
  }
}
