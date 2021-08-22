import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:password_strength/password_strength.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class Codeadd extends StatefulWidget {
  @override
  _CodeaddState createState() => _CodeaddState();

  // ignore: use_key_in_widget_constructors
  const Codeadd();
}

class _CodeaddState extends State<Codeadd> {
  late FilePickerResult? selectedfile2;
  late FilePickerResult? selectedfile;
  late Response response;
  late String progress;
  Dio dio = Dio();

  final image = TextEditingController();
  // final pdf = TextEditingController();
  // final type = TextEditingController();
  // final user = TextEditingController();
  final code = TextEditingController();
  // final downloads = TextEditingController();
  // final price = TextEditingController();
  // final point = TextEditingController();
  final nameuser = TextEditingController();

  @override
  void dispose() {
    image.dispose();
    // pdf.dispose();
    // type.dispose();
    // user.dispose();
    code.dispose();
    // downloads.dispose();
    // price.dispose();
    // point.dispose();
    nameuser.dispose();
    super.dispose();
  }

  bool button = true;
  bool btn = false;
  Future webCall(BuildContext context) async {
    // Showing CircularProgressIndicator using State.
    // API URL
    var url = Uri.parse('https://rabarbook.000webhostapp.com/code_insert.php');

    // Store all data with Param Name.
    var data = {
      'online': 'off',
      'code': code.text,
      'expire': "${selectedDate.toLocal()}".split(' ')[0],
      'user': nameuser.text,
      'time': dropdownValue
    };

    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }

    // Showing Alert Dialog with Response JSON.
  }

  String dropdownValue = 'هەفتانە';
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        locale: Locale('en'),
        firstDate: DateTime(2021),
        lastDate: DateTime(2023));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  var text = "";
  var img = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("دروستكردنی كۆد"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(''),
                const Text(''),
                TextField(
                  controller: nameuser,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ناو',
                    hintText: 'ناو',
                  ),
                ),
                const Text(''),
                TextField(
                  controller: code,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'كۆد',
                    hintText: 'كۆد',
                  ),
                ),
                const Text(''),
                // TextField(
                //   controller: info,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     suffixIcon:
                //     labelText: 'ئێكسپایه‌ر',
                //     hintText: 'ئێكسپایه‌ر',
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      IconButton(
                          onPressed: () async {
                            _selectDate(context);
                          },
                          icon: Icon(Icons.calendar_today)),
                    ],
                  ),
                ),
                const Text(''),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['هەفتانە', 'مانگانە', 'ساڵانە']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Text(''),
                const Text(''),
                CupertinoButton(
                  onPressed: () {
                    if (estimatePasswordStrength(code.text) < 0.2) {
                      Fluttertoast.showToast(
                        msg: "كۆده‌كه‌ به‌قوه‌ت نییه‌",
                      );
                    } else {
                      if (estimatePasswordStrength(code.text) < 0.7) {
                        Fluttertoast.showToast(
                            msg: "كۆده‌كی به‌قوه‌ت تر دروستكه‌");
                      } else {
                        validate();
                      }
                    }
                  },
                  child: Text(
                    "پۆستكردن",
                    style: TextStyle(fontFamily: 'kurdish'),
                  ),
                  color: Colors.deepPurple[300],
                ),
              ],
            )));
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  validate() {
    if (!validateStructure(code.text)) {
      Fluttertoast.showToast(
          msg: "كاكه‌ هێما و ژماره‌ و پیت دانێ با پیتی كه‌پیته‌ڵیشی تێدابی");

      return;
    } else {
      webCall(context);
      setState(() {
        btn = false;
      });
    }
    // Continue
  }
}

class User {
  String name;
  int book;

  User({required this.name, required this.book});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], book: json['book']);
  }
}
