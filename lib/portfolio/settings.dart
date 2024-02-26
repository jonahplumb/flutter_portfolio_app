import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/chart.dart';
import 'package:portfolio_app/colors.dart';
import 'package:portfolio_app/get_values.dart';
import 'package:portfolio_app/stocks.dart';
import 'package:portfolio_app/stock_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();

  // Getter methods to access in the performance/portfolio tab

  // Apple
  static double getAAPLShares() {
    return _SettingsState.AAPLShares;
  }

  // Tesla
  static double getTSLAShares() {
    return _SettingsState.TSLAShares;
  }

  // Hut
  static double getHUTShares() {
    return _SettingsState.HUTShares;
  }

  // Amazon
  static double getAMZNShares() {
    return _SettingsState.AMZNShares;
  }

  // Meta
  static double getMETAShares() {
    return _SettingsState.METAShares;
  }

  // CrowdStrike
  static double getSNOWShares() {
    return _SettingsState.SNOWShares;
  }

  // Procter & Gamble
  static double getPGShares() {
    return _SettingsState.PGShares;
  }

  // Samsara
  static double getIOTShares() {
    return _SettingsState.IOTShares;
  }

  // Nvidia
  static double getVOOShares() {
    return _SettingsState.VOOShares;
  }

  static getInitializeShares() {
    return _SettingsState.initializeShares();
  }

  //Static perform calculations like the averages etc and top performers
  static double getPortfolioPerformance() {
    // Hashmap of the latest stock prices * by the shares held, calculating total portfolio
    Map<String, double?> stockPrices = {
      'AAPL': GetValues.stockValuesFutures?[0] * getAAPLShares(),
      'TSLA': GetValues.stockValuesFutures?[9] * getTSLAShares(),
      'HUT': GetValues.stockValuesFutures?[3] * getHUTShares(),
      'AMZN': GetValues.stockValuesFutures?[18] * getAMZNShares(),
      'META': GetValues.stockValuesFutures?[21] * getMETAShares(),
      'SNOW': GetValues.stockValuesFutures?[12] * getSNOWShares(),
      'PG': GetValues.stockValuesFutures?[6] * getPGShares(),
      'IOT': GetValues.stockValuesFutures?[15] * getIOTShares(),
      'VOO': GetValues.stockValuesFutures?[24] * getVOOShares(),
    };

    // Calculating the sum of our hashmaps for our total portfolios live results
    double calculateSum(Map<String, double?> map) {
      return map.values.fold(0.0, (double? previousValue, double? element) {
        return previousValue! + (element ?? 0.0);
      });
    }

    double sum = calculateSum(stockPrices);
    return sum;
  }
}

class _SettingsState extends State<Settings> {
  TextEditingController _AAPLSharesController = TextEditingController();
  TextEditingController _TSLASharesController = TextEditingController();
  TextEditingController _HUTSharesController = TextEditingController();
  TextEditingController _AMZNSharesController = TextEditingController();
  TextEditingController _METASharesController = TextEditingController();
  TextEditingController _SNOWSharesController = TextEditingController();
  TextEditingController _PGSharesController = TextEditingController();
  TextEditingController _IOTSharesController = TextEditingController();
  TextEditingController _VOOSharesController = TextEditingController();
  String _resultText = '';

  // final supabase = Supabase.instance.client;

  /// The below methods fetches the data for the column
  /// Then returns that data as a double
  /// Reading DB for column
  static Future<double> readColumnData(String columnName) async {
    final supabase = Supabase.instance.client;
    final response =
        await supabase.from('stock_shares').select(columnName).single();
    print(response);

    // if (response.error != null) {
    //   // Handle error
    //   return 0.00;
    // }

    final doubleValue = response[columnName].toDouble();
    if (doubleValue != null) {
      double holder = doubleValue.toDouble();
      return holder;
    }
    return 0.00;
  }

  /// This method below is for responsible for calling the database and converting
  static Future<double> fetchColumnData(String columnName) async {
    double response = 0.0; // Placeholder value
    final double test = await readColumnData(columnName);
    response = test;
    return response; // Return the placeholder value immediately

    // final double response = readColumnData(columnName);
    // double placholder = response;
    // return response;
  }

  static Future<void> fetchAndAssignData() async {
    AAPLShares = await fetchColumnData('aapl_shares');
    TSLAShares = await fetchColumnData('tsla_shares');
    HUTShares = await fetchColumnData('hut_shares');
    AMZNShares = await fetchColumnData('amzn_shares');
    METAShares = await fetchColumnData('meta_shares');
    SNOWShares = await fetchColumnData('snow_shares');
    PGShares = await fetchColumnData('pg_shares');
    IOTShares = await fetchColumnData('iot_shares');
    VOOShares = await fetchColumnData('voo_shares');
  }

  static double AAPLShares = 0.00;
  static double TSLAShares = 0.00;
  static double HUTShares = 0.00;
  static double AMZNShares = 0.00;
  static double METAShares = 0.00;
  static double SNOWShares = 0.00;
  static double PGShares = 0.00;
  static double IOTShares = 0.00;
  static double VOOShares = 0.00;

  // Call fetchAndAssignData to populate the static variables
  static Future<void> initializeShares() async {
    await fetchAndAssignData();
  }

  // static double AAPLShares = fetchColumnData('aapl_shares');
  // static double TSLAShares = fetchColumnData('tsla_shares');
  // static double HUTShares = fetchColumnData('hut_shares');
  // static double AMZNShares = fetchColumnData('amzn_shares');
  // static double METAShares = fetchColumnData('meta_shares');
  // static double SNOWShares = fetchColumnData('snow_shares');
  // static double PGShares = fetchColumnData('pg_shares');
  // static double IOTShares = fetchColumnData('iot_shares');
  // static double VOOShares = fetchColumnData('voo_shares');

