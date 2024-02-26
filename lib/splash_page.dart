import 'package:flutter/material.dart';
import 'package:portfolio_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio_app/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // await Future.delayed(Duration.zero); // edit this to test designs
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/homepage');
      // print("session was not null");
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
      // print("session was null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: tertiaryTextColor,
        color: Colors.white,
      ),
    );
  }
}
