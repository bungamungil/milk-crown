import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

var _baseUrl = 'https://kitsu.io/api/edge';

String _encode({@required String url}) {
  return Uri.encodeFull(url);
}

String _exploreUrl({
  @required String mediaType,
  @required String status,
  @required int limit,
  @required String sort,
}) {
  return _encode(url: '$_baseUrl/$mediaType?page[limit]=$limit&filter[status]=$status&sort=-$sort');
}

Future<List<Map>> explore({
  @required String mediaType,
  @required String status,
  @required String sort,
  @required http.Client connection,
}) async {
  return connection.get(_exploreUrl(
      mediaType: mediaType,
      status: status,
      limit: 8,
      sort: sort)
  ).then((response) {
    var map = JSON.decode(response.body);
    return map['data'];
  });
}