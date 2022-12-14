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
  TextEditingController usernameEditing = TextEditingController();
  TextEditingController passwordEditing = TextEditingController();
  TextEditingController phonenumberEditing = TextEditingController();
  TextEditingController nameEditing = TextEditingController();

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
  List<dynamic> others = [];

  void fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    nameEditing.text = prefs.getString("name")!;
    usernameEditing.text = prefs.getString("username")!;
    passwordEditing.text = prefs.getString("password")!;
    phonenumberEditing.text = prefs.getString("phonenumber")!;
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
        others = res["otheruserrentingyourproducts"];
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
                SizedBox(height: 8),
                Text("username", style: TextStyle(fontSize: 15)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameEditing,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text("password", style: TextStyle(fontSize: 15)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordEditing,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text("phone", style: TextStyle(fontSize: 15)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: phonenumberEditing,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone',
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text("name", style: TextStyle(fontSize: 15)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameEditing,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();

                      Map payload = {
                        "username": usernameEditing.text,
                        "password": passwordEditing.text,
                        "phonenumber": phonenumberEditing.text,
                        "name": nameEditing.text,
                        "uid": prefs.getString("uid")
                      };
                      var url =
                          Uri.parse(dotenv.env["BASEURL"]! + 'editprofile');
                      var response = await http.post(url,
                          headers: {"Content-Type": "application/json"},
                          body: json.encode(payload));
                      prefs.setString("name", nameEditing.text);
                      prefs.setString("username", usernameEditing.text);
                      prefs.setString("password", passwordEditing.text);
                      prefs.setString("phonenumber", phonenumberEditing.text);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("Saved"),
                                content: Text("Saved to db"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
                    child: Text("Save")),
                SizedBox(
                  height: 40,
                ),
                Text("Your items rented by others",
                    style: TextStyle(fontSize: 20)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: others
                        .map(
                          (e) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    e["listingname"],
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  Text("Rented by " + e["rentingusername"]),
                                  Text(e["rentinguserph"]),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Proddetails(
                                                    lid: e["listingid"],
                                                  )),
                                        );
                                      },
                                      child: Text("View Listing"))
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
