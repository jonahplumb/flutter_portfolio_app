import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/main_screen.dart';
import 'package:portfolio_app/portfolio/cards.dart';
import 'package:portfolio_app/portfolio/settings.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:portfolio_app/portfolio/performance.dart';

class Calculations {
  static String getBestPerformer() {
    // Variables for calculating the top performer
    String largestSymbol = 'error';
    double? largestPerformance;

    Map<String, double?> stockPerformances = {
      'AAPL': GetValues.stockValuesFutures?[1],
      'TSLA': GetValues.stockValuesFutures?[10],
      'HUT': GetValues.stockValuesFutures?[4],
      'AMZN': GetValues.stockValuesFutures?[19],
      'META': GetValues.stockValuesFutures?[22],
      'SNOW': GetValues.stockValuesFutures?[13],
      'PG': GetValues.stockValuesFutures?[7],
      'IOT': GetValues.stockValuesFutures?[16],
      'VOO': GetValues.stockValuesFutures?[25],
    };

    stockPerformances.forEach((symbol, performance) {
      if (performance != null) {
        if (largestPerformance == null || performance > largestPerformance!) {
          largestPerformance = performance;
          largestSymbol = symbol;
        }
      }
    });

    return largestSymbol;
  }

  static double getBestPerformerTotal(String symbol) {
    Map<String, double?> stockPrices = {
      'AAPL': GetValues.stockValuesFutures?[0] * Settings.getAAPLShares(),
      'TSLA': GetValues.stockValuesFutures?[9] * Settings.getTSLAShares(),
      'HUT': GetValues.stockValuesFutures?[3] * Settings.getHUTShares(),
      'AMZN': GetValues.stockValuesFutures?[18] * Settings.getAMZNShares(),
      'META': GetValues.stockValuesFutures?[21] * Settings.getMETAShares(),
      'SNOW': GetValues.stockValuesFutures?[12] * Settings.getSNOWShares(),
      'PG': GetValues.stockValuesFutures?[6] * Settings.getPGShares(),
      'IOT': GetValues.stockValuesFutures?[15] * Settings.getIOTShares(),
      'VOO': GetValues.stockValuesFutures?[24] * Settings.getVOOShares(),
    };

    double value = stockPrices[symbol] ?? 0;

    // if (value != 0) {
    //   return value;
    // } else {
    //   return getBestPerformerChange(symbol);
    // }
    return value;
  }

  static double getBestPerformerChange(String symbol) {
    Map<String, double?> stockPerformances = {
      'AAPL': GetValues.stockValuesFutures?[1],
      'TSLA': GetValues.stockValuesFutures?[10],
      'HUT': GetValues.stockValuesFutures?[4],
      'AMZN': GetValues.stockValuesFutures?[19],
      'META': GetValues.stockValuesFutures?[22],
      'SNOW': GetValues.stockValuesFutures?[13],
      'PG': GetValues.stockValuesFutures?[7],
      'IOT': GetValues.stockValuesFutures?[16],
      'VOO': GetValues.stockValuesFutures?[25],
    };

    return stockPerformances[symbol] ?? 0.00;
  }

  // Above was for calculating the top performer values for the green card
  // Below is for calculating the worst performer values for the red card

  static String getWorstPerformer() {
    // Variables for calculating the worst performer
    String smallestSymbol = 'error';
    double? smallestPerformance;

    Map<String, double?> stockPerformances = {
      'AAPL': GetValues.stockValuesFutures?[1],
      'TSLA': GetValues.stockValuesFutures?[10],
      'HUT': GetValues.stockValuesFutures?[4],
      'AMZN': GetValues.stockValuesFutures?[19],
      'META': GetValues.stockValuesFutures?[22],
      'SNOW': GetValues.stockValuesFutures?[13],
      'PG': GetValues.stockValuesFutures?[7],
      'IOT': GetValues.stockValuesFutures?[16],
      'VOO': GetValues.stockValuesFutures?[25],
    };

    stockPerformances.forEach((symbol, performance) {
      if (performance != null) {
        if (smallestPerformance == null || performance < smallestPerformance!) {
          smallestPerformance = performance;
          smallestSymbol = symbol;
        }
      }
    });

    return smallestSymbol;
  }

  static double getWorstPerformerTotal(String symbol) {
    Map<String, double?> stockPrices = {
      'AAPL': GetValues.stockValuesFutures?[0] * Settings.getAAPLShares(),
      'TSLA': GetValues.stockValuesFutures?[9] * Settings.getTSLAShares(),
      'HUT': GetValues.stockValuesFutures?[3] * Settings.getHUTShares(),
      'AMZN': GetValues.stockValuesFutures?[18] * Settings.getAMZNShares(),
      'META': GetValues.stockValuesFutures?[21] * Settings.getMETAShares(),
      'SNOW': GetValues.stockValuesFutures?[12] * Settings.getSNOWShares(),
      'PG': GetValues.stockValuesFutures?[6] * Settings.getPGShares(),
      'IOT': GetValues.stockValuesFutures?[15] * Settings.getIOTShares(),
      'VOO': GetValues.stockValuesFutures?[24] * Settings.getVOOShares(),
    };

    double value = stockPrices[symbol] ?? 0;
    return value;
  }

  static double getWorstPerformerChange(String symbol) {
    Map<String, double?> stockPerformances = {
      'AAPL': GetValues.stockValuesFutures?[1],
      'TSLA': GetValues.stockValuesFutures?[10],
      'HUT': GetValues.stockValuesFutures?[4],
      'AMZN': GetValues.stockValuesFutures?[19],
      'META': GetValues.stockValuesFutures?[22],
      'SNOW': GetValues.stockValuesFutures?[13],
      'PG': GetValues.stockValuesFutures?[7],
      'IOT': GetValues.stockValuesFutures?[16],
      'VOO': GetValues.stockValuesFutures?[25],
    };

    return stockPerformances[symbol] ?? 0.00;
  }
}
