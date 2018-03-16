import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milk_crown/content/home_drawer_item.dart';
import 'package:milk_crown/content/explore.dart';
import 'package:milk_crown/network_call.dart';
import 'package:milk_crown/common.dart';

class ExplorePage extends StatefulWidget {

  const ExplorePage({@required this.mediaType});

  final String mediaType;

  @override
  State<StatefulWidget> createState() => new _ExploreState();

}

class _ExploreState extends State<ExplorePage> {

  var _connection = new http.Client();

  var _trending = new List<Map>();

  var _topCurrent = new List<Map>();

  var _topUpcoming = new List<Map>();

  var _highestRated = new List<Map>();

  var _mostPopular = new List<Map>();

  var _exploreType;

  @override
  void initState() {
    super.initState();
    _exploreType = widget.mediaType.toLowerCase();
    _fetch(type: _exploreType);
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
//    return new ExploreWidget(
//      trending: _trending,
//      topAiring: _topCurrent,
//      topUpcoming: _topUpcoming,
//      highestRated: _highestRated,
//      mostPopular: _mostPopular,
//      type: _exploreType,
//    );
  return new Container();
  }

}
