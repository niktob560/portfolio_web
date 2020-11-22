import 'package:flutter/material.dart';
import 'package:portfolio_web/root.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue
      ),
      home: RootWidget(),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
