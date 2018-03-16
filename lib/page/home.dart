import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milk_crown/netowrk_call.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => new _HomeState();

}

class _HomeState extends State<HomePage> with TickerProviderStateMixin {

  int _selectedIndex = 0;

  List<Tab> _feedTabs = [
    new Tab(text: 'Global',),
    new Tab(text: 'Following',),
  ];

  List<Tab> _exploreTabs = [
    new Tab(text: 'Anime',),
    new Tab(text: 'Manga',),
  ];

  TabController _feedTabController;

  TabController _exploreTabController;

  http.Client _connection = new http.Client();

  List<Map> _animeTopAiring;

  List<Map> _animeTopUpcoming;

  List<Map> _animeHighestRated;

  List<Map> _animeMostPopular;

  @override
  void initState() {
    super.initState();
    _feedTabController = new TabController(length: _feedTabs.length, vsync: this);
    _exploreTabController = new TabController(length: _exploreTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _connection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar(_selectedIndex),
      body: _body(_selectedIndex),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: _bottomNavigationBarTapped,
        currentIndex: _selectedIndex,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Feed'),
            backgroundColor: Colors.pink
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: new Text('Explore'),
            backgroundColor: Colors.pink
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.update),
            title: new Text('Update'),
            backgroundColor: Colors.pink
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.face),
            title: new Text('Profile'),
            backgroundColor: Colors.pink
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text('Settings'),
            backgroundColor: Colors.pink
          ),
        ],
      ),
    );
  }

  _bottomNavigationBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _appBar(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return new AppBar(
          title: new TabBar(
            controller: _feedTabController,
            tabs: _feedTabs,
            labelStyle: new TextStyle(fontFamily: 'Itim'),
          ),
        );
      case 1:
        return new AppBar(
          title: new TabBar(
            controller: _exploreTabController,
            tabs: _exploreTabs,
            labelStyle: new TextStyle(fontFamily: 'Itim'),
          ),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.search), onPressed: () {})
          ],
        );
    }
    return null;
  }
  
  Widget _body(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return _feedBody();
      case 1:
        return _exploreBody();
    }
    return new Center();
  }
  
  TabBarView _feedBody() {
    return new TabBarView(
      controller: _feedTabController,
      children: <Widget>[
        new ListView.builder(
          key: new PageStorageKey('feed.global'),
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text('item #$index'),
            );
          }, itemCount: 100,
        ),
        new Center(
          child: new Icon(Icons.face),
        ),
      ],
    );
  }

  TabBarView _exploreBody() {
    return new TabBarView(
      controller: _exploreTabController,
      children: [
        _exploreAnimeBody(),
        _exploreMangaBody(),
      ],
    );
  }

  CustomScrollView _exploreAnimeBody() {
    _fetchExploreAnimeData();
    return new CustomScrollView(
      key: new PageStorageKey('explore.anime'),
      slivers: <Widget>[
        new SliverPadding(padding: new EdgeInsets.all(4.0)),
        _sectionTitleOnExplorePage(title: 'Top Airing'),
        _gridListOnExplorePage(items: _animeTopAiring),
        _sectionTitleOnExplorePage(title: 'Top Upcoming'),
        _gridListOnExplorePage(items: _animeTopUpcoming),
        _sectionTitleOnExplorePage(title: 'Highest Rating'),
        _gridListOnExplorePage(items: _animeHighestRated),
        _sectionTitleOnExplorePage(title: 'Most Popular'),
        _gridListOnExplorePage(items: _animeMostPopular),
        new SliverPadding(padding: new EdgeInsets.all(8.0)),
      ],
    );
  }

  _fetchExploreAnimeData() async {
    explore(mediaType: 'anime', status: 'current', sort: 'user_count', connection: _connection)
        .then((animeTopAiring) {
      setState(() {
        _animeTopAiring = animeTopAiring;
      });
    });
    explore(mediaType: 'anime', status: 'upcoming', sort: 'user_count', connection: _connection)
        .then((animeTopUpcoming) {
      setState(() {
        _animeTopUpcoming = animeTopUpcoming;
      });
    });
    explore(mediaType: 'anime', status: 'finished', sort: 'average_rating', connection: _connection)
        .then((animeHighestRated) {
      setState(() {
        _animeHighestRated = animeHighestRated;
      });
    });
    explore(mediaType: 'anime', status: 'finished', sort: 'user_count', connection: _connection)
        .then((animeMostPopular) {
      setState(() {
        _animeMostPopular = animeMostPopular;
      });
    });
  }
  
  CustomScrollView _exploreMangaBody() {
    // Todo fetch manga here ...
    return new CustomScrollView(
      key: new PageStorageKey('explore.manga'),
      slivers: <Widget>[
        new SliverPadding(padding: new EdgeInsets.all(4.0)),
        _sectionTitleOnExplorePage(title: 'Top Publishing'),
        _gridListOnExplorePage(items: null),
        _sectionTitleOnExplorePage(title: 'Highest Rating'),
        _gridListOnExplorePage(items: null),
        _sectionTitleOnExplorePage(title: 'Most Popular'),
        _gridListOnExplorePage(items: null),
        new SliverPadding(padding: new EdgeInsets.all(8.0)),
      ],
    );
  }

  SliverList _sectionTitleOnExplorePage({@required String title}) {
    return new SliverList(
      delegate: new SliverChildListDelegate(
        [new Padding(padding: new EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
          child: new Text(title,
            style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          ),
        ),],
      ),
    );
  }

  SliverPadding _gridListOnExplorePage({@required List<Map> items}) {
    return new SliverPadding(
      padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      sliver: new SliverGrid(
        delegate: new SliverChildBuilderDelegate((context, index) {
          var item = items == null ? null : items[index];
          return new AspectRatio(aspectRatio: 3/4,
            child:
            item == null ?
              new Stack(
                children: <Widget>[
                  new Container(
                    color: Colors.pinkAccent.shade100,
                  ),
                  new Center(
                    child: new Icon(Icons.local_florist, color: Colors.white, size: 32.0,),
                  ),
                ],
              ) :
              new Image.network(item['attributes']['posterImage']['small'], 
                  fit: BoxFit.cover,),
          );
        }, childCount: 6),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }

}