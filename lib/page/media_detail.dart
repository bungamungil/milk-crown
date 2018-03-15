import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MediaDetailPage extends StatefulWidget {

  const MediaDetailPage({@required this.media});

  final Map media;

  @override
  State<StatefulWidget> createState() => new _MediaDetailState();

}

class _MediaDetailState extends State<MediaDetailPage> {

  var _connection = new http.Client();

  static var formatter = new DateFormat('yyyy-mm-dd');

  static var readableFormatter = new DateFormat('MMM d, yyyy');

  @override
  void dispose() {
    _connection.close();
    super.dispose();
  }

  Future<Null> _fetchMediaDetail() async {
    try {
      var type = _media()['type'];
      var id = _media()['id'];
      
      var uri = Uri.encodeFull('https://kitsu.io/api/edge/$type/$id?include=categories,categories.parent');
      
      await _connection.get(uri).then((response) {

        // parse response.body to Json Map
        var parsed = JSON.decode(response.body);

        Map attributes = parsed['data']['attributes'];
        List<Map> included = parsed['included'];

        // put all categories from included
        var categories = included.where((it) {
          return it['type'] == 'categories';
        }).toList();

        // chain categories with their parent's
        categories.forEach((category) {
          if (category['relationships']['parent']['data'] != null) {
            category['parent'] = categories.where((it) {
              return category['relationships']['parent']['data']['id'] == it['id'];
            }).first;
          }
        });

        // put genres (categories with parent.title = Element) from categories
        attributes['genres'] = categories.where((category) {
          return category['parent'] != null;
        }).where((category) {
          return category['parent']['attributes']['title'] == 'Elements';
        }).toList();

        // put other tags (categories that doesn't have children and doesn't belongs to genres.)
        attributes['tags'] = categories.where((category) {
          return category['attributes']['childCount'] == 0;
        }).where((category) {
          return category['parent'] != null;
        }).where((category) {
          return category['parent']['attributes']['title'] != 'Elements';
        }).toList();

        return attributes;
      }).then((attributes) {
        
        return _fetchReactionCount(attributes);

      }).then((attributes) {

        return _fetchRelationshipCount(attributes);
        
      }).then((attributes) {

        setState(() {
          _attributes = attributes;
        });

      });
    } catch (_) {
    }
  }
  
  Future<Map> _fetchReactionCount(Map attributes) async {

    var type = _media()['type'];
    var id = _media()['id'];
    var uri = Uri.encodeFull('https://kitsu.io/api/edge/media-reactions?filter[${type}Id]=$id&sort=-created_at');
    
    return await _connection.get(uri).then((response) {

      // parse response.body to Json Map
      var parsed = JSON.decode(response.body);

      // put reaction count from meta's response
      int reactionCount = parsed['meta']['count'];
      attributes['reactionCount'] = reactionCount;
      return attributes;

    });
    
  }

  Future<Map> _fetchRelationshipCount(Map attributes) async {

    var type = _media()['type'];
    var id = _media()['id'];
    var uri = Uri.encodeFull('https://kitsu.io/api/edge/$type/$id/media-relationships');

    return await _connection.get(uri).then((response) {

      // parse response.body to Json Map
      var parsed = JSON.decode(response.body);

      // put relationship count from meta's response
      int relationshipCount = parsed['meta']['count'];
      attributes['relationshipCount'] = relationshipCount;
      return attributes;

    });

  }

  Map _attributes;

  @override
  void initState() {
    super.initState();
    _fetchMediaDetail();
  }

  Map _media() => widget.media;

  String _type() {
    try {
      var type = _media()['type'];
      return '${type[0].toUpperCase()}${type.substring(1)}';
    } catch (_) {
      return null;
    }
  }

  String _canonicalTitle() {
    try {
      return _attributes['canonicalTitle'];
    } catch (_) {
      return null;
    }
  }

  String _englishTitle() {
    try {
      return _attributes['titles']['en'];
    } catch (_) {
      return null;
    }
  }

  String _romanizedTitle() {
    try {
      return _attributes['titles']['en_jp'];
    } catch (_) {
      return null;
    }
  }

  String _japaneseTitle() {
    try {
      return _attributes['titles']['ja_jp'];
    } catch (_) {
      return null;
    }
  }

  String _synopsis() {
    try {
      return _attributes['synopsis'];
    } catch (_) {
      return null;
    }
  }

