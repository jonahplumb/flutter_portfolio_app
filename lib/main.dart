import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/main_screen.dart';
import 'package:portfolio_app/portfolio/settings.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://****.supabase.co", anonKey: "**********");

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/homepage': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoaded = false;
  double? data;

  void initState() {
    super.initState();
  }

  Future<List<double>> getData() async {
    final data = await GetValues.getAllValues();
    await Settings.getInitializeShares();
    final value = [data];
    return value;
  }
  // getData() async {
  //   data = await GetValues.getAllValues();
  //   if (data != 0) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(10),
//           width: MediaQuery.of(context).size.width,
//           color: Colors.black,
//           child: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text("Portfolio",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold)),
//                 Text(GetValues.getDate(),
//                     style: TextStyle(
//                         color: Colors.grey[500],
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold)),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: SizedBox(
//                     height: 50,
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height - 250,
//                   child: StockList(
//                     stocks: Stock.getAll(),
//                   ),
//                 ),
//                 //This is placeholder for google admob
//                 Container(
//                   color: Colors.blue, // resize later per admob documentations
//                   child: SizedBox(
//                     height: 50,
//                     width: 350,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ]), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 2, 11, 53),
        // backgroundColor: backColor,
        backgroundColor: Colors.grey[300],
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   title: Text('Portfolio'),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => const Charts()));
        //         },
        //         icon: Icon(Icons.settings))
        //   ],
        // ),
        body: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: tertiaryTextColor,
                  color: Colors.white,
                ),
              );
            } else {
              return MainScreen();
            }
          },
        ));
  }
}





// Stack(children: <Widget>[
              //   Container(
              //     padding: EdgeInsets.all(10),
              //     width: MediaQuery.of(context).size.width,
              //     // color: Color.fromARGB(255, 2, 11, 53),
              //     color: Colors.black,
              //     child: SafeArea(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text("Portfolio",
              //               style: GoogleFonts.roboto(
              //                   textStyle: TextStyle(
              //                       color: Colors.white,
              //                       // color: Colors.black,
              //                       fontSize: 36,
              //                       fontWeight: FontWeight.bold))),
              //           Text(GetValues.getDate(),
              //               style: GoogleFonts.roboto(
              //                   textStyle: TextStyle(
              //                       color: Colors.grey[500],
              //                       fontSize: 30,
              //                       fontWeight: FontWeight.bold))),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 8.0),
              //             child: GestureDetector(
              //               onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => Charts()),
              //                 );
              //               },
              //               child: SizedBox(
              //                 child: Text(
              //                   "24HR Charts",
              //                   style: GoogleFonts.roboto(
              //                       textStyle: const TextStyle(
              //                     color: Colors.white,
              //                     // color: Colors.black,
              //                     fontSize: 30,
              //                     fontWeight: FontWeight.bold,
              //                     fontStyle: FontStyle.italic,
              //                   )),
              //                   textAlign: TextAlign.right,
              //                 ),
              //                 height: 50,
              //                 width: 400,
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             height: MediaQuery.of(context).size.height - 250,
              //             child: StockList(
              //               stocks: Stock.getAll(),
              //             ),
              //           ),
              //           //This is placeholder for google admob
              //           Container(
              //             color: Colors
              //                 .blue, // resize later per admob documentations
              //             child: SizedBox(
              //               height: 50,
              //               width: 350,
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   )
              // ]); // Removed extra comma here
