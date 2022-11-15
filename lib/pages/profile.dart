// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/pages/proddetails.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                Column(
                  children: [
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          // ignore: unused_element
                          showAlertDialog(BuildContext context) {
                            // set up the button
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () {},
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("My title"),
                              content: Text("This is my message."),
                              actions: [
                                okButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Image.network(
                                  "https://stimg.cardekho.com/images/carexteriorimages/930x620/Hyundai/Venue/9154/1655441194954/front-left-side-47.jpg?tr=w-375"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
                                child: Text(
                                  'Car and all',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Chip(
                                    label: const Text('Aaron Burr'),
                                  ),
                                  Text(
                                    '50 rs per hour',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Items you've put on rent",
                    style: TextStyle(fontSize: 20)),
                Column(
                  children: [
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Proddetails()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Image.network(
                                  "https://stimg.cardekho.com/images/carexteriorimages/930x620/Hyundai/Venue/9154/1655441194954/front-left-side-47.jpg?tr=w-375"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 2),
                                child: Text(
                                  'Car and all',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Chip(
                                    label: const Text('Aaron Burr'),
                                  ),
                                  Text(
                                    '50 rs per hour',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
