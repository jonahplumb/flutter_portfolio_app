import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/main_screen.dart';
import 'package:portfolio_app/portfolio/calculations.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:portfolio_app/portfolio/performance.dart';

class Cards extends StatelessWidget {
  final String balance;
  final String cardDetails;
  final String cardNumber;
  final String symbol;
  final color;

  Cards(
      {required this.balance,
      required this.cardNumber,
      required this.symbol,
      required this.cardDetails,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              cardDetails,
              style:
                  GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$' + balance.toString(),
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: Colors.white, fontSize: 30)),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardNumber,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white)),
                ),
                Text(
                  symbol,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${Calculations.getBestPerformerChange(symbol).toStringAsFixed(2)}%',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
