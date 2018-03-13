import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MediaGridItem extends StatelessWidget {

  const MediaGridItem({
    @required this.media,
    @required this.padding,
  });

  final Map media;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Padding(
        padding: padding,
        child: new Container(
          child: new FadeInImage(
            placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
            image: media != null
              ? new NetworkImage(media['attributes']['posterImage']['medium'])
              : new AssetImage('assets/images/placeholder_media.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}