import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_app/chart.dart';
import 'dart:convert';

class GetValues {
  static String apiKey = '********';

  Charts charts = new Charts();

  // Stock Variables Below
  static List<double?> stockArray = List.generate(27, (index) => null);
  static List<dynamic>? stockValuesFutures = [];
  static List<double?> btcYdata = [];
  static List<double?> ethYdata = [];
  static List<double?> solYdata = [];

  // Apple Variables
  // static double? aaplPrice;
  // static double? aaplChange;
  // static double? aaplTotal;
  // CrowdStrike Variables
  // static double? crwdPrice;
  // static double? crwdChange;
  // static double? crwdTotal;
  // Hut 8 Mining Variables
  // static double? hutPrice;
  // static double? hutChange;
  // static double? hutTotal;
  // Proctor & Gamble Variables
  // static double? pgPrice;
  // static double? pgChange;
  // static double? pgTotal;
  // Tesla Motors Variables
  // static double? tslaPrice;
  // static double? tslaChange;
  // static double? tslaTotal;
  // Samsara Variables
  // static double? iotPrice;
  // static double? iotChange;
  // static double? iotTotal;
  // Amazon Variables
  // static double? amznPrice;
  // static double? amznChange;
  // static double? amznTotal;
  // Nvidia Variables
  // static double? nvdaPrice;
  // static double? nvdaChange;
  // static double? nvdaTotal;
  // Meta Variables
  // static double? metaPrice;
  // static double? metaChange;
  // static double? metaTotal;

  // Crypto Variables below
  // Bitcoin Variables
  static double? btcPrice;
  static double? btcChange;
  static double? btcTotal;
  // Solana Variables
  static double? solPrice;
  static double? solChange;
  static double? solTotal;
  // Etherium Variables
  static double? ethPrice;
  static double? ethChange;
  static double? ethTotal;

// Getting current date value for our main page
  static String getDate() {
    DateTime now = new DateTime.now();
    DateFormat formatter = new DateFormat('MMMM d y');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

// Obtaining the Bitcoin 5 minute inteval data for our crypto charts
  static Future<double> getBTCChartData() async {
    final response = await http.get(Uri.parse(
        'https://data-api.binance.vision/api/v3/klines?symbol=BTCUSDT&interval=5m&limit=200'));

    try {
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        btcYdata = jsonList.map((e) => double.parse(e[4])).toList();
        // The `closePrices` variable now contains a list of doubles with all the close prices.
        return 3.0;
      } else {
        throw Exception('Failed to get Bitcoin chart data');
      }
    } on Exception catch (error) {
      print(error);
      return 3.0;
    }
  }

// Obtaining the Solana 5 minute inteval data for our crypto charts
  static Future<double> getSOLChartData() async {
    final response = await http.get(Uri.parse(
        'https://data-api.binance.vision/api/v3/klines?symbol=SOLUSDT&interval=5m&limit=200'));

    try {
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        solYdata = jsonList.map((e) => double.parse(e[4])).toList();
        // The `closePrices` variable now contains a list of doubles with all the close prices.
        return 3.0;
      } else {
        throw Exception('Failed to get Solana chart data');
      }
    } on Exception catch (error) {
      print(error);
      return 3.0;
    }
  }

