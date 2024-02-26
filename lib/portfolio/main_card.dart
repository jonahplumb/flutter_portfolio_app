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

class mainCard extends StatelessWidget {
  final String balance;
  final String cardDetails;
  final color;

  mainCard(
      {required this.balance, required this.cardDetails, required this.color});

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
          ],
        ),
      ),
    );
  }
}
