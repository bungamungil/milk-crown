import 'package:flutter/foundation.dart';

class MediaState {

  const MediaState({
    @required this.trending,
    @required this.topCurrent,
    @required this.topUpcoming,
    @required this.highestRated,
    @required this.mostPopular
  });

  final List<Map> trending;

  final List<Map> topCurrent;

  final List<Map> topUpcoming;

  final List<Map> highestRated;

  final List<Map> mostPopular;

}