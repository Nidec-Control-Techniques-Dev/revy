import 'package:flutter/material.dart';
import 'features/auth/application/presentation/screens/forgot_password_screen.dart';
import 'features/auth/application/presentation/screens/sign_in_screen.dart';
import 'features/create_schedule/application/presentation/screens/select_starting_location.dart';
import 'features/progress_tracker/application/presentations/screens/progress_tracker_screen.dart';
// import 'features/create_schedule/application/presentation/screens/ride_booking/ride_booking_screen.dart';

void main() {
  runApp(const RevyApp());
}

class RevyApp extends StatelessWidget {
  const RevyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revy - Your Intelligent Sales Assistant',
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
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

            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const StartLocScreen();
                    },
                  ),
                );
              },
              child: const Text('Create Schedule'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const ProgressTrackerApp();
                    },
                  ),
                );
              },
              child: const Text('Progress Tracker'),
            ),
          ],
        ),
      ),
    );
  }
}
// RideBookingScreen
