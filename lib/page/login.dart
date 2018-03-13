import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginState();

}

class _LoginState extends State<LoginPage> {

  var connection = new http.Client();

  var usernameInputController = new TextEditingController();
  
  var passwordInputController = new TextEditingController();

  @override
  void dispose() {
    connection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/images/bg_authentication.png'),
            fit: BoxFit.cover,
          )
        ),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset('assets/images/icon_crown.png'),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 24.0),
                child: new Text('Milk Crown',
                  style: new TextStyle(
                    fontFamily: 'Itim',
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0.0),
                child: new Row(
                  children: <Widget>[
                    new Text('Username',
                      style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontFamily: 'Delius',
                      ),
                    ),
                  ],
                )
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 6.0, 48.0, 0.0),
                child: new TextField(
                  decoration: new InputDecoration.collapsed(
                    hintText: null,
                  ),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Itim',
                  ),
                  controller: usernameInputController,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 6.0, 48.0, 18.0),
                child: new Container(
                  height: 1.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 0.0),
                child: new Row(
                  children: <Widget>[
                    new Text('Password',
                      style: new TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontFamily: 'Delius',
                      ),
                    ),
                  ],
                )
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 6.0, 48.0, 0.0),
                child: new TextField(
                  decoration: new InputDecoration.collapsed(
                    hintText: null
                  ),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Itim',
                  ),
                  controller: passwordInputController,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 6.0, 48.0, 18.0),
                child: new Container(
                  height: 1.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 0.0),
                    child: new RaisedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: new Text('Login',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'Delius',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      color: Colors.orange.shade900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(context) async {
    var body = new HashMap<String, String>();
    body['grant_type'] = 'password';
    body['client_id'] = 'dd031b32d2f56c990b1425efe6c42ad847e7fe3ab46bf1299f05ecd856bdb7dd';
    body['client_secret'] = '54d7307928f63414defd96399fc31ba847961ceaecef3a5fd93144e960c0e151';
    body['username'] = usernameInputController.text;
    body['password'] = passwordInputController.text;
    await connection.post('https://kitsu.io/api/oauth/token',
      body: body,
    ).then((response) {
      showModalBottomSheet(context: context, builder: (context) {
        return new Container(
          child: new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Text(response.body,
              style: new TextStyle(fontFamily: 'Delius'),
            ),
          ),
        );
      }).then((dialog) {
        print(dialog.runtimeType.toString());
      });
    });
  }

}