// Obtaining the Solana 5 minute inteval data for our crypto charts
  static Future<double> getETHChartData() async {
    final response = await http.get(Uri.parse(
        'https://data-api.binance.vision/api/v3/klines?symbol=ETHUSDT&interval=5m&limit=200'));

    try {
      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body) as List<dynamic>;
        ethYdata = jsonList.map((e) => double.parse(e[4])).toList();
        // The `closePrices` variable now contains a list of doubles with all the close prices.
        return 3.0;
      } else {
        throw Exception('Failed to get Etherium chart data');
      }
    } on Exception catch (error) {
      print(error);
      return 3.0;
    }
  }

  // These next 2 methods are for getting crypto data

  // Method is called and gets all current prices
  static Future<double> getCryptoPrices() async {
    final response = await http.get(Uri.parse(
        'https://data-api.binance.vision/api/v3/ticker/price?symbols=%5B%22BTCUSDT%22,%22ETHUSDT%22,%22SOLUSDT%22%5D'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final prices = data.map((e) => double.parse(e['price'])).toList();
      btcPrice = prices[0];
      ethPrice = prices[1];
      solPrice = prices[2];
      final double price = prices[1];
      return price;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // Method is called to get 24 price changes and price change percentages
  static Future<double> getCryptoValues() async {
    final response = await http.get(Uri.parse(
        'https://data-api.binance.vision/api/v3/ticker/24hr?symbols=%5B%22BTCUSDT%22,%22ETHUSDT%22,%22SOLUSDT%22%5D'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final List<double> priceChange =
          data.map((e) => double.parse(e['priceChange'])).toList();
      final List<double> priceChangePercent =
          data.map((e) => double.parse(e['priceChangePercent'])).toList();

      btcChange = priceChangePercent[0];
      ethChange = priceChangePercent[1];
      solChange = priceChangePercent[2];

      btcTotal = priceChange[0];
      ethTotal = priceChange[1];
      solTotal = priceChange[2];
      final double price = priceChange[1];
      return price;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // Method is called for each stock to get current price
  static Future<double> getAllPrices(String symb) async {
    final response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/quote?symbol=$symb&token=$apiKey'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String priceString = jsonResponse['c'].toString();
      final double price = double.parse(priceString);
      // final double price = jsonResponse['c'];
      return price;
    } else {
      throw Exception('Failed to fetch price');
    }
  }

  // Method is called for each stock to get the daily increase or decrease amount
  static Future<double> getAllTotals(String symb) async {
    final response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/quote?symbol=$symb&token=$apiKey'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String totalString = jsonResponse['d'].toString();
      final double total = double.parse(totalString);
      // final double total = jsonResponse['d'];
      return total;
    } else {
      throw Exception('Failed to fetch total');
    }
  }

  // Method is called for each stock to get the percent, daily changes
  static Future<double> getAllChanges(String symb) async {
    final response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/quote?symbol=$symb&token=$apiKey'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String changeString = jsonResponse['dp'].toString();
      final double change = double.parse(changeString);
      // final double change = jsonResponse['dp'];
      return change;
    } else {
      throw Exception('Failed to fetch change');
    }
  }

  static Future<void> fetchCryptoData() async {
    // Create a list of Futures for each method call
    List<Future<void>> futures = [
      getCryptoPrices(),
      getCryptoValues(),
      getBTCChartData(),
      getSOLChartData(),
      getETHChartData()
    ];

    // Execute all futures in parallel using Future.wait()
    await Future.wait(futures);
  }

  static Future<double> getAllValues() async {
    List<String> symbols = [
      'AAPL', // Values in array are 0-2
      'HUT', // Values in array are 3-5
      'PG', // Values in array are 6-8
      'TSLA', // Values in array are 9-11
      'SNOW', // Values in array are 12-14
      'IOT', // Values in array are 15-17
      'AMZN', // Values in array are 18-20
      'META', // Values in array are 21-23
      'VOO' // Values in array are 24-26
    ]; //List of Stock symbols

    // Calling this method to get current crypto prices
    // await getCryptoPrices();
    // await getCryptoValues();
    // // Getting the chart data for Crypto (BTC, SOL, ETH)
    // await getCryptoChartData();

    double sum = 0;
    final futures = <Future>[];

    for (final symbol in symbols) {
      futures.add(getAllPrices(symbol));
      futures.add(getAllChanges(symbol));
      futures.add(getAllTotals(symbol));
    }
    await executeFutures(futures);
    await fetchCryptoData();
    // final results = await Future.wait(futures);

    return sum;
  }

  static List<dynamic>? results;
  static Future<void> executeFutures(List<Future<dynamic>> futures) async {
    results = await Future.wait(futures);

    for (int i = 0; i < results!.length; i++) {
      stockValuesFutures!.add(results![i]);
    }
  }

  // Get prices, changes, and totals for all symbols
//     for (int i = 0; i < symbols.length; i++) {
//       String symbol = symbols[i];
//       double? price = await getAllPrices(symbol);
//       double? change = await getAllChanges(symbol);
//       double? total = await getAllTotals(symbol);
//
//       // Update state variables for each symbol
//       switch (symbol) {
//         case 'AAPL':
//           stockArray[0] = price;
//           stockArray[1] = change;
//           stockArray[2] = total;
//           // aaplPrice = price;
//           // aaplChange = change;
//           // aaplTotal = total;
//           break;
//         case 'HUT':
//           stockArray[3] = price;
//           stockArray[4] = change;
//           stockArray[5] = total;
//           // hutPrice = price;
//           // hutChange = change;
//           // hutTotal = total;
//           break;
//         case 'PG':
//           stockArray[6] = price;
//           stockArray[7] = change;
//           stockArray[8] = total;
//           // pgPrice = price;
//           // pgChange = change;
//           // pgTotal = total;
//           break;
//         case 'TSLA':
//           stockArray[9] = price;
//           stockArray[10] = change;
//           stockArray[11] = total;
//           // tslaPrice = price;
//           // tslaChange = change;
//           // tslaTotal = total;
//           break;
//         case 'CRWD':
//           stockArray[12] = price;
//           stockArray[13] = change;
//           stockArray[14] = total;
//           // crwdPrice = price;
//           // crwdChange = change;
//           // crwdTotal = total;
//           break;
//         case 'IOT':
//           stockArray[15] = price;
//           stockArray[16] = change;
//           stockArray[17] = total;
//           // iotPrice = price;
//           // iotChange = change;
//           // iotTotal = total;
//           break;
//         case 'AMZN':
//           stockArray[18] = price;
//           stockArray[19] = change;
//           stockArray[20] = total;
//           // amznPrice = price;
//           // amznChange = change;
//           // amznTotal = total;
//           break;
//         case 'META':
//           stockArray[21] = price;
//           stockArray[22] = change;
//           stockArray[23] = total;
//           // metaPrice = price;
//           // metaChange = change;
//           // metaTotal = total;
//           break;
//         case 'NVDA':
//           stockArray[24] = price;
//           stockArray[25] = change;
//           stockArray[26] = total;
//           // nvdaPrice = price;
//           // nvdaChange = change;
//           // nvdaTotal = total;
//           break;
//       }
//       // Add price to sum if not null
//       sum += price;
//     }
  // Return sum of all prices

  static getColor(double? change) {
    if (change == null) {
      throw Exception('Change value is null');
    } else if (change < 0) {
      return Colors.red;
    } else if (change == 0) {
      return Colors.grey[600];
    } else {
      return Colors.green[600];
    }
  }
} //end class
