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
  var url = Uri.parse('https://rabarbook.000webhostapp.com/post_id.php');

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
  final pdf = TextEditingController();
  final info = TextEditingController();
  final type = TextEditingController();
  final user = TextEditingController();
  final name = TextEditingController();
  final downloads = TextEditingController();
  final price = TextEditingController();
  final point = TextEditingController();

  Future<http.Response> deleteStudent() async {
    var data = {'id': int.parse(widget.id.toString())};
    final http.Response response = await http.post(
      Uri.parse('https://rabarbook.000webhostapp.com/deleteuser.php'),
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
          actions: <CupertinoDialogAction>[
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
    var url = Uri.parse('https://rabarbook.000webhostapp.com/postUpdate.php');

    var data = {
      'id': widget.id,
      'img': image.text,
      'info': info.text,
      'date': user.text,
      'name': name.text,
    };
    Navigator.pop(context);
    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));
    return response;
  }

  @override
  void dispose() {
    id.dispose();
    image.dispose();
    pdf.dispose();
    info.dispose();
    type.dispose();
    user.dispose();
    name.dispose();
    downloads.dispose();
    price.dispose();
    point.dispose();
    super.dispose();
  }

  bool button = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ده‌ستكاریكردنی پۆست'),
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
                                                image.text = data.img;
                                                info.text = data.info;
                                                user.text = data.date;
                                                name.text = data.name;
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
                                    controller: user,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'كات',
                                      hintText: 'كات',
                                    ),
                                  ),
                                  const Text(''),
                                  TextField(
                                    controller: image,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'وێنەی پۆست',
                                      hintText: 'وێنەی پۆست',
                                    ),
                                  ),
                                  const Text(''),
                                  TextField(
                                    controller: info,
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
  String img;
  String name;
  String info;
  String date;

  Studentdata(
      {required this.id,
      required this.img,
      required this.name,
      required this.info,
      required this.date});

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      id: json['id'],
      img: json['img'],
      name: json['name'],
      info: json['info'],
      date: json['date'],
    );
  }
}
