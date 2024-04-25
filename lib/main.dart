import 'package:flutter/material.dart';
import 'package:revy/features/auth/application/presentation/screens/forgot_password_screen.dart';
import 'package:revy/features/auth/application/presentation/screens/sign_in_screen.dart';

void main() {
  runApp(const RevyApp());
}

class RevyApp extends StatelessWidget {
  const RevyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revy - Your Intelligent Sales Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Button for the Sign-In screen.
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const SignInScreen();
                    },
                  ),
                );
              },
              child: const Text('Sign In'),
            ),

            // Button for the Reset Password screen.
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const ForgotPasswordScreen();
                    },
                  ),
                );
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
