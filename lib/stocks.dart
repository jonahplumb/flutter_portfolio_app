import 'package:flutter/material.dart';

import 'package:portfolio_app/get_values.dart';

/// Database notes
/// Columns
/// 1. aapl_shares
/// 2. tsla_shares
/// 3. hut_shares
/// 4. amzn_shares
/// 5. meta_shares
/// 6. snow_shares
/// 7. pg_shares
/// 8. iot_shares
/// 9. voo_shares

class Stock {
  final String symbol;
  final String company;
  final double? price;
  final double? change;
  final double? total;

  Stock(
      {required this.symbol,
      required this.company,
      required this.price,
      required this.change,
      required this.total});

  static List<Stock> getAll() {
    List<Stock> stocks = [];
    stocks.add(Stock(
        company: "Bitcoin",
        symbol: "BTC",
        price: GetValues.btcPrice,
        change: GetValues.btcChange,
        total: GetValues.btcTotal));
    stocks.add(Stock(
        company: "Etherium",
        symbol: "ETH",
        price: GetValues.ethPrice,
        change: GetValues.ethChange,
        total: GetValues.ethTotal));
    stocks.add(Stock(
        company: "Solana",
        symbol: "SOL",
        price: GetValues.solPrice,
        change: GetValues.solChange,
        total: GetValues.solTotal));
    stocks.add(Stock(
        company: "Apple",
        symbol: "AAPL",
        price: GetValues.stockValuesFutures?[0],
        change: GetValues.stockValuesFutures?[1],
        total: GetValues.stockValuesFutures?[2]));
    stocks.add(Stock(
        company: "Tesla",
        symbol: "TSLA",
        price: GetValues.stockValuesFutures?[9],
        change: GetValues.stockValuesFutures?[10],
        total: GetValues.stockValuesFutures?[11]));
    stocks.add(Stock(
        company: "Wow so awesome",
        symbol: "HUT",
        price: GetValues.stockValuesFutures?[3],
        change: GetValues.stockValuesFutures?[4],
        total: GetValues.stockValuesFutures?[5]));
    stocks.add(Stock(
        company: "Amazon",
        symbol: "AMZN",
        price: GetValues.stockValuesFutures?[18],
        change: GetValues.stockValuesFutures?[19],
        total: GetValues.stockValuesFutures?[20]));
    stocks.add(Stock(
        company: "Basically Facebook",
        symbol: "META",
        price: GetValues.stockValuesFutures?[21],
        change: GetValues.stockValuesFutures?[22],
        total: GetValues.stockValuesFutures?[23]));
    stocks.add(Stock(
        company: "Snowflake",
        symbol: "SNOW",
        price: GetValues.stockValuesFutures?[12],
        change: GetValues.stockValuesFutures?[13],
        total: GetValues.stockValuesFutures?[14]));
    stocks.add(Stock(
        company: "Proctor & Gamble",
        symbol: "PG",
        price: GetValues.stockValuesFutures?[6],
        change: GetValues.stockValuesFutures?[7],
        total: GetValues.stockValuesFutures?[8]));
    stocks.add(Stock(
        company: "Samsara Inc",
        symbol: "IOT",
        price: GetValues.stockValuesFutures?[15],
        change: GetValues.stockValuesFutures?[16],
        total: GetValues.stockValuesFutures?[17]));
    stocks.add(Stock(
        company: "Vanguard S&P 500",
        symbol: "VOO",
        price: GetValues.stockValuesFutures?[24],
        change: GetValues.stockValuesFutures?[25],
        total: GetValues.stockValuesFutures?[26]));

    return stocks;
  }
}