  @override
  void initState() {
    super.initState();
    _AAPLSharesController.text = AAPLShares.toStringAsFixed(2);
    _TSLASharesController.text = TSLAShares.toStringAsFixed(2);
    _HUTSharesController.text = HUTShares.toStringAsFixed(2);
    _AMZNSharesController.text = AMZNShares.toStringAsFixed(2);
    _METASharesController.text = METAShares.toStringAsFixed(2);
    _SNOWSharesController.text = SNOWShares.toStringAsFixed(2);
    _PGSharesController.text = PGShares.toStringAsFixed(2);
    _IOTSharesController.text = IOTShares.toStringAsFixed(2);
    _VOOSharesController.text = VOOShares.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _AAPLSharesController.dispose();
    _TSLASharesController.dispose();
    _HUTSharesController.dispose();
    _AMZNSharesController.dispose();
    _METASharesController.dispose();
    _SNOWSharesController.dispose();
    _PGSharesController.dispose();
    _IOTSharesController.dispose();
    _VOOSharesController.dispose();
    super.dispose();
  }

  bool _validateInput(String value) {
    if (value.isEmpty) {
      return false;
    }

    final pattern = r'^\d+(\.\d{1,2})?$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  void _calculate() async {
    final supabase = Supabase.instance.client;

    final User? user = supabase.auth.currentUser;
    print("This is the user details: $user");

    final AAPLSharesInput = _AAPLSharesController.text;
    final TSLASharesInput = _TSLASharesController.text;
    final HUTSharesInput = _HUTSharesController.text;
    final AMZNSharesInput = _AMZNSharesController.text;
    final METASharesInput = _METASharesController.text;
    final SNOWSharesInput = _SNOWSharesController.text;
    final PGSharesInput = _PGSharesController.text;
    final IOTSharesInput = _IOTSharesController.text;
    final VOOSharesInput = _VOOSharesController.text;

    if (_validateInput(AAPLSharesInput) &&
        _validateInput(TSLASharesInput) &&
        _validateInput(HUTSharesInput) &&
        _validateInput(AMZNSharesInput) &&
        _validateInput(METASharesInput) &&
        _validateInput(SNOWSharesInput) &&
        _validateInput(PGSharesInput) &&
        _validateInput(IOTSharesInput) &&
        _validateInput(VOOSharesInput)) {
      setState(() {
        AAPLShares = double.parse(AAPLSharesInput);
        TSLAShares = double.parse(TSLASharesInput);
        HUTShares = double.parse(HUTSharesInput);
        AMZNShares = double.parse(AMZNSharesInput);
        METAShares = double.parse(METASharesInput);
        SNOWShares = double.parse(SNOWSharesInput);
        PGShares = double.parse(PGSharesInput);
        IOTShares = double.parse(IOTSharesInput);
        VOOShares = double.parse(VOOSharesInput);
        _resultText = 'Apple Shares: $AAPLShares\nTesla Shares: $TSLAShares';
        _AAPLSharesController.text = AAPLShares.toStringAsFixed(2);
        _TSLASharesController.text = TSLAShares.toStringAsFixed(2);
        _HUTSharesController.text = HUTShares.toStringAsFixed(2);
        _AMZNSharesController.text = AMZNShares.toStringAsFixed(2);
        _METASharesController.text = METAShares.toStringAsFixed(2);
        _SNOWSharesController.text = SNOWShares.toStringAsFixed(2);
        _PGSharesController.text = PGShares.toStringAsFixed(2);
        _IOTSharesController.text = IOTShares.toStringAsFixed(2);
        _VOOSharesController.text = VOOShares.toStringAsFixed(2);

        ///
      });
    } else {
      setState(() {
        _resultText =
            'Invalid input. Please enter values with two decimal places.';
      });
    }
    await supabase.from("stock_shares").update({
      'tsla_shares': TSLAShares,
      'aapl_shares': AAPLShares,
      'hut_shares': HUTShares,
      'amzn_shares': AMZNShares,
      'meta_shares': METAShares,
      'snow_shares': SNOWShares,
      'pg_shares': PGShares,
      'iot_shares': IOTShares,
      'voo_shares': VOOShares
    }).eq('email', 'plumbjonah@gmail.com');
    print("helerrrrrrrr\nerherhe");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Close the keyboard
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Apple Shares
                  /// Text Input
                  TextField(
                    controller: _AAPLSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Apple Shares',
                      labelStyle: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// Tesla Shares
                  /// Text Input
                  TextField(
                    controller: _TSLASharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: 'Tesla Shares',
                        labelStyle: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 18)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 9, 88, 88)))),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// HUT Shares
                  /// Text Input
                  TextField(
                    controller: _HUTSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Hut Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// Amazon Shares
                  /// Text Input
                  TextField(
                    controller: _AMZNSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Amazon Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// Meta Shares
                  /// Text Input
                  TextField(
                    controller: _METASharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Meta Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// CrowdStrike Shares
                  /// Text Input
                  TextField(
                    controller: _SNOWSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Snowflake Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// Proctor & Gamble Shares
                  /// Text Input
                  TextField(
                    controller: _PGSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'PG Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: 16.0),

                  /// Samsara Shares
                  /// Text Input
                  TextField(
                    controller: _IOTSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Samsara Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),

                  /// Nvidia Shares
                  /// Text Input
                  TextField(
                    controller: _VOOSharesController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'VOO Shares',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 9, 88, 88)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: 16.0),

                  ///
                  /// This is the elevated button to be pressed by users when the
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text(
                      'Update',
                      style: GoogleFonts.roboto(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 9, 88, 88))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
