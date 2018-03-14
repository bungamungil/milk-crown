import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MediaDetailPage extends StatefulWidget {

  const MediaDetailPage({@required this.media});

  final Map media;

  @override
  State<StatefulWidget> createState() => new _MediaDetailState();

}

class _MediaDetailState extends State<MediaDetailPage> {

  static var formatter = new DateFormat('yyyy-mm-dd');

  static var readableFormatter = new DateFormat('MMM d, yyyy');

  Map _media() => widget.media;

  String _type() {
    try {
      var type = _media()['type'];
      return '${type[0].toUpperCase()}${type.substring(1)}';
    } catch (_) {
      return null;
    }
  }

  Map _attributes() {
    try {
      return _media()['attributes'];
    } catch (_) {
      return null;
    }
  }

  String _canonicalTitle() {
    try {
      return _attributes()['canonicalTitle'];
    } catch (_) {
      return null;
    }
  }

  String _englishTitle() {
    try {
      return _attributes()['titles']['en'];
    } catch (_) {
      return null;
    }
  }

  String _romanizedTitle() {
    try {
      return _attributes()['titles']['en_jp'];
    } catch (_) {
      return null;
    }
  }

  String _japaneseTitle() {
    try {
      return _attributes()['titles']['ja_jp'];
    } catch (_) {
      return null;
    }
  }

  String _synopsis() {
    try {
      return _attributes()['synopsis'];
    } catch (_) {
      return null;
    }
  }

  String _runtimeDetail() {
    try {
      return '${_attributes()['episodeCount']} ${_attributes()['subtype']} episodes @ ${_attributes()['episodeLength']} mins';
    } catch (_) {
      return null;
    }
  }

  String _timelineDetail() {
    try {
      return '${_formatDate(_attributes()['startDate'])} till ${_formatDate(_attributes()['endDate'])}';
    } catch (_) {
      return null;
    }
  }

  String _ratingGuide() {
    try {
      return '${_attributes()['ageRatingGuide']}';
    } catch (_) {
      return null;
    }
  }

  String _cover() {
    try {
      return _attributes()['coverImage']['original'];
    } catch(_) {
      return null;
    }
  }

  String _poster() {
    try {
      return _attributes()['posterImage']['medium'];
    } catch (_) {
      return null;
    }
  }

  String _averageRating() {
    try {
      return _attributes()['averageRating'];
    } catch (_) {
      return null;
    }
  }

  int _popularityRank() {
    try {
      return _attributes()['popularityRank'];
    } catch (_) {
      return null;
    }
  }

  int _ratingRank() {
    try {
      return _attributes()['ratingRank'];
    } catch (_) {
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

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                      child: new FadeInImage(
                        placeholder: new AssetImage('assets/images/placeholder_media.jpg'),
                        image: _poster() != null ? new NetworkImage(_poster()) : null,
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
                            child: new Text(_canonicalTitle(),
                              style: new TextStyle(
                                  fontFamily: 'Delius',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
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
              );
            }, childCount: 1),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate((context, index) {
              return new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new _MediaDetailItem(field: 'English', value: _englishTitle()),
                    new _MediaDetailItem(field: 'Romanized', value: _romanizedTitle()),
                    new _MediaDetailItem(field: 'Japanese', value: _japaneseTitle()),
                    new _MediaDetailItem(field: 'Runtime Detail', value: _runtimeDetail()),
                    new _MediaDetailItem(field: 'Timeline Detail', value: _timelineDetail()),
                    new _MediaDetailItem(field: 'Rating Guide', value: _ratingGuide()),
                    new _MediaDetailItem(field: 'Synopsis', value: _synopsis()),
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

class _MediaStatisticOverview extends StatelessWidget {

  const _MediaStatisticOverview({@required this.caption, @required this.value, @required this.icon, @required this.iconColor});

  final String caption;

  final String value;

  final IconData icon;

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
      padding: new EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
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