import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Facebook DPL"),
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            child: _isLoggedIn == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Nama Profile FB : ${_userObj["name"]}"),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Email FB anda : ${_userObj["email"]}"),
                      SizedBox(
                        height: 16,
                      ),
                      TextButton(
                          onPressed: () {
                            FacebookAuth.instance.logOut().then((value) {
                              setState(() {
                                _isLoggedIn = false;
                                _userObj = {};
                              });
                            });
                          },
                          child: Text("Logout"))
                    ],
                  )
                : Center(
                    child: ElevatedButton(
                        onPressed: () {
                          FacebookAuth.instance.login(permissions: [
                            "public_profile",
                            "email"
                          ]).then((value) {
                            FacebookAuth.instance
                                .getUserData()
                                .then((userData) async {
                              setState(() {
                                _isLoggedIn = true;
                                _userObj = userData;
                              });
                            });
                          });
                        },
                        child: Text("Login with Facebook")),
                  ),
          ),
        ),
      ),
    );
  }
}
