import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _pwController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _pwController.text.trim(),
      );
      final Session? session = res.session;
      print("This is the session response $session");

      if (session != null) {
        // _redirecting = true;
        setState(() {
          _redirecting = false;
          print("This is the session response $session");
        });
      }
    } on AuthException catch (e) {
      // TODO
      print(e);
    }

    // try {
    //   // setState(() {
    //   //   _isLoading = true;
    //   // });
    //   // await supabase.auth.signInWithOtp(
    //   //   email: _emailController.text.trim(),
    //   //   emailRedirectTo:
    //   //       kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
    //   // );
    //   await supabase.auth.signInWithPassword(
    //       email: _emailController.text.trim(),
    //       password: _pwController.text.trim());
    //   // if (mounted) {
    //   //   ScaffoldMessenger.of(context).showSnackBar(
    //   //     const SnackBar(content: Text('Check your email for a login link!')),
    //   //   );
    //   //   _emailController.clear();
    //   // }
    // } on AuthException catch (error) {
    //   SnackBar(
    //     content: Text(error.message),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   );
    // } catch (error) {
    //   SnackBar(
    //     content: const Text('Unexpected error occurred'),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   );
    // }
    // finally {
    //   if (mounted) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }
    // }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              /// Lock Icon
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              /// Username Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),

              const SizedBox(height: 10),

              /// Password Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _pwController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),

              const SizedBox(height: 25),

              /// Sign In Button
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Email text field
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 6,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: textFieldOutlines),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: buttonFocusedColor),
//                           borderRadius: BorderRadius.circular(12)),
//                       hintText: 'Email',
//                       hintStyle: GoogleFonts.roboto(
//                           textStyle: TextStyle(
//                         fontWeight: FontWeight.normal,
//                       )),
//                       fillColor: fillColor,
//                       filled: true),
//                 ),
//               ),
// 
//               const SizedBox(
//                 height: 10,
//               ),
//               // Password Text field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: TextField(
//                   controller: _pwController,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: textFieldOutlines),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: buttonFocusedColor),
//                           borderRadius: BorderRadius.circular(12)),
//                       hintText: 'Password',
//                       hintStyle: GoogleFonts.roboto(
//                           textStyle: TextStyle(
//                         fontWeight: FontWeight.normal,
//                       )),
//                       fillColor: fillColor,
//                       filled: true),
//                   obscureText: true,
//                 ),
//               ),
// 
//               const SizedBox(
//                 height: 10,
//               ),
//               //Sign in button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: GestureDetector(
//                   onTap: _signIn,
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                         color: buttonFocusedColor,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Center(
//                       child: Text('Sign In',
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 color: buttonText,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
// 
//               const SizedBox(
//                 height: 10,
//               ),
// 
//               Text("Registration is currently closed",
//                   style: GoogleFonts.roboto(
//                     textStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: registrationColor,
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






// Scaffold(
//       backgroundColor: backColor,
//       appBar: AppBar(title: const Text('Sign In')),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//         children: [
//           const Text('Sign in via the magic link with your email below'),
//           const SizedBox(height: 18),
//           TextFormField(
//             style: TextStyle(color: Colors.white),
//             controller: _emailController,
//             decoration: const InputDecoration(labelText: 'Email'),
//           ),
//           const SizedBox(height: 18),
//           TextFormField(
//             controller: _pwController,
//             obscureText: true,
//             obscuringCharacter: '*',
//             decoration: const InputDecoration(labelText: 'Password'),
//           ),
//           const SizedBox(height: 18),
//           ElevatedButton(
//             onPressed: _signIn,
//             child: Text('Sign In'),
//           ),
//         ],
//       ),
//     );