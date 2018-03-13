import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milk_crown/content/home_drawer_item.dart';
import 'package:milk_crown/content/explore.dart';
import 'package:milk_crown/network_call.dart';

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
          // Todo
        },
        isSelected: false,
      ),
      new HomeDrawerItem(
        title: 'Register',
        icon: Icons.open_in_browser,
        onTap: () {
          Navigator.of(context).pop();
          // Todo
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
      setState(() {
        _trending = response['data'];
      });
    });

    fetchTopCurrent(client: _connection, mediaType: type).then((response) {
      setState(() {
        _topCurrent = response['data'];
      });
    });

    fetchTopUpcoming(client: _connection, mediaType: type).then((response) {
      setState(() {
        _topUpcoming = response['data'];
      });
    });

    fetchHighestRated(client: _connection, mediaType: type).then((response) {
      setState(() {
        _highestRated = response['data'];
      });
    });

    fetchMostPopular(client: _connection, mediaType: type).then((response) {
      setState(() {
        _mostPopular = response['data'];
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
