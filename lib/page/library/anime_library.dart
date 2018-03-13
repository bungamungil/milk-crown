import 'package:flutter/material.dart';

class AnimeLibraryScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new AnimeLibraryState();

}

class AnimeLibraryState extends State<AnimeLibraryScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Anime Library',
          style: new TextStyle(fontFamily: 'Itim'),
        ),
      ),
    );
  }

}