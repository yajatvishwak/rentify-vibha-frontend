// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Add extends StatefulWidget {
  const Add();

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String selectedInterval = "hours";
  String selectedCategory = "Books";
  TextEditingController titleEditing = TextEditingController();
  TextEditingController descEditing = TextEditingController();
  TextEditingController imgurlEditing = TextEditingController();
  TextEditingController priceEditing = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "Add items to rent",
                style: TextStyle(fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 6),
                child: TextField(
                  controller: titleEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 10,
                  controller: descEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: TextField(
                  controller: priceEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Price',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: TextField(
                  controller: imgurlEditing,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Image url',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Interval"),
                  DropdownButton<String>(
                    value: selectedInterval,
                    elevation: 16,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedInterval = value!;
                      });
                    },
                    items: ["hour", "month", "session", "week"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Category"),
                  DropdownButton<String>(
                    value: selectedCategory,
                    elevation: 16,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: ["Books", "Electronics", "Furniture", "Other"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        Map payload = {
                          "title": titleEditing.text,
                          "desc": descEditing.text,
                          "price": priceEditing.text,
                          "interval": selectedInterval,
                          "category": selectedCategory,
                          "imgurl": imgurlEditing.text,
                          "uid": prefs.getString("uid")
                        };
                        var url =
                            Uri.parse(dotenv.env["BASEURL"]! + 'add-listing');
                        var response = await http.post(url,
                            headers: {"Content-Type": "application/json"},
                            body: json.encode(payload));
                        Map res = json.decode(response.body);
                        if (response.statusCode == 200 &&
                            res["code"] == "suc") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Added"),
                                    content: Text("Added item"),
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
                      child: Text("Add item")))
            ],
          ),
        ),
      ),
    );
  }
}
