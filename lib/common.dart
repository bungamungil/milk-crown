import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

SliverList createTitle(String title) {
  return new SliverList(
    delegate: new SliverChildListDelegate([
      new Padding(
        padding: new EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 12.0),
        child: new Text(title,
          style: new TextStyle(
            fontFamily: 'Delius',
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],),
  );
}

SliverGridDelegateWithFixedCrossAxisCount defaultGridDelegate() {
  return new SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3 / 4,
  );
}

launch({@required String url}) async {
  if (await launcher.canLaunch(url)) {
    await launcher.launch(url);
  }
}