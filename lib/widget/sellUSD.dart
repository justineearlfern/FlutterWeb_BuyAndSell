import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usdtopeso/model/model.dart';
import 'package:usdtopeso/provider/history_provider.dart';
import 'package:usdtopeso/widget/history.dart';
import 'package:usdtopeso/widget/styles.dart';

class SellUSD extends StatefulWidget {
  const SellUSD({Key key}) : super(key: key);

  @override
  SellUSDState createState() => new SellUSDState();
}

class SellUSDState extends State<SellUSD> {
  Future<USDBNS> futureAlbum;

  double spread = 0.01;
  double quotedPrice = 0;
  double totalBuy = 0.0;
  final phpController = TextEditingController();
  final dollarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchUSDBNS();
    // new Timer.periodic(
    //     Duration(seconds: 30),
    //     (Timer t) => setState(() {
    //           futureAlbum = fetchUSDBNS();
    //         }));
  }

  void callApi() {
    setState(() {
      futureAlbum = fetchUSDBNS();
    });
  }

  void _clearAll() {
    dollarController.text = "";
    phpController.text = "";
  }

  void _phpChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double php = double.parse(text);
    dollarController.text = (php * quotedPrice).toStringAsFixed(2);
    totalBuy = double.parse(text);
    totalBuy = double.parse(dollarController.text);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dollar = double.parse(text);
    phpController.text = (dollar * quotedPrice).toStringAsFixed(2);
    totalBuy = double.parse(text);
    totalBuy = double.parse(phpController.text);
  }

  @override
  Widget build(BuildContext context) {
    final HistoryProvider provider = Provider.of<HistoryProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: screenSize.width * 0.40,
        height: screenSize.height * 0.50,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: AssetImage(
                      'assets/assets/usdtopeso.PNG',
                    ),
                    height: 100,
                    width: 420,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Buy Price'),
                      Container(
                          height: 40.0,
                          width: 100.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.grey,
                                  border: Border.all(
                                    color: Colors.grey, // red as border color
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: new Center(
                                child: FutureBuilder<USDBNS>(
                                  future: futureAlbum,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //Computation for spread value
                                      _spreadValue() =>
                                          (snapshot.data.usd * spread);
                                      //Computation for buy quotation;
                                      _buyPrice() =>
                                          (snapshot.data.usd - _spreadValue())
                                              .toStringAsFixed(8);
                                      //passing the sellPrice value
                                      quotedPrice = double.parse(_buyPrice());
                                      return Text("${_buyPrice()}");
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ))),
                      Text('Amount'),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child:
                            buildTextField("", "", phpController, _phpChanged),
                      ),
                    ]),
                SizedBox(height: 10.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Total'),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                      height: 40.0,
                      width: 200.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.grey,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: new Center(
                              child: Center(
                            child: disableBuildTextField(
                                "", "", dollarController, _dollarChanged),
                          ))))
                ]),
                SizedBox(height: 10.0),
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('You have successfully sold USD'),
                            content: Text('Your total is $totalBuy'),
                          );
                        });
                    provider.addData(Transaction(
                        name: 'Sell',
                        point: 0.0,
                        createdMillis: DateTime.now(),
                        totalBuy: totalBuy));
                  },
                  child: Text('SELL'),
                )
              ]),
        ),
      ),
    );
  }
}
