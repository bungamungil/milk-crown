import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State createState() => new HomeState();

}

class HomeState extends State<HomePage> with TickerProviderStateMixin {

  int _selectedTab = 0;

  TabController _feedTabController;

  TabController _findTabController;

  ValueKey<int> tabBarValueKey;

  var _feedTabs = [
    new Tab(text: 'Global',),
    new Tab(text: 'Following',),
  ];

  var _findTabs = [
    new Tab(text: 'Anime',),
    new Tab(text: 'Manga',),
    new Tab(text: 'User',),
  ];

  @override
  void initState() {
    super.initState();
    _feedTabController = new TabController(length: _feedTabs.length, vsync: this);
    _findTabController = new TabController(length: _findTabs.length, vsync: this);
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
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Feed', style: new TextStyle(fontFamily: 'Itim'),),
            backgroundColor: Colors.pink,
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Find', style: new TextStyle(fontFamily: 'Itim'),),
            backgroundColor: Colors.pink,
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.update),
            title: new Text('Update', style: new TextStyle(fontFamily: 'Itim'),),
            backgroundColor: Colors.pink,
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.face),
            title: new Text('Profile', style: new TextStyle(fontFamily: 'Itim'),),
            backgroundColor: Colors.pink,
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text('Setting', style: new TextStyle(fontFamily: 'Itim'),),
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }

  Scaffold _body(int selectedBottomTab) {
    switch (selectedBottomTab) {
      case 0:
        return _feed();
      case 1:
        return _find();
      default:
        return new Scaffold();
    }
  }

  Scaffold _feed() => new Scaffold(
    appBar: new AppBar(
      title: new TabBar(
        tabs: _feedTabs,
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

  Scaffold _find() => new Scaffold(
    appBar: new AppBar(
      title: new TabBar(
        tabs: _findTabs,
        labelStyle: new TextStyle(fontFamily: 'Itim'),
        controller: _findTabController,
      ),
      elevation: 0.0,
    ),
    body: new TabBarView(children: [
      new Container(child: _findChild('Anime'),),
      new Container(child: _findChild('Manga'),),
      new Container(child: _findChild('User'),),
    ], controller: _findTabController),
  );

  Scaffold _findChild(String mediaType) => new Scaffold(
    appBar: new AppBar(
      title: new TextField(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: new Icon(Icons.search),
          hintText: 'Search $mediaType',
        ),
        style: new TextStyle(
          fontFamily: 'Delius',
          color: Colors.pink,
          fontSize: 16.0,
        ),
      ),
    ),
    body: new Container(
      key: new PageStorageKey('find_$mediaType'),
      child: new ListView.builder(itemBuilder: _dummyItem, itemCount: 200,),
    ),
  );

  Widget _dummyItem(BuildContext context, int index) {
    return new ListTile(
      title: new Text('Dummy item #$index', style: new TextStyle(fontFamily: 'Delius'),),
    );
  }

}
