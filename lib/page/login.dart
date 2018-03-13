import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:milk_crown/network_call.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginState();

}

class _LoginState extends State<LoginPage> {

  var _connection = new http.Client();

  var _usernameInputController = new TextEditingController();
  
  var _passwordInputController = new TextEditingController();

  @override
  void dispose() {
    _connection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login',
          style: new TextStyle(fontFamily: 'Itim',),
        ),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.brown.shade50
        ),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 24.0),
                child: new Text('Login with your Kitsu.io account',
                  style: new TextStyle(
                    fontFamily: 'Itim',
                    color: Colors.brown,
                    fontSize: 18.0,
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0.0),
                child: new Row(
                  children: <Widget>[
                    new Text('Username',
                      style: new TextStyle(
                        color: Colors.brown.shade300,
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
                    color: Colors.brown,
                    fontSize: 18.0,
                    fontFamily: 'Itim',
                  ),
                  controller: _usernameInputController,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 6.0, 48.0, 18.0),
                child: new Container(
                  height: 1.0,
                  decoration: new BoxDecoration(
                    color: Colors.brown,
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 0.0),
                child: new Row(
                  children: <Widget>[
                    new Text('Password',
                      style: new TextStyle(
                        color: Colors.brown.shade300,
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
                    color: Colors.brown,
                    fontSize: 18.0,
                    fontFamily: 'Itim',
                  ),
                  controller: _passwordInputController,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(48.0, 6.0, 48.0, 18.0),
                child: new Container(
                  height: 1.0,
                  decoration: new BoxDecoration(
                    color: Colors.brown,
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
                        _login(context);
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

  _login(context) async {
    login(
      client: _connection,
      username: _usernameInputController.text,
      password: _passwordInputController.text)
        .then((response) {
      showModalBottomSheet(context: context, builder: (context) {
        return new Container(
          child: new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Text(response,
              style: new TextStyle(fontFamily: 'Delius'),
            ),
          ),
        );
      });
    });
  }

}