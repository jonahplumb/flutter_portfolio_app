/*
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Charts extends StatelessWidget {
  const Charts({Key? key}) : super(key: key);

  static List<double?> xValues = [150.3, 156, 150.1, 150.3, 157];
  static List<double?> yValues = [150.3, 156, 150.1, 150.3, 157];

  @override
  Widget build(BuildContext context) {
    double minY = yValues
            .reduce((value, element) => value! < element! ? value : element)! -
        10;
    double maxY = yValues
            .reduce((value, element) => value! > element! ? value : element)! +
        10;

    return Scaffold(
      body: ListView.builder(
        itemCount: xValues.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(16),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: xValues.length.toDouble() - 1,
                minY: minY.isFinite ? minY : 0,
                maxY: maxY.isFinite ? maxY : 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      xValues.length,
                      (index) =>
                          FlSpot(index.toDouble(), yValues[index]!.toDouble()),
                    ),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
//     return Scaffold(
//       body: LineChart(
//         LineChartData(
//           // Define X and Y axes
//           minX: 0,
//           maxX: xValues.length.toDouble() - 1,
//           minY: minY.isFinite ? minY : 0,
//           maxY: maxY.isFinite ? maxY : 100,
//
//           // Define data points for the line chart
//           lineBarsData: [
//             LineChartBarData(
//               spots: List.generate(
//                 xValues.length,
//                 (index) => FlSpot(index.toDouble(), yValues[index]!.toDouble()),
//               ),
//               isCurved: true,
//               color: Colors.blue,
//               barWidth: 3,
//             ),
//           ],
//         ),
//       ),
//     );
  }
}
*/
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/get_values.dart';

class Chart extends StatelessWidget {
  final List<double?> xValues;
  final List<double?> yValues;
  final double? intervalValue;
  final double? maximumY;

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//         fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white);
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('Open', style: style);
//         break;
//       case 190:
//         text = const Text('Close', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

  String abbreviateNumber(double number) {
    if (number >= 1000 && number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else {
      return '${number.toInt()}';
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(abbreviateNumber(value),
          style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white, fontSize: 12))),
      //Text('$value', style: style),
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    // const style = TextStyle(
    //     fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
    Widget text;
    switch (value.toInt()) {
      case 100:
        text = Text("placholder",
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)));
        break;
      default:
        text = Text('',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)));
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  const Chart(
      {Key? key,
      required this.xValues,
      required this.yValues,
      required this.maximumY,
      required this.intervalValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double minY = yValues
            .reduce((value, element) => value! < element! ? value : element)! -
        10;
    double maxY = yValues
            .reduce((value, element) => value! > element! ? value : element)! +
        10;

    return Container(
      height: 380,
      width: 380,
      padding: EdgeInsets.fromLTRB(16, 16, 11, 16),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 200,
          minY: minY.isFinite ? minY : 0,
          maxY: maxY.isFinite ? maxY : 250,
          borderData: FlBorderData(
              show: false, border: Border.all(color: Colors.white)),
          titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: false,
              )),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,
                      interval: intervalValue,
                      getTitlesWidget: leftTitleWidgets))),
          lineBarsData: [
            LineChartBarData(
                spots: List.generate(
                  xValues.length,
                  (index) =>
                      FlSpot(index.toDouble(), yValues[index]!.toDouble()),
                ),
                isCurved: true,
                // color: Colors.blue,
                // color: Colors.white
                color: Colors.cyanAccent,
                barWidth: 2,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                    show: true,
                    // color: Color.fromARGB(255, 19, 49, 73)
                    color: Color.fromARGB(255, 9, 88, 88))),
          ],
        ),
      ),
    );
  }
}

