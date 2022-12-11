// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/proddetails.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = "";
  bool loading = false;
  List<dynamic> list = [
    {
      "title": "Car and all 1",
      "price": "123",
      "category": "Books",
      "interval": "hours",
      "imgurl":
          "https://stimg.cardekho.com/images/carexteriorimages/930x620/Hyundai/Venue/9154/1655441194954/front-left-side-47.jpg?tr=w-375",
    }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    loading = true;
    final prefs = await SharedPreferences.getInstance();
    Map payload = {
      "lid": "1",
    };
    var url = Uri.parse(dotenv.env["BASEURL"]! + 'get-all-listings');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload));
    Map res = json.decode(response.body);
    if (response.statusCode == 200 && res["code"] == "suc") {
      String s = prefs.getString("name") ?? "";

      setState(() {
        list = res["item"];
        username = s;
      });
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: (loading)
              ? Text("loading...")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Welcome " + username,
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "What would you like to rent today?",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var l in list)
                          Center(
                            child: Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Proddetails(
                                              lid: l["lid"],
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Image.network(l["imgurl"]),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 2),
                                        child: Text(
                                          l["title"],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Chip(
                                            label: Text(l["category"]),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                l["price"] +
                                                    ' rs per ' +
                                                    l["interval"],
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              Text(
                                                "by " + l["user"]["name"],
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ],
                ),
        ),
      )),
    );
  }
}
