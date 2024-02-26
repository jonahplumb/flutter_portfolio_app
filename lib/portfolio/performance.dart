import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/main_screen.dart';
import 'package:portfolio_app/portfolio/calculations.dart';
import 'package:portfolio_app/portfolio/cards.dart';
import 'package:portfolio_app/portfolio/main_card.dart';
import 'package:portfolio_app/portfolio/settings.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Performance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pagecontroller
    final _controller = PageController();

    return Scaffold(
      backgroundColor: backColor,
      // backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            // Room between app bar and cards
            const SizedBox(
              height: 25,
            ),
            // Portfolio Performance Card, Bread Selling Card and Bread Makin Card
            // Performance Cards
            // Center(child: Cards())

            Container(
              height: 200,
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: [
                  // Replace with mainCard()
                  mainCard(
                    cardDetails: 'Portfolio',
                    balance:
                        Settings.getPortfolioPerformance().toStringAsFixed(2),
                    color: Color.fromARGB(255, 9, 88, 88),
                  ),
                  Cards(
                    cardDetails: 'Bread Making',
                    balance: Calculations.getBestPerformerTotal(
                            Calculations.getBestPerformer())
                        .toStringAsFixed(2),
                    cardNumber: 'Top Performer',
                    color: Colors.green[500],
                    symbol: Calculations.getBestPerformer(),
                  ),
                  Cards(
                    cardDetails: 'Bread Selling',
                    balance: Calculations.getWorstPerformerTotal(
                            Calculations.getWorstPerformer())
                        .toStringAsFixed(2),
                    cardNumber: 'Worst Performer',
                    color: Colors.red[500],
                    symbol: Calculations.getWorstPerformer(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(activeDotColor: Colors.grey.shade800),
            ),

            /// Add stuf below the cards here
            /// Feel free to add sized box

            const SizedBox(
              height: 45,
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(children: [
                      PieChart(PieChartData(sections: [
                        PieChartSectionData(
                            value: 15.0, color: Colors.green, showTitle: false),
                        PieChartSectionData(
                            value: 25.0, color: Colors.red, showTitle: false)
                      ])),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
