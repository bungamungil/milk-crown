import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

var _clientId = 'dd031b32d2f56c990b1425efe6c42ad847e7fe3ab46bf1299f05ecd856bdb7dd';
var _clientSecret = '54d7307928f63414defd96399fc31ba847961ceaecef3a5fd93144e960c0e151';
var _baseUrl = 'https://kitsu.io/api/edge';

var _limit = 6;

Future<List> fetchTrending({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/trending/$mediaType?limit=$_limit';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body)['data'];
  });
}

Future<List> fetchTopCurrent({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'filter[status]=current&'
      'sort=-user_count';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body)['data'];
  });
}

Future<List> fetchTopUpcoming({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'filter[status]=upcoming&'
      'sort=-user_count';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body)['data'];
  });
}

Future<List> fetchHighestRated({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'sort=-average_rating';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body)['data'];
  });
}

Future<List> fetchMostPopular({
  @required http.Client client,
  @required String mediaType}) async {
  var _uri = '$_baseUrl/$mediaType?limit=$_limit&'
      'sort=-user_count';
  return client.get(Uri.encodeFull(_uri)).then((response) {
    return JSON.decode(response.body)['data'];
  });
}

Future<String> login({
  @required http.Client client,
  @required String username,
  @required String password}) async {
  var body = new HashMap<String, String>();
  body['grant_type'] = 'password';
  body['client_id'] = _clientId;
  body['client_secret'] = _clientSecret;
  body['username'] = username;
  body['password'] = password;
  return client.post('https://kitsu.io/api/oauth/token', body: body,)
      .then((response) {
    return response.body;
  });
}