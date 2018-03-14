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
    } catch(_) {}
    var synopsis = '';
    try {
      synopsis = media['attributes']['synopsis'];
    } catch (_) {}
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            pinned: true,
            expandedHeight: size.width * 9 / 16,
            flexibleSpace: new FlexibleSpaceBar(
              background: new FadeInImage(
                placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
                image: cover != null
                  ? new NetworkImage(cover)
                  : new AssetImage('assets/images/placeholder_media.jpg'),
                fit: BoxFit.cover,
                fadeInDuration: new Duration(milliseconds: 0),
                fadeOutDuration: new Duration(milliseconds: 0),
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              var poster;
              try {
                poster = media['attributes']['posterImage']['medium'];
              } catch (_) {}
              var title = '';
              try {
                title = media['attributes']['canonicalTitle'];
              } catch (_) {}
              var averageRating = '';
              try {
                averageRating = media['attributes']['averageRating'];
              } catch (_) {}
              var popularityRank = '';
              try {
                popularityRank = media['attributes']['popularityRank'];
              } catch (_) {}
              var type = '';
              try {
                type = media['type'];
              } catch (_) {}
              var ratingRank = '';
              try {
                ratingRank = media['attributes']['ratingRank'];
              } catch (_) {}
              return new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                      child: new FadeInImage(
                        placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
                        image: poster != null ? new NetworkImage(poster) : null,
                        fit: BoxFit.cover,
                      ),
                    ),
                    flex: 3,
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                      child: new Column(
                        children: <Widget>[
                          new Padding(padding: new EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                            child: new Text(title,
                              style: new TextStyle(
                                fontFamily: 'Delius',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          new Padding(padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: new Row(
                              children: <Widget>[
                                new Padding(padding: new EdgeInsets.fromLTRB(4.0, 0.0, 12.0, 0.0),
                                  child: new IconTheme(
                                    data: new IconThemeData(
                                      color: Colors.green,
                                      size: 24.0,
                                    ),
                                    child: new Icon(Icons.people),
                                  ),
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text('$averageRating%',
                                      style: new TextStyle(
                                        fontFamily: 'Delius',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    new Text('Community Approval',
                                      style: new TextStyle(
                                        fontFamily: 'Delius',
                                        fontSize: 12.0
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                          new Padding(padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: new Row(
                              children: <Widget>[
                                new Padding(padding: new EdgeInsets.fromLTRB(4.0, 0.0, 12.0, 0.0),
                                  child: new IconTheme(
                                    data: new IconThemeData(
                                      color: Colors.red,
                                      size: 24.0,
                                    ),
                                    child: new Icon(Icons.favorite),
                                  ),
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text('#$popularityRank',
                                      style: new TextStyle(
                                        fontFamily: 'Delius',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    new Text('Most Popular ${type[0].toUpperCase()}${type.substring(1)}',
                                      style: new TextStyle(
                                        fontFamily: 'Delius',
                                        fontSize: 12.0
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                          new Padding(padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: new Row(
                              children: <Widget>[
                                new Padding(padding: new EdgeInsets.fromLTRB(4.0, 0.0, 12.0, 0.0),
                                  child: new IconTheme(
                                    data: new IconThemeData(
                                      color: Colors.orange,
                                      size: 24.0
                                    ),
                                    child: new Icon(Icons.star),
                                  ),
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text('#$ratingRank',
                                      style: new TextStyle(
                                        fontFamily: 'Delius',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    new Text('Highest Rated ${type[0].toUpperCase()}${type.substring(1)}',
                                      style: new TextStyle(
                                        fontFamily: 'Delius',
                                        fontSize: 12.0
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    flex: 4,
                  ),
                ],
              );
            }, childCount: 1),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Padding(padding: new EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: new RaisedButton(
                          onPressed: () {},
                          child: new Text('Add to Library',
                            style: new TextStyle(
                              fontFamily: 'Itim',
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: new RaisedButton(
                          onPressed: () {},
                          child: new Text('+1 Episode',
                            style: new TextStyle(
                              fontFamily: 'Itim',
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(0.0),
                        child: new RaisedButton(
                          onPressed: () {},
                          child: new Text('Give Rating',
                            style: new TextStyle(
                              fontFamily: 'Itim',
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: 1),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Padding(
                padding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(synopsis,
                      style: new TextStyle(
                        fontFamily: 'Delius',
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }

}