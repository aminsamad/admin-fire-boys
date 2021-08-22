import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class Bookadd extends StatefulWidget {
  @override
  _BookaddState createState() => _BookaddState();

  // ignore: use_key_in_widget_constructors
  const Bookadd();
}

class _BookaddState extends State<Bookadd> {
  late FilePickerResult? selectedfile2;
  late FilePickerResult? selectedfile;
  late Response response;
  late String progress;
  Dio dio = Dio();

  selectFile2() async {
    selectedfile2 = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
      // allowedExtensions: ['jpg', 'png', 'jpeg'],
      //allowed extension to choose
    );
    setState(() {
      img = selectedfile2!.files.first.name;
    });
  }

  uploadFile2() async {
    String uploadurl = "https://rabarbook.000webhostapp.com/img_upload.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        selectedfile2!.files.single.path.toString(),
        filename: basename(selectedfile2!.files.first.name),
        //show only filename from path
      ),
    });

    response = await dio.post(
      uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" +
              " Bytes of " "$total Bytes - " +
              percentage +
              " % uploaded";
          //update the progress
        });
      },
    );

    if (response.statusCode == 200) {
      if (response.data.toString() == '{error: false, msg: , success: false}') {
        webCall();
        Fluttertoast.showToast(
            msg: "Successful ✔️",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
        Fluttertoast.showToast(
            msg: "Successful ✔️",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
      } else {
        Fluttertoast.showToast(
            msg: "Error ❌",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);
        Fluttertoast.showToast(
            msg: "Error ❌",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0);
      }
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  final image = TextEditingController();
  final pdf = TextEditingController();
  final info = TextEditingController();
  final type = TextEditingController();
  final user = TextEditingController();
  final name = TextEditingController();
  final downloads = TextEditingController();
  final price = TextEditingController();
  final point = TextEditingController();

  @override
  void dispose() {
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

  bool button = true;
  bool btn = false;
  Future webCall() async {
    // Showing CircularProgressIndicator using State.
    DateTime now = DateTime.now();

    // API URL
    var url = Uri.parse('https://rabarbook.000webhostapp.com/post_insert.php');

    // Store all data with Param Name.
    var data = {
      'img': 'https://rabarbook.000webhostapp.com/img/' +
          basename(selectedfile2!.files.first.name),
      'info': info.text,
      'name': name.text,
      'date': DateFormat('yyyy-MM-dd').format(now)
    };

    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {}

    // Showing Alert Dialog with Response JSON.
  }

  var text = "";
  var img = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("زیادكردنی پۆست"),
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
                RaisedButton.icon(
                  onPressed: () {
                    selectFile2();
                  },
                  icon: const Icon(Icons.folder_open),
                  label: const Text("وێنەی پۆست"),
                  color: Colors.redAccent,
                  colorBrightness: Brightness.dark,
                ),
                Text(img),
                if (img != '')
                  CachedNetworkImage(
                    imageUrl: 'https://rabarbook.000webhostapp.com/img/$img',
                    height: 200,
                    width: double.infinity,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                const Text(''),
                const Text(''),
                const Text(''),
                TextField(
                  controller: name,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'سه‌ردێری پۆست',
                    hintText: 'سه‌ردێری پۆست',
                  ),
                ),
                Divider(),
                TextField(
                  controller: info,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'دیسكریپشنی پۆست',
                    hintText: 'دیسكریپشنی پۆست',
                  ),
                ),
                const Text(''),
                const Text(''),
                CupertinoButton(
                    child: Text(
                      "پۆستكردن",
                      style: TextStyle(fontFamily: 'kurdish'),
                    ),
                    color: Colors.deepPurple[300],
                    onPressed: () {
                      uploadFile2();
                      setState(() {
                        btn = false;
                      });
                    }),
              ],
            )));
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
