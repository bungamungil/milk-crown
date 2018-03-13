import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:milk_crown/page/media_detail.dart';

class MediaGridItem extends StatelessWidget {

  const MediaGridItem({
    @required this.media,
    @required this.padding,
  });

  final Map media;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    var poster;
    try {
      poster = media['attributes']['posterImage']['medium'];
    } catch (exception) {
      poster = '';
    }
    return new Container(
      child: new Padding(
        padding: padding,
        child: new Container(
          child: new GestureDetector(
            child: new FadeInImage(
              placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
              image: media != null
                  ? new NetworkImage(poster)
                  : new AssetImage('assets/images/placeholder_media.jpg'),
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new MediaDetailPage(
                  media: media,
                )),
              );
            },
          ),
        ),
      ),
    );
  }

}