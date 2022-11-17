// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/app.dart';
import 'package:frontend/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameEditing = TextEditingController();
  TextEditingController passwordEditing = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  "Rentify",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Peer to peer renting platform"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: usernameEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordEditing,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        Map payload = {
                          "username": usernameEditing.text,
                          "password": passwordEditing.text
                        };
                        var url = Uri.parse(dotenv.env["BASEURL"]! + 'login');
                        var response = await http.post(url,
                            headers: {"Content-Type": "application/json"},
                            body: json.encode(payload));
                        Map res = json.decode(response.body);
                        print(res);
                        if (response.statusCode == 200 &&
                            res["code"] == "suc") {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("name", res["name"].toString());
                          prefs.setString("username", usernameEditing.text);
                          prefs.setString("uid", res["uid"].toString());
                          prefs.setString("password", passwordEditing.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const App()),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Unable to auth"),
                                    content: Text(
                                        res["message"] ?? "Unable to auth"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: const Text("Login")),
                ),
              )
            ]),
      ),
    );
  }
}
