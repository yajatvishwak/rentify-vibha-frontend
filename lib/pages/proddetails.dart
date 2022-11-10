import 'package:flutter/material.dart';

class Proddetails extends StatefulWidget {
  const Proddetails();

  @override
  State<Proddetails> createState() => _ProddetailsState();
}

class _ProddetailsState extends State<Proddetails> {
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
            Image.network(
                "https://stimg.cardekho.com/images/carexteriorimages/930x620/Hyundai/Venue/9154/1655441194954/front-left-side-47.jpg?tr=w-375"),
          ],
        ),
      )),
    );
  }
}
