import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MediaDetailPage extends StatelessWidget {

  const MediaDetailPage({@required this.media});

  final Map media;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cover;
    try {
      cover = media['attributes']['coverImage']['original'];
    } catch(exception) {
      cover = '';
    }
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            pinned: true,
            expandedHeight: size.width * 9 / 16,
            flexibleSpace: new FlexibleSpaceBar(
              background: new FadeInImage(
                placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
                image: media != null
                  ? new NetworkImage(cover)
                  : new AssetImage('assets/images/placeholder_media.jpg'),
                fit: BoxFit.cover,
                fadeInDuration: new Duration(milliseconds: 0),
                fadeOutDuration: new Duration(milliseconds: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

}