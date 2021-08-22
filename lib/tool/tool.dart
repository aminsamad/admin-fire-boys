import 'dart:convert';

import 'package:admin_fire_boys/util/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'tooladdd.dart';
import 'toolup.dart';

class Tool extends StatefulWidget {
  @override
  _ToolState createState() => _ToolState();

  // ignore: use_key_in_widget_constructors
  const Tool();
}

class _ToolState extends State<Tool> {
  var apiURL = Uri.parse('https://rabarbook.000webhostapp.com/tool.php');

  Future<List<Studentdata>> fetchStudents() async {
    var response = await http.get(apiURL);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("به‌شی توڵه‌كان"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Tooladd()),
                  );
                }),
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder<List<Studentdata>>(
                      future: fetchStudents(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text(
                                  "چاوه‌ڕێكه‌",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }

                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            padding: EdgeInsets.only(bottom: 500),
                            children: snapshot.data!
                                .map((data) => ItemCard2(
                                      title: data.name,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookUpdate(
                                                      data.id.toString())),
                                        );
                                      },
                                    ))
                                .toList(),
                          ),
                        );
                      },
                    )
                  ])),
        ));
  }
}

class Studentdata {
  int id;
  String name;

  Studentdata({
    required this.id,
    required this.name,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(id: json['id'], name: json['name']);
  }
}
