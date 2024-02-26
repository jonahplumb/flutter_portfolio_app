import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/stocks.dart';

class StockList extends StatefulWidget {
  final List<Stock> stocks;

  StockList({this.stocks = const []});

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  String _displayType = "change"; // default display type is "change"

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          // color: Colors.grey[400]
          color: Colors.black,
        );
      },
      itemCount: widget.stocks.length,
      itemBuilder: (context, index) {
        final stock = widget.stocks[index];

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(stock.symbol,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500))),
                    Text(stock.company,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                // color: Colors.yellow,
                                // color: Color.fromARGB(255, 9, 88, 88),
                                color: Colors.cyanAccent,
                                // color: chartColor,
                                fontSize: 20))),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${stock.price}",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.white,
                            // color: Colors.amber[300],
                            fontSize: 24,
                            fontWeight: FontWeight.w500)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _displayType =
                            _displayType == "change" ? "value" : "change";
                      });
                    },
                    child: Container(
                      width: 75,
                      height: 25,
                      child: Text(
                        _displayType == "change"
                            ? (stock.change != null
                                ? "${stock.change!.toStringAsFixed(2)}%"
                                : "")
                            : "${stock.total}",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: stock.change != null
                            ? GetValues.getColor(stock.change)
                            : Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/*
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${stock.symbol}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "${stock.company}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ]),
          trailing: Column(children: <Widget>[
            Text(
              "${stock.price}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _displayType = _displayType == "change" ? "value" : "change";
                });
              },
              child: Container(
                  width: 75,
                  height: 25,
                  child: Text(
                      _displayType == "change"
                          ? (stock.change != null
                              ? "${stock.change!.toStringAsFixed(2)}%"
                              : "")
                          : "${stock.total}",
                      style: TextStyle(color: Colors.white)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: stock.change != null
                        ? GetValues.getColor(stock.change)
                        : Colors.grey[800],
                  )),
            ),
          ]),
        );
      },
    );
  }
}*/
