import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:milk_crown/page/home.dart';

void main() => runApp(new MilkCrown());

class MilkCrown extends StatelessWidget {

  Map<String, WidgetBuilder> routes(BuildContext context) {
    var routes = new HashMap<String, WidgetBuilder>();
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Milk Crown',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
        platform: TargetPlatform.iOS,
        fontFamily: 'Itim',
      ),
      home: new HomePage(),
      routes: routes(context),
    );
  }

}
