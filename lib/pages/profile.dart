// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/proddetails.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();

    Map payload = {
      "uid": prefs.getString("uid"),
    };
    var url = Uri.parse(dotenv.env["BASEURL"]! + 'get-profile');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload));
    Map res = json.decode(response.body);
    // print(res);
    if (response.statusCode == 200 && res["code"] == "suc") {
      setState(() {
        list = res["userrenting"];
        print(list);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Edit Profile", style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Items you have rented", style: TextStyle(fontSize: 20)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          // ignore: unused_element
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text("Do you want to return this item?"),
                                  content: Text(
                                      "This listing will be deleted from your profile page if you continue"),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("View Listing"),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Proddetails(
                                                    lid: list[index]["lid"],
                                                  )),
                                        );
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Continue"),
                                      onPressed: () async {
                                        // return item web call
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        Map payload = {
                                          "uid": prefs.getString("uid"),
                                          "lid": list[index]["lid"]
                                        };
                                        var url = Uri.parse(
                                            dotenv.env["BASEURL"]! +
                                                'return-item');
                                        var response = await http.post(url,
                                            headers: {
                                              "Content-Type": "application/json"
                                            },
                                            body: json.encode(payload));
                                        Map res = json.decode(response.body);
                                        print(res);
                                        if (response.statusCode == 200 &&
                                            res["code"] == "suc") {
                                          // print("hehe");
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text("Done bob"),
                                                    content: Text(
                                                        "Returned listing"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ));
                                        }
                                        fetchData();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Image.network(list[index]["imgurl"]),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
                                child: Text(
                                  list[index]["title"],
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Chip(
                                    label: Text(list[index]["category"]),
                                  ),
                                  Text(
                                    list[index]["price"] +
                                        ' rs per ' +
                                        list[index]["interval"],
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Items you've put on rent",
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
