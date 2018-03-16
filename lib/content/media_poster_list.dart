import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:milk_crown/content/media_grid_item.dart';

class MediaPosterList extends StatelessWidget {

  const MediaPosterList({@required this.mediaList});

  final List<Map> mediaList;

  @override
  Widget build(BuildContext context) {
    if (mediaList == null) return _placeholder(context);
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: _buildItem,
      itemCount: mediaList.length,
      shrinkWrap: true,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return new MediaGridItem(
      media: mediaList[index],
      padding: new EdgeInsets.all(2.0)
    );
  }

  Widget _placeholder(BuildContext context) {
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: _buildPlaceholderItem,
      itemCount: 8,
      shrinkWrap: true,
    );
  }

  Widget _buildPlaceholderItem(BuildContext context, int index) {
    return new MediaGridItem(
        media: null,
        padding: new EdgeInsets.all(2.0)
    );
  }

}