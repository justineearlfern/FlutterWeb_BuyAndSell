// Packages
import 'package:flutter/material.dart';
import 'package:usdtopeso/login.dart';
import 'package:usdtopeso/widget/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USD Buy and Sell',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(-1.0, -2.0),
                        end: Alignment(1.0, 2.0),
                        colors: [Color(0xFFE6F4F1), Color(0xFF4CAF50)]))),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (widget, animation) =>
                    ScaleTransition(child: widget, scale: animation),
                child: LogIn()),
          ],
        ),
      ),
    );
  }
}
