import 'dart:convert';

import 'package:admin_fire_boys/util/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'codeaddd.dart';
import 'codeup.dart';

class Codes extends StatefulWidget {
  @override
  _CodesState createState() => _CodesState();

  // ignore: use_key_in_widget_constructors
  const Codes();
}

class _CodesState extends State<Codes> with SingleTickerProviderStateMixin {
  Future<http.Response> deleteStudent(int id) async {
    var data = {'id': int.parse(id.toString())};
    final http.Response response = await http.post(
      Uri.parse('https://rabarbook.000webhostapp.com/deletecode.php'),
      body: json.encode(data),
    );

    Navigator.pop(context);
    return response;
  }

  void confirmDelete(context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'دڵنیای ده‌ته‌وێت ئه‌م پۆسته بسڕیته‌وه‌؟',
            style: TextStyle(fontFamily: 'kurdish'),
            textAlign: TextAlign.center,
          ),
          actions: [
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
                  deleteStudent(id);
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  var apiURL = Uri.parse('https://rabarbook.000webhostapp.com/code.php');

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

  final List<Tab> tabs = <Tab>[
    new Tab(text: "هه‌موو كۆده‌كان"),
    new Tab(text: "كۆدی ئه‌كتیڤ"),
    new Tab(text: "ئێكسپایه‌ر"),
  ];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('كۆده‌كان'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Codeadd()),
                  );
                }),
          ],
          bottom: new TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,

            // indicator: new BubbleTabIndicator(
            //   indicatorHeight: 25.0,
            //   indicatorColor: Colors.blueAccent,
            //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
            //   // Other flags
            //   // indicatorRadius: 1,
            //   // insets: EdgeInsets.all(1),
            //   // padding: EdgeInsets.all(10)
            // ),
            tabs: tabs,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(
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

                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView(
                                    padding: EdgeInsets.only(bottom: 500),
                                    children: snapshot.data!
                                        .map((data) => ItemCard3(
                                              codeColor:
                                                  data.expire == formattedDate
                                                      ? Colors.red
                                                      : Colors.green,
                                              user: data.user,
                                              onDeletePress: () {
                                                confirmDelete(context, data.id);
                                              },
                                              onPress: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookUpdate(data.id
                                                              .toString())),
                                                );
                                              },
                                              code: data.code,
                                              expire: data.expire,
                                              time: data.time,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ])),
            ),
            Center(
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

                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView(
                                    padding: EdgeInsets.only(bottom: 500),
                                    children: snapshot.data!
                                        .map((data) => data.expire !=
                                                formattedDate
                                            ? ItemCard3(
                                                codeColor:
                                                    data.expire == formattedDate
                                                        ? Colors.red
                                                        : Colors.green,
                                                user: data.user,
                                                onDeletePress: () {
                                                  confirmDelete(
                                                      context, data.id);
                                                },
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookUpdate(data.id
                                                                .toString())),
                                                  );
                                                },
                                                code: data.code,
                                                expire: data.expire,
                                                time: data.time,
                                              )
                                            : Container())
                                        .toList(),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ])),
            ),
            Center(
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
                                children: snapshot.data!
                                    .map((data) => data.expire == formattedDate
                                        ? ItemCard3(
                                            codeColor:
                                                data.expire == formattedDate
                                                    ? Colors.red
                                                    : Colors.green,
                                            user: data.user,
                                            onDeletePress: () {
                                              confirmDelete(context, data.id);
                                            },
                                            onPress: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookUpdate(data.id
                                                            .toString())),
                                              );
                                            },
                                            code: data.code,
                                            expire: data.expire,
                                            time: data.time,
                                          )
                                        : Container())
                                    .toList(),
                              ),
                            );
                          },
                        )
                      ])),
            ),
          ],
        ));
  }
}

class Studentdata {
  int id;
  String code;
  String expire;
  String user;
  String time;

  Studentdata({
    required this.id,
    required this.code,
    required this.expire,
    required this.user,
    required this.time,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
        id: json['id'],
        code: json['code'],
        expire: json['expire'],
        user: json['user'],
        time: json['time']);
  }
}