class Charts extends StatelessWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 2, 11, 53),
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Bitcoin 24HR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ))
              ],
            ),
            Chart(
              xValues: [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26,
                27,
                28,
                29,
                30,
                31,
                32,
                33,
                34,
                35,
                36,
                37,
                38,
                39,
                40,
                41,
                42,
                43,
                44,
                45,
                46,
                47,
                48,
                49,
                50,
                51,
                52,
                53,
                54,
                55,
                56,
                57,
                58,
                59,
                60,
                61,
                62,
                63,
                64,
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                79,
                80,
                81,
                82,
                83,
                84,
                85,
                86,
                87,
                88,
                89,
                90,
                91,
                92,
                93,
                94,
                95,
                96,
                97,
                98,
                99,
                100,
                101,
                102,
                103,
                104,
                105,
                106,
                107,
                108,
                109,
                110,
                111,
                112,
                113,
                114,
                115,
                116,
                117,
                118,
                119,
                120,
                121,
                122,
                123,
                124,
                125,
                126,
                127,
                128,
                129,
                130,
                131,
                132,
                133,
                134,
                135,
                136,
                137,
                138,
                139,
                140,
                141,
                142,
                143,
                144,
                145,
                146,
                147,
                148,
                149,
                150,
                151,
                152,
                153,
                154,
                155,
                156,
                157,
                158,
                159,
                160,
                161,
                162,
                163,
                164,
                165,
                166,
                167,
                168,
                169,
                170,
                171,
                172,
                173,
                174,
                175,
                176,
                177,
                178,
                179,
                180,
                181,
                182,
                183,
                184,
                185,
                186,
                187,
                188,
                189,
                190,
                191,
                192,
                193,
                194,
                195,
                196,
                197,
                198,
                199,
                200
              ],
              yValues: GetValues.btcYdata,
              maximumY: 250,
              intervalValue: 500,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Etherium 24HR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ))
              ],
            ),
            Chart(
              xValues: [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26,
                27,
                28,
                29,
                30,
                31,
                32,
                33,
                34,
                35,
                36,
                37,
                38,
                39,
                40,
                41,
                42,
                43,
                44,
                45,
                46,
                47,
                48,
                49,
                50,
                51,
                52,
                53,
                54,
                55,
                56,
                57,
                58,
                59,
                60,
                61,
                62,
                63,
                64,
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                79,
                80,
                81,
                82,
                83,
                84,
                85,
                86,
                87,
                88,
                89,
                90,
                91,
                92,
                93,
                94,
                95,
                96,
                97,
                98,
                99,
                100,
                101,
                102,
                103,
                104,
                105,
                106,
                107,
                108,
                109,
                110,
                111,
                112,
                113,
                114,
                115,
                116,
                117,
                118,
                119,
                120,
                121,
                122,
                123,
                124,
                125,
                126,
                127,
                128,
                129,
                130,
                131,
                132,
                133,
                134,
                135,
                136,
                137,
                138,
                139,
                140,
                141,
                142,
                143,
                144,
                145,
                146,
                147,
                148,
                149,
                150,
                151,
                152,
                153,
                154,
                155,
                156,
                157,
                158,
                159,
                160,
                161,
                162,
                163,
                164,
                165,
                166,
                167,
                168,
                169,
                170,
                171,
                172,
                173,
                174,
                175,
                176,
                177,
                178,
                179,
                180,
                181,
                182,
                183,
                184,
                185,
                186,
                187,
                188,
                189,
                190,
                191,
                192,
                193,
                194,
                195,
                196,
                197,
                198,
                199,
                200
              ],
              yValues: GetValues.ethYdata,
              maximumY: 250,
              intervalValue: 250,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Solana 24HR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ))
              ],
            ),
            Chart(
              xValues: [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26,
                27,
                28,
                29,
                30,
                31,
                32,
                33,
                34,
                35,
                36,
                37,
                38,
                39,
                40,
                41,
                42,
                43,
                44,
                45,
                46,
                47,
                48,
                49,
                50,
                51,
                52,
                53,
                54,
                55,
                56,
                57,
                58,
                59,
                60,
                61,
                62,
                63,
                64,
                65,
                66,
                67,
                68,
                69,
                70,
                71,
                72,
                73,
                74,
                75,
                76,
                77,
                78,
                79,
                80,
                81,
                82,
                83,
                84,
                85,
                86,
                87,
                88,
                89,
                90,
                91,
                92,
                93,
                94,
                95,
                96,
                97,
                98,
                99,
                100,
                101,
                102,
                103,
                104,
                105,
                106,
                107,
                108,
                109,
                110,
                111,
                112,
                113,
                114,
                115,
                116,
                117,
                118,
                119,
                120,
                121,
                122,
                123,
                124,
                125,
                126,
                127,
                128,
                129,
                130,
                131,
                132,
                133,
                134,
                135,
                136,
                137,
                138,
                139,
                140,
                141,
                142,
                143,
                144,
                145,
                146,
                147,
                148,
                149,
                150,
                151,
                152,
                153,
                154,
                155,
                156,
                157,
                158,
                159,
                160,
                161,
                162,
                163,
                164,
                165,
                166,
                167,
                168,
                169,
                170,
                171,
                172,
                173,
                174,
                175,
                176,
                177,
                178,
                179,
                180,
                181,
                182,
                183,
                184,
                185,
                186,
                187,
                188,
                189,
                190,
                191,
                192,
                193,
                194,
                195,
                196,
                197,
                198,
                199,
                200
              ],
              yValues: GetValues.solYdata,
              maximumY: 250,
              intervalValue: 20,
            ),
          ],
        ));
  }
}
