import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/home.dart';
import 'package:portfolio_app/portfolio/performance.dart';
import 'package:portfolio_app/portfolio/settings.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: <Widget>[
//       Container(
//         padding: EdgeInsets.all(10),
//         width: MediaQuery.of(context).size.width,
//         // color: Color.fromARGB(255, 2, 11, 53),
//         color: Colors.black,
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text("Portfolio",
//                   style: GoogleFonts.roboto(
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           // color: Colors.black,
//                           fontSize: 36,
//                           fontWeight: FontWeight.bold))),
//               Text(GetValues.getDate(),
//                   style: GoogleFonts.roboto(
//                       textStyle: TextStyle(
//                           color: Colors.grey[500],
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold))),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Charts()),
//                     );
//                   },
//                   child: SizedBox(
//                     child: Text(
//                       "24HR Charts",
//                       style: GoogleFonts.roboto(
//                           textStyle: const TextStyle(
//                         color: Colors.white,
//                         // color: Colors.black,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         fontStyle: FontStyle.italic,
//                       )),
//                       textAlign: TextAlign.right,
//                     ),
//                     height: 50,
//                     width: 400,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height - 250,
//                 child: StockList(
//                   stocks: Stock.getAll(),
//                 ),
//               ),
//               //This is placeholder for google admob
//               Container(
//                 color: Colors.blue, // resize later per admob documentations
//                 child: SizedBox(
//                   height: 50,
//                   width: 350,
//                 ),
//               )
//             ],
//           ),
//         ),
//       )
//     ]);
//   }
// }

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final tabs = [HomePage(), Charts(), Performance(), Settings()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          // color: Colors.black,
          color: backColor,
          // color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
                gap: 8,
                backgroundColor: backColor,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.all(16),
                mainAxisAlignment: MainAxisAlignment.center,
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.stacked_bar_chart_rounded,
                    text: 'Charts',
                  ),
                  GButton(
                    icon: Icons.show_chart,
                    text: 'Portfolio',
                  ),
                  GButton(icon: Icons.settings, text: 'Settings')
                ]),
          ),
        ),
        //////
        appBar: AppBar(
          backgroundColor: backColor,
          title: Text(
            GetValues.getDate(),
            // "${Settings.getFirstValue()}",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 36,
                    fontWeight: FontWeight.bold)),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.settings),
          //     onPressed: () {
          //       // Handle settings icon pressed
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Settings()),
          //       );
          //     },
          //   ),
          // ],
        ),
        body: tabs[_currentIndex]
        // SingleChildScrollView(
        //   // Wrap the Column with SingleChildScrollView
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     width: MediaQuery.of(context).size.width,
        //     // color: Colors.black,
        //     color: testcolor2,
        //     child: SafeArea(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           // Text("Portfolio",
        //           //     style: GoogleFonts.roboto(
        //           //         textStyle: TextStyle(
        //           //             color: Colors.white,
        //           //             fontSize: 36,
        //           //             fontWeight: FontWeight.bold))),
        //           // Text(GetValues.getDate(),
        //           //     style: GoogleFonts.roboto(
        //           //         textStyle: TextStyle(
        //           //             color: Colors.grey[500],
        //           //             fontSize: 22,
        //           //             fontWeight: FontWeight.bold))),
        //           // Padding(
        //           //   padding: const EdgeInsets.only(top: 8.0),
        //           //   child: GestureDetector(
        //           //     onTap: () {
        //           //       Navigator.push(
        //           //         context,
        //           //         MaterialPageRoute(builder: (context) => Charts()),
        //           //       );
        //           //     },
        //           //     child: SizedBox(
        //           //       child: Text(
        //           //         "24HR Charts",
        //           //         style: GoogleFonts.roboto(
        //           //             textStyle: const TextStyle(
        //           //           color: Colors.white,
        //           //           fontSize: 30,
        //           //           fontWeight: FontWeight.bold,
        //           //           fontStyle: FontStyle.italic,
        //           //         )),
        //           //         textAlign: TextAlign.right,
        //           //       ),
        //           //       height: 50,
        //           //       width: 400,
        //           //     ),
        //           //   ),
        //           // ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height - 220, //was 250
        //             child: StockList(
        //               stocks: Stock.getAll(),
        //             ),
        //           ),
        //           //This is a placeholder for google admob
        //           // Container(
        //           //   color: Colors.blue, // resize later per admob documentations
        //           //   child: SizedBox(
        //           //     height: 50,
        //           //     width: 350,
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
