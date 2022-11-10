// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add();

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String selectedInterval = "hours";
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
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: const TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Price',
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
                    items: ["hours", "months", "session", "week"]
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
                    value: selectedInterval,
                    elevation: 16,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedInterval = value!;
                      });
                    },
                    items: ["hours", "months", "session", "week"]
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
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Add item")))
            ],
          ),
        ),
      ),
    );
  }
}
