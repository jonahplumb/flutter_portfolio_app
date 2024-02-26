import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/portfolio/settings.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap the Column with SingleChildScrollView
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        // color: Colors.black,
        color: backColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text("Portfolio",
              //     style: GoogleFonts.roboto(
              //         textStyle: TextStyle(
              //             color: Colors.white,
              //             fontSize: 36,
              //             fontWeight: FontWeight.bold))),
              // Text(GetValues.getDate(),
              //     style: GoogleFonts.roboto(
              //         textStyle: TextStyle(
              //             color: Colors.grey[500],
              //             fontSize: 22,
              //             fontWeight: FontWeight.bold))),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Charts()),
              //       );
              //     },
              //     child: SizedBox(
              //       child: Text(
              //         "24HR Charts",
              //         style: GoogleFonts.roboto(
              //             textStyle: const TextStyle(
              //           color: Colors.white,
              //           fontSize: 30,
              //           fontWeight: FontWeight.bold,
              //           fontStyle: FontStyle.italic,
              //         )),
              //         textAlign: TextAlign.right,
              //       ),
              //       height: 50,
              //       width: 400,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 210, //was 250
                child: StockList(
                  stocks: Stock.getAll(),
                ),
              ),
              //This is a placeholder for google admob
              // Container(
              //   color: Colors.blue, // resize later per admob documentations
              //   child: SizedBox(
              //     height: 50,
              //     width: 350,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