  String _runtimeDetail() {
    try {
      return '${_attributes['episodeCount']} ${_attributes['subtype']} episodes @ ${_attributes['episodeLength']} mins';
    } catch (_) {
      return null;
    }
  }

  String _timelineDetail() {
    try {
      return '${_formatDate(_attributes['startDate'])} till ${_formatDate(_attributes['endDate'])}';
    } catch (_) {
      return null;
    }
  }

  String _ratingGuide() {
    try {
      return '${_attributes['ageRatingGuide']}';
    } catch (_) {
      return null;
    }
  }

  String _cover() {
    try {
      return _attributes['coverImage']['original'];
    } catch(_) {
      return null;
    }
  }

  String _poster() {
    try {
      return _attributes['posterImage']['medium'];
    } catch (_) {
      return null;
    }
  }

  String _averageRating() {
    try {
      return _attributes['averageRating'];
    } catch (_) {
      return null;
    }
  }

  int _popularityRank() {
    try {
      return _attributes['popularityRank'];
    } catch (_) {
      return null;
    }
  }

  int _ratingRank() {
    try {
      return _attributes['ratingRank'];
    } catch (_) {
      return null;
    }
  }

  List<Map> _genres() {
    try {
      return _attributes['genres'];
    } catch (_) {
      return null;
    }
  }

  List<Map> _tags() {
    try {
      return _attributes['tags'];
    } catch(_) {
      return null;
    }
  }

  String _formatDate(String stringDate) {
    try {
      var date = formatter.parse(stringDate);
      return readableFormatter.format(date);
    } catch (_) {
      return null;
    }
  }

  int _reactionCount() {
    try {
      return _attributes['reactionCount'];
    } catch (_) {
      return null;
    }
  }

  int _relationshipCount() {
    try {
      return _attributes['relationshipCount'];
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _attributes == null
        ? fetchingScaffold(context)
        : contentScaffold(context);
  }

  Scaffold fetchingScaffold(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Please wait ...', style: new TextStyle(fontFamily: 'Itim'),),
      ),
      body: new Center(),
    );
  }

  Scaffold contentScaffold(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            pinned: true,
            expandedHeight: size.width * 9 / 16,
            flexibleSpace: new FlexibleSpaceBar(
              background: new FadeInImage(
                placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
                image: _cover() != null
                    ? new NetworkImage(_cover())
                    : new AssetImage('assets/images/placeholder_media.jpg'),
                fit: BoxFit.cover,
                fadeInDuration: new Duration(milliseconds: 0),
                fadeOutDuration: new Duration(milliseconds: 0),
              ),
              title: new Text(_canonicalTitle(),
                style: new TextStyle(fontFamily: 'Itim'),
              ),
              centerTitle: true,
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Material(
                elevation: 4.0,
                child: new Column(
                  children: <Widget>[
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Flexible(
                          child: new Padding(
                            padding: new EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 12.0),
                            child: new FadeInImage(
                              placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
                              image: _poster() != null ? new NetworkImage(_poster()) : null,
                              fit: BoxFit.cover,
                            ),
                          ),
                          flex: 3,
                        ),
                        new Flexible(
                          child: new Padding(
                            padding: new EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                            child: new Column(
                              children: <Widget>[
                                new _MediaStatisticOverview(
                                    caption: 'Community Approval',
                                    value: '${_averageRating()}%',
                                    icon: Icons.people,
                                    iconColor: Colors.green
                                ),
                                new _MediaStatisticOverview(
                                    caption: 'Most Popular ${_type()}',
                                    value: '#${_popularityRank()}',
                                    icon: Icons.favorite,
                                    iconColor: Colors.red
                                ),
                                new _MediaStatisticOverview(
                                    caption: 'Highest Rated ${_type()}',
                                    value: '#${_ratingRank()}',
                                    icon: Icons.star,
                                    iconColor: Colors.orange
                                ),
                              ],
                            ),
                          ),
                          flex: 4,
                        ),
                      ],
                    ),
                    new Padding(padding: new EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
                      child: new Row(
                        children: <Widget>[
                          new _MediaDetailAction(
                            caption: 'Add to Library',
                            action: () {},
                          ),
                          new _MediaDetailAction(
                            caption: '+1 Episode',
                            action: () {},
                          ),
                          new _MediaDetailAction(
                            caption: 'Give Rating',
                            action: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }, childCount: 1),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Material(
                  elevation: 4.0,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(4.0)),
                      new _MediaDetailItem(field: 'English', value: _englishTitle()),
                      new _MediaDetailItem(field: 'Romanized', value: _romanizedTitle()),
                      new _MediaDetailItem(field: 'Japanese', value: _japaneseTitle()),
                      new _MediaDetailItem(field: 'Runtime Detail', value: _runtimeDetail()),
                      new _MediaDetailItem(field: 'Timeline Detail', value: _timelineDetail()),
                      new _MediaDetailItem(field: 'Rating Guide', value: _ratingGuide()),
                      new _MediaDetailItem(field: 'Synopsis', value: _synopsis()),
                      new _MediaTagsDetail(genres: _genres(), tags: _tags(),),
                      new Padding(padding: new EdgeInsets.all(4.0)),
                    ],
                  ),
                ),
              );
            }, childCount: 1),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                child: new Material(
                  elevation: 4.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey
                        ),
                        height: 0.3,
                      ),
                      new ListTile(
                        title: new Text('Reactions (${_reactionCount()})',
                          style: new TextStyle(fontFamily: 'Itim', fontSize: 18.0),
                        ),
                        onTap: () {},
                        trailing: new Icon(Icons.chevron_right),
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey
                        ),
                        height: 0.3,
                      ),
                      new ListTile(
                        title: new Text('Staffs and Characters',
                          style: new TextStyle(fontFamily: 'Itim', fontSize: 18.0),
                        ),
                        onTap: () {},
                        trailing: new Icon(Icons.chevron_right),
                      ),
                      //
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.grey
                        ),
                        height: 0.3,
                      ),
                      new ListTile(
                        title: new Text('Related Media ($_relationshipCount())',
                          style: new TextStyle(fontFamily: 'Itim', fontSize: 18.0),
                        ),
                        onTap: () {},
                        trailing: new Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }

}

