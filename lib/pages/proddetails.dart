// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Proddetails extends StatefulWidget {
  const Proddetails();

  @override
  State<Proddetails> createState() => _ProddetailsState();
}

class _ProddetailsState extends State<Proddetails> {
  String title = "title of the prod";
  String desc =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  String price = "42";
  String category = "Books";
  int lid = 1;
  String interval = "hour";
  String imgurl =
      "https://img.freepik.com/free-photo/red-luxury-sedan-road_114579-5079.jpg?w=2000";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    Map payload = {
      "lid": "1",
    };
    var url = Uri.parse(dotenv.env["BASEURL"]! + 'get-listing');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload));
    Map res = json.decode(response.body);
    if (response.statusCode == 200 && res["code"] == "suc") {
      setState(() {
        title = res["item"]["title"];
        desc = res["item"]["desc"];
        category = res["item"]["category"];
        price = res["item"]["price"];
        interval = res["item"]["interval"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left)),
            Image.network(imgurl), // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
              child: Text(
                title,
                style: TextStyle(fontSize: 23),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(price + " rs per " + interval),
                Chip(
                  label: Text(category),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(desc),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Rent this"),
                    )))
          ],
        ),
      )),
    );
  }
}
