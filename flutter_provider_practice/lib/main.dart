import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/news_data.dart';
import 'pages/stories_page.dart';

// import 'pages/main_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MainPage(),
      home: ChangeNotifierProvider(
        create: (context) => NewsData(),
        builder: (context, child) {
          return StoriesPage();
        },
      ),
    );
  }
}
