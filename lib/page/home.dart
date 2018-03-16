import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_properties.dart';

class HomePage extends StatefulWidget {

  @override
  State createState() => new HomeState();

}

class HomeState extends State<HomePage> with TickerProviderStateMixin {

  int _selectedTab = 0;

  TabController _feedTabController;

  TabController _findTabController;

  ValueKey<int> tabBarValueKey;

  http.Client client = new http.Client();

  @override
  void initState() {
    super.initState();
    _feedTabController = new TabController(length: feedTabs.length, vsync: this);
    _findTabController = new TabController(length: findTabs.length, vsync: this);
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _body(_selectedTab),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        currentIndex: _selectedTab,
        items: bottomBarNavigationItems,
      ),
    );
  }

  Scaffold _body(int selectedBottomTab) {
    switch (selectedBottomTab) {
      case 0:
        return _feed();
      case 1:
        return _explore();
      default:
        return new Scaffold();
    }
  }

  /*
   *  Feed
   */

  Scaffold _feed() => new Scaffold(
    appBar: new AppBar(
      title: new TabBar(
        tabs: feedTabs,
        labelStyle: new TextStyle(fontFamily: 'Itim'),
        controller: _feedTabController,
      ),
    ),
    body: new TabBarView(children: [
      new Container(
        key: new PageStorageKey('feed_global'),
        child: new ListView.builder(itemBuilder: _dummyItem, itemCount: 200,),
      ),
      new Container(
        key: new PageStorageKey('feed_following'),
        child: new ListView.builder(itemBuilder: _dummyItem, itemCount: 200,),
      ),
    ], controller: _feedTabController,),
  );


  /*
   *  Explore
   */

  Scaffold _explore() {
    return new Scaffold(
      appBar: new AppBar(
        title: new TabBar(
          tabs: findTabs,
          labelStyle: new TextStyle(fontFamily: 'Itim'),
          controller: _findTabController,
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: new TabBarView(children: [
        new Container(child: _exploreChild('Anime'),),
        new Container(child: _exploreChild('Manga'),),
      ], controller: _findTabController),
    );
  }

  Scaffold _exploreChild(String type) => new Scaffold(
    body: _exploreChildContainer(type),
  );

  Widget _exploreChildContainer(String type) {
    Widget child;
    switch (type) {
      case 'Anime':
        return _exploreAnimeContainer();
        break;
      case 'Manga':
        child = _exploreMangaContainer();
        break;
      default:
        child = _exploreDummyContainer();
      break;
    }
    return new Container(
      key: new PageStorageKey('find_$type'),
      child: child,
    );
  }

  Widget _exploreAnimeContainer() {
    return new ListView.builder(itemBuilder: _exploreAnimeContent, itemCount: 1,);
  }

  Widget _exploreMangaContainer() {
    return new ListView.builder(itemBuilder: _exploreMangaContent, itemCount: 1,);
  }

  Widget _exploreDummyContainer() {
    return new ListView.builder(itemBuilder: _dummyItem, itemCount: 200,);
  }

  Widget _exploreAnimeContent(BuildContext context, index) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Trending This Week', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Top Airing', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Top Upcoming', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Highest Rated', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Most Popular', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
      ],
    );
  }

  Widget _exploreMangaContent(BuildContext context, index) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Trending This Week', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Top Publishing', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Highest Rated', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
        new Padding(padding: new EdgeInsets.all(10.0),
          child: new Text('Most Popular', style: new TextStyle(
            fontFamily: 'Delius',
            fontWeight: FontWeight.w700,
          ),),
        ),
      ],
    );
  }

  Widget _dummyItem(BuildContext context, int index) {
    return new ListTile(
      title: new Text('Dummy item #$index', style: new TextStyle(fontFamily: 'Delius'),),
    );
  }

}
