import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

var _limit = 6;
var _baseUrl = 'https://kitsu.io/api/edge';

Future<Map> fetchTrending({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/trending/$mediaType?limit=$_limit';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body);
  });
}

Future<Map> fetchTopCurrent({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'filter[status]=current&'
      'sort=-user_count';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body);
  });
}

Future<Map> fetchTopUpcoming({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'filter[status]=upcoming&'
      'sort=-user_count';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body);
  });
}

Future<Map> fetchHighestRated({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'sort=-average_rating';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body);
  });
}

Future<Map> fetchMostPopular({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'sort=-user_count';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body);
  });
}
