import 'dart:convert';
import 'package:ethapp/parts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fees;
  var safe_gas_fee;
  var proposed_gas_fee;
  var fast_gas_fee;
  var etherTokenPrice;
  var YourApiKeyToken = 'JCC4ZMKY6DS4CY62CUCF8VFHNRBDC615IN';
  double? fees_low;
  String? formattedDate;
  String? formattedDate2;
  String? formattedDate3;
  String? formattedDate4;
  String? formattedDate5;
  String? formattedDate6;
  String? formattedDate7;

  @override
  void initState() {
    super.initState();
    getcurrentdate();
    getEtherTokenPrice();
    getGasPrice().then((value) {
      setState(() {
        fees = value;
      });
    });
    Timer.periodic(Duration(seconds: 15), (timer) {
      getGasPriceAuto();
    });
  }

  getGasPriceAuto() {
    setState(() {
      getGasPrice();
    });
  }

  getEtherTokenPrice() async {
    var req = await http.get(Uri.parse(
        'https://api.etherscan.io/api?module=stats&action=ethprice&apikey=$YourApiKeyToken'));
    var etherPrice = json.decode(req.body);
    etherTokenPrice = etherPrice['result']['ethusd'];
  }

  getGasPrice() async {
    var req = await http.get(Uri.parse(
        "https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=JCC4ZMKY6DS4CY62CUCF8VFHNRBDC615IN"));
    fees = json.decode(req.body);
    safe_gas_fee = fees['result']['SafeGasPrice'];
    proposed_gas_fee = fees['result']['ProposeGasPrice'];
    fast_gas_fee = fees['result']['FastGasPrice'];
  }

  getcurrentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var now2 = DateTime.now().subtract(Duration(days: 1));
    var now3 = DateTime.now().subtract(Duration(days: 2));
    var now4 = DateTime.now().subtract(Duration(days: 3));
    var now5 = DateTime.now().subtract(Duration(days: 4));
    var now6 = DateTime.now().subtract(Duration(days: 5));
    var now7 = DateTime.now().subtract(Duration(days: 6));
    formattedDate = formatter.format(now);
    formattedDate2 = formatter.format(now2);
    formattedDate3 = formatter.format(now3);
    formattedDate4 = formatter.format(now4);
    formattedDate5 = formatter.format(now5);
    formattedDate6 = formatter.format(now6);
    formattedDate7 = formatter.format(now7);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              SizedBox(width: width / 2.3),
              const Text("Eth Fees"),
              SizedBox(width: width / 3.51),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(6),
                  minimumSize: Size.zero,
                ),
                onPressed: () {
                  setState(() {
                    getGasPrice();
                  });
                },
                child: const Icon(
                  Icons.refresh,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              Switch(value: false, onChanged: (newValue){}),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(33, 50, 91, 0.9),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Next update in 15 seconds"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FeeContainer(
                          gas_fee_var: safe_gas_fee,
                          type: 'Low',
                          color_color: Color.fromRGBO(1, 200, 167, 0.9)),
                      FeeContainer(
                          gas_fee_var: proposed_gas_fee,
                          type: 'Safe',
                          color_color: Color.fromRGBO(53, 153, 219, 0.9))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FeeContainer(
                          gas_fee_var: fast_gas_fee,
                          type: 'Fast',
                          color_color: Color.fromRGBO(165, 59, 55, 0.9)),
                      FeeContainer(
                          gas_fee_var: fast_gas_fee,
                          type: 'Fast',
                          color_color: Color.fromRGBO(165, 59, 55, 0.9)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Eth Average Fees for the past 7 days'),
              legend: Legend(isVisible: false),
              series: <LineSeries<GraphData, String>>[
                LineSeries<GraphData, String>(
                    dataSource: <GraphData>[
                      GraphData('$formattedDate7', 35),
                      GraphData('$formattedDate6', 28),
                      GraphData('$formattedDate5', 34),
                      GraphData('$formattedDate4', 32),
                      GraphData('$formattedDate3', 40),
                      GraphData('$formattedDate2', 40),
                      GraphData('$formattedDate', 40),
                    ],
                    xValueMapper: (GraphData fees, _) => fees.date,
                    yValueMapper: (GraphData fees, _) => fees.fees,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
                LineSeries<GraphData, String>(
                    dataSource: <GraphData>[
                      GraphData('$formattedDate7', 40),
                      GraphData('$formattedDate6', 40),
                      GraphData('$formattedDate5', 40),
                      GraphData('$formattedDate4', 40),
                      GraphData('$formattedDate3', 40),
                      GraphData('$formattedDate2', 40),
                      GraphData('$formattedDate', 40),
                    ],
                    xValueMapper: (GraphData fees, _) => fees.date,
                    yValueMapper: (GraphData fees, _) => fees.fees,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
                LineSeries<GraphData, String>(
                    dataSource: <GraphData>[
                      GraphData('$formattedDate7', 654),
                      GraphData('$formattedDate6', 367),
                      GraphData('$formattedDate5', 532),
                      GraphData('$formattedDate4', 118),
                      GraphData('$formattedDate3', 120),
                      GraphData('$formattedDate2', 120),
                      GraphData('$formattedDate', 120)
                    ],
                    xValueMapper: (GraphData fees, _) => fees.date,
                    yValueMapper: (GraphData fees, _) => fees.fees,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class GraphData {
  GraphData(this.date, this.fees);

  final String date;
  final double fees;
}
