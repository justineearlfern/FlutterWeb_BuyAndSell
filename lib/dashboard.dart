import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usdtopeso/widget/buyUSD.dart';
import 'package:usdtopeso/main.dart';
import 'package:usdtopeso/widget/history.dart';
import 'package:usdtopeso/widget/sellUSD.dart';
import 'provider/history_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Container(
            color: Color(0xFF4CAF50),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width / 50,
                  ),
                  InkWell(
                    onTap: () {
                      _completeLogin();
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ChangeNotifierProvider<HistoryProvider>(
            create: (context) => HistoryProvider(),
            child: SingleChildScrollView(
                controller: _controller,
                child: Column(children: <Widget>[
                  Container(
                      // width: screenSize.width * 1.00,
                      width: 1000.0,
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                child: SizedBox(
                              height: screenSize.height * 0.40,
                              width: screenSize.width * 0.30,
                              child: BuyUSD(),
                            )),
                            Container(
                                child: SizedBox(
                              height: screenSize.height * 0.40,
                              width: screenSize.width * 0.30,
                              child: SellUSD(),
                            )),
                          ],
                        )),
                      ])),
                  Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: screenSize.height * 0.70,
                        width: screenSize.width * .70,
                        child: TransactionPage(),
                      )),
                ]))));
  }

  void _completeLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => MyApp()));
  }
}
