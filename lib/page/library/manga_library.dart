import 'package:flutter/material.dart';

class MangaLibraryScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new MangaLibraryState();

}

class MangaLibraryState extends State<MangaLibraryScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Manga Library',
          style: new TextStyle(fontFamily: 'Itim'),
        ),
      ),
    );
  }

}