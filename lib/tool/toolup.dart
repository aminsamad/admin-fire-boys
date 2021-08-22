import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BookUpdate extends StatefulWidget {
  @override
  _BookUpdateState createState() => _BookUpdateState();
  final String id;
  const BookUpdate(this.id);
}

class _BookUpdateState extends State<BookUpdate> {
  var url = Uri.parse('https://rabarbook.000webhostapp.com/tool_id.php');

  Future<List<Studentdata>> fetchStudent() async {
    var data = {'id': int.parse(widget.id)};

    var response = await http.post(url, body: json.encode(data));

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

  final id = TextEditingController();
  final image = TextEditingController();
  final toolname = TextEditingController();
  final info = TextEditingController();
  final mb = TextEditingController();
  final link = TextEditingController();
  final name = TextEditingController();

  Future<http.Response> deleteStudent() async {
    var data = {'id': int.parse(widget.id.toString())};
    final http.Response response = await http.post(
      Uri.parse('https://rabarbook.000webhostapp.com/deletetool.php'),
      body: json.encode(data),
    );

    print(response.body);
    Navigator.pop(context);
    return response;
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'دڵنیای ده‌ته‌وێت ئه‌م پۆسته بسڕیته‌وه‌؟',
            style: TextStyle(fontFamily: 'kurdish'),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text(
                  "نه‌خێر",
                  style: TextStyle(fontFamily: 'kurdish'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            CupertinoDialogAction(
                child: Text(
                  'به‌ڵێ',
                  style: TextStyle(fontFamily: 'kurdish'),
                ),
                isDestructiveAction: true,
                onPressed: () {
                  deleteStudent();
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  Future updatereklam() async {
    // API URL
    var url = Uri.parse('https://rabarbook.000webhostapp.com/toolUpdate.php');

    var data = {
      'id': widget.id,
      'toolname': toolname.text,
      'info': info.text,
      'mb': mb.text,
      'name': name.text,
    };
    Navigator.pop(context);
    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));
    return response;
  }

  @override
  void dispose() {
    image.dispose();
    toolname.dispose();
    info.dispose();
    mb.dispose();
    link.dispose();
    name.dispose();
    super.dispose();
  }

  bool button = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ده‌ستكاریكردنی تووڵ"),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              child: FutureBuilder<List<Studentdata>>(
                future: fetchStudent(),
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
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: snapshot.data!
                          .map((data) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.deepPurple,
                                            size: 35,
                                          ),
                                          onPressed: () =>
                                              confirmDelete(context),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.deepPurple,
                                              size: 35,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                id.text = data.id.toString();
                                                info.text = data.info;
                                                mb.text = data.mb;
                                                name.text = data.name;
                                                toolname.text = data.toolname;
                                                button = true;
                                              });
                                            }),
                                      ]),
                                  const Text(''),
                                  TextField(
                                    controller: name,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ناوی پۆست',
                                      hintText: 'ناوی پۆست',
                                    ),
                                  ),
                                  const Text(''),
                                  TextField(
                                    controller: mb,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: '12 mb',
                                      hintText: '12 mb',
                                    ),
                                  ),
                                  const Text(''),
                                  TextField(
                                    controller: toolname,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ناوی توڵ',
                                      hintText: 'ناوی توڵ',
                                    ),
                                  ),
                                  const Text(''),
                                  TextField(
                                    controller: info,
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'تێبینی',
                                      hintText: 'تێبینی',
                                    ),
                                  ),
                                  const Text(''),
                                  const Text(''),
                                  if (button == true)
                                    SizedBox(
                                        height: 60,
                                        width: 300,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              updatereklam();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            child: const Text('خه‌زنكردن')))
                                ],
                              ))
                          .toList(),
                    ),
                  );
                },
              )),
        ));
  }
}

class Studentdata {
  int id;
  String mb;
  String name;
  String info;
  String toolname;

  Studentdata(
      {required this.id,
      required this.mb,
      required this.name,
      required this.info,
      required this.toolname});

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      id: json['id'],
      mb: json['mb'],
      name: json['name'],
      info: json['info'],
      toolname: json['toolname'],
    );
  }
}
