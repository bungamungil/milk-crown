import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:milk_crown/page/guest_home.dart';
import 'package:milk_crown/page/library/anime_library.dart';
import 'package:milk_crown/page/library/manga_library.dart';

void main() => runApp(new MilkCrown());

class MilkCrown extends StatelessWidget {

  Map<String, WidgetBuilder> routes(BuildContext context) {
    var routes = new HashMap<String, WidgetBuilder>();
    routes['/guest'] = (context) => new GuestHomePage();
    routes['/library/anime'] = (context) => new AnimeLibraryScreen();
    routes['/library/manga'] = (context) => new MangaLibraryScreen();
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Milk Crown',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
        platform: TargetPlatform.iOS,
      ),
      home: new GuestHomePage(),
      routes: routes(context),
    );
  }

}
