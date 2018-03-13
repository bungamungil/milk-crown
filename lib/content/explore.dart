import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:milk_crown/content/media_grid_item.dart';
import 'package:milk_crown/common.dart';

class ExploreWidget extends StatelessWidget {

  const ExploreWidget({
    @required this.trending,
    @required this.topAiring,
    @required this.topUpcoming,
    @required this.highestRated,
    @required this.mostPopular,
    @required this.type,
  });

  final List<Map> trending;

  final List<Map> topAiring;

  final List<Map> topUpcoming;

  final List<Map> highestRated;

  final List<Map> mostPopular;

  final String type;

  Map getItem({@required List<Map> from, @required int index}) {
    return index < from.length ? from[index] : null;
  }

  EdgeInsets _defaultItemPadding(int index) {
    var lPadding = index % 2 == 0 ? 12.0 : 6.0;
    var rPadding = index % 2 == 1 ? 12.0 : 6.0;
    return new EdgeInsets.fromLTRB(lPadding, 6.0, rPadding, 6.0);
  }

  SliverList container() {
    return new SliverList(
      delegate: new SliverChildBuilderDelegate((buildContext, index) {
        return new Container();
      }, childCount: 1)
    );
  }

  @override
  Widget build(BuildContext context) {
    var title = type == 'anime' ? 'Anime' : 'Manga';
    var currentTitle = type == 'anime' ? 'Airing Anime' : 'Publishing Manga';
    return new CustomScrollView(
      slivers: <Widget>[
        createTitle('Trending This Week'),
        new SliverGrid(
          delegate: new SliverChildBuilderDelegate((context, index) {
            return new MediaGridItem(
              media: getItem(from: trending, index: index),
              padding: _defaultItemPadding(index),
            );
          }, childCount: 6),
          gridDelegate: defaultGridDelegate(),
        ),
        createTitle('Top $currentTitle'),
        new SliverGrid(
          gridDelegate: defaultGridDelegate(),
          delegate: new SliverChildBuilderDelegate((context, index) {
            return new MediaGridItem(
              media: getItem(from: topAiring, index: index),
              padding: _defaultItemPadding(index),
            );
          }, childCount: 6),
        ),
        type == 'manga' ? container() : createTitle('Top Upcoming $title'),
        type == 'manga' ? container() : new SliverGrid(
          gridDelegate: defaultGridDelegate(),
          delegate: new SliverChildBuilderDelegate((context, index) {
            return new MediaGridItem(
              media: getItem(from: topUpcoming, index: index),
              padding: _defaultItemPadding(index),
            );
          }, childCount: 6),
        ),
        createTitle('Highest Rated $title'),
        new SliverGrid(
          gridDelegate: defaultGridDelegate(),
          delegate: new SliverChildBuilderDelegate((context, index) {
            return new MediaGridItem(
              media: getItem(from: highestRated, index: index),
              padding: _defaultItemPadding(index),
            );
          }, childCount: 6),
        ),
        createTitle('Most Popular $title'),
        new SliverGrid(
          gridDelegate: defaultGridDelegate(),
          delegate: new SliverChildBuilderDelegate((context, index) {
            return new MediaGridItem(
              media: getItem(from: mostPopular, index: index),
              padding: _defaultItemPadding(index),
            );
          }, childCount: 6),
        ),
        new SliverList(
          delegate: new SliverChildBuilderDelegate((buildContext, index) {
            return new Padding(
              padding: new EdgeInsets.all(4.0),
            );
          }, childCount: 1),
        ),
      ],
    );
  }

}