import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomBarNavigationItems = [
  new BottomNavigationBarItem(
    icon: new Icon(Icons.home),
    title: new Text('Feed', style: new TextStyle(fontFamily: 'Itim'),),
    backgroundColor: Colors.pink,
  ),
  new BottomNavigationBarItem(
    icon: new Icon(Icons.explore),
    title: new Text('Explore', style: new TextStyle(fontFamily: 'Itim'),),
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
];

final List<Tab> feedTabs = [
  new Tab(text: 'Global',),
  new Tab(text: 'Following',),
];

final List<Tab> findTabs = [
  new Tab(text: 'Anime',),
  new Tab(text: 'Manga',),
];