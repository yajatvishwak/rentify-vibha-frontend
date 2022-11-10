// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/pages/proddetails.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "Welcome Vibha",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "What would you like to rent today?",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Center(
                  child: Card(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
