import 'package:admin_fire_boys/books/book.dart';
import 'package:admin_fire_boys/codes/codes.dart';
import 'package:admin_fire_boys/tool/tool.dart';
import 'package:admin_fire_boys/util/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin FireBoys',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      locale: Locale('ar', 'AE'),
      theme: ThemeData(
        fontFamily: 'kurdish',
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[300],
          centerTitle: true,
        ),
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'ئه‌دمینی كوڕانی ئاگرین'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ItemCard(
              title: "پۆستەکان",
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Book()),
                );
              },
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            ItemCard(
              title: "تووڵەکان",
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Tool()),
                );
              },
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            ItemCard(
              title: "کۆدەکان",
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Codes()),
                );
              },
              color: Colors.white,
            ),
          ],
        ),
      )),
    );
  }
}
