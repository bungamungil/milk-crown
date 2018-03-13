import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milk_crown/content/home_drawer_item.dart';
import 'package:milk_crown/content/explore.dart';
import 'package:milk_crown/network_call.dart';
import 'package:milk_crown/common.dart';

class GuestHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _GuestHomeState();

}

class _GuestHomeState extends State<GuestHomePage> {

  var _connection = new http.Client();

  var _trending = new List<Map>();

  var _topCurrent = new List<Map>();

  var _topUpcoming = new List<Map>();

  var _highestRated = new List<Map>();

  var _mostPopular = new List<Map>();

  var _exploreType = 'anime';

  List<Widget> createDrawerItemsForGuest(BuildContext context) {
    return [
      new HomeDrawerItem(
        title: 'Explore Anime',
        icon: Icons.tv,
        onTap: () {
          Navigator.of(context).pop();
          _fetch(type: 'anime');
        },
        isSelected: _exploreType == 'anime',
      ),
      new HomeDrawerItem(
        title: 'Explore Manga',
        icon: Icons.import_contacts,
        onTap: () {
          Navigator.of(context).pop();
          _fetch(type: 'manga');
        },
        isSelected: _exploreType == 'manga',
      ),
      new Padding(
        padding: new EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
        child: new Container(
          height: 1.0,
          decoration: new BoxDecoration(
            color: Colors.grey.shade400
          ),
        ),
      ),
      new HomeDrawerItem(
        title: 'Login',
        icon: Icons.input,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/login');
        },
        isSelected: false,
      ),
      new HomeDrawerItem(
        title: 'Register',
        icon: Icons.open_in_browser,
        onTap: () {
          Navigator.of(context).pop();
          launch(url: 'https://kitsu.io/');
        },
        isSelected: false,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _fetch(type: 'anime');
  }

  _fetch({@required type}) {
    setState(() {
      _trending.clear();
      _topCurrent.clear();
      _topUpcoming.clear();
      _highestRated.clear();
      _mostPopular.clear();
      _exploreType = type;
    });

    fetchTrending(client: _connection, mediaType: type).then((response) {
      if (response == null) return;
      setState(() {
        _trending = response;
      });
    });

    fetchTopCurrent(client: _connection, mediaType: type).then((response) {
      if (response == null) return;
      setState(() {
        _topCurrent = response;
      });
    });

    fetchTopUpcoming(client: _connection, mediaType: type).then((response) {
      if (response == null) return;
      setState(() {
        _topUpcoming = response;
      });
    });

    fetchHighestRated(client: _connection, mediaType: type).then((response) {
      if (response == null) return;
      setState(() {
        _highestRated = response;
      });
    });

    fetchMostPopular(client: _connection, mediaType: type).then((response) {
      if (response == null) return;
      setState(() {
        _mostPopular = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerItems = createDrawerItemsForGuest(context);
    var title = _exploreType == 'anime' ? 'Anime' : 'Manga';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Explore $title',
          style: new TextStyle(fontFamily: 'Itim'),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Guest',
                style: new TextStyle(
                  fontFamily: 'Itim',
                ),
              ),
              accountEmail: null,
              decoration: new BoxDecoration(
                color: Colors.brown,
              ),
            ),
            new Column(
              children: drawerItems,
            )
          ],
        ),
      ),
      body: new ExploreWidget(
        trending: _trending,
        topAiring: _topCurrent,
        topUpcoming: _topUpcoming,
        highestRated: _highestRated,
        mostPopular: _mostPopular,
        type: _exploreType,
      ),
    );
  }

}