class _MediaStatisticOverview extends StatelessWidget {

  const _MediaStatisticOverview({@required this.caption, @required this.value, @required this.icon, @required this.iconColor});

  final String caption;

  final String value;

  final IconData icon;

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: new EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
      child: new Row(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.fromLTRB(4.0, 0.0, 12.0, 0.0),
            child: new IconTheme(
              data: new IconThemeData(
                color: iconColor,
                size: 24.0,
              ),
              child: new Icon(icon),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(value,
                style: new TextStyle(
                    fontFamily: 'Delius',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700
                ),
              ),
              new Text(caption,
                style: new TextStyle(
                    fontFamily: 'Delius',
                    fontSize: 12.0
                ),
              ),
            ],
          )
        ],
      )
    );
  }

}

class _MediaDetailAction extends StatelessWidget {

  const _MediaDetailAction({@required this.caption, @required this.action});

  final String caption;

  final dynamic action;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
        child: new RaisedButton(
          onPressed: action,
          child: new Text(caption,
            style: new TextStyle(
              fontFamily: 'Itim',
              color: Colors.white,
            ),
          ),
          color: Colors.brown,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

}

class _MediaDetailItem extends StatelessWidget {

  const _MediaDetailItem({@required this.field, @required this.value});

  final String field;

  final String value;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(field,
            style: new TextStyle(
                fontFamily: 'Delius',
                fontSize: 14.0,
                fontWeight: FontWeight.w700
            ),
          ),
          new Padding(padding: new EdgeInsets.all(2.0)),
          new Text(value,
            style: new TextStyle(
              fontFamily: 'Delius',
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

}

class _MediaTagsDetail extends StatelessWidget {
  
  _MediaTagsDetail({@required this.genres, @required this.tags});
  
  final List<Map> genres;

  final List<Map> tags;
  
  List<Widget> _chips() {
    var chips = new List<Chip>();
    genres?.forEach((genre) {
      chips.add(
        new Chip(
          label: new Text(
            genre['attributes']['title'],
            style: new TextStyle(fontFamily: 'Itim', color: Colors.white),
          ),
          backgroundColor: Colors.brown.shade400,
        ),
      );
    });
    tags?.forEach((genre) {
      chips.add(
        new Chip(
          label: new Text(
            genre['attributes']['title'],
            style: new TextStyle(fontFamily: 'Itim', color: Colors.black),
          ),
          backgroundColor: Colors.brown.shade50,
        ),
      );
    });
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Wrap(
            spacing: 4.0,
            runSpacing: 6.0,
            children: _chips(),
          ),
        ],
      ),
    );
  }

}