import 'package:flutter/material.dart';
import 'package:market_watch/state/app_state.dart';
import 'package:yahoofin/yahoofin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // polygon.io access key ------ > 8Cn4YyeppkiYTkwrbVkwaUZX2rJfCPkP
  // https://github.com/polygon-io/client-jvm/blob/master/sample/src/main/java/io/polygon/kotlin/sdk/sample/KotlinUsageSample.kt
  Future<Object?>? _api() async {
    final yfin = YahooFin();
    StockInfo info = yfin.getStockInfo(ticker: "amd");
    Future<StockQuote> price = yfin.getPrice(stockInfo: info);
    Future<StockQuote> priceChange = yfin.getPriceChange(stockInfo: info);
    Future<StockQuote> volume = yfin.getVolume(stockInfo: info);
    // return {"price": price, "priceChange": priceChange, 'volume': volume};
    return price;
  }

  @override
  void initState() {
    super.initState();
    _api();
  }

  @override
  Widget build(BuildContext context) {
    Map _userData = AppStateScope.of(context).userData;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: _api(),
            builder: (context, snapshot) {
              // Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              print('Snapshot.data in futurebuilder -----> ${snapshot.data}');
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage('${_userData['profilePhoto']}'),
                  ),
                  title: Text('${_userData['fullName']}'),
                  subtitle: Text('${snapshot.data}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
