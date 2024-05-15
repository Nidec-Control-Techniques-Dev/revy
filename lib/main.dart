import 'package:flutter/material.dart';
import 'features/auth/application/presentation/screens/forgot_password_screen.dart';
import 'features/auth/application/presentation/screens/sign_in_screen.dart';
import 'features/create_schedule/application/presentation/screens/search_bar_screen.dart';
import 'features/progress_tracker/application/presentations/screens/progress_tracker_screen.dart';
// import 'features/create_schedule/application/presentation/screens/ride_booking/ride_booking_screen.dart';

// TODO: Demonstrate Schedule Creation
// TODO: implement stepper widget for create schedule
// TODO: implement BLOC for create schedule
// 
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
            // Nidec Logo
            Center(
              child: Image.asset('assets/images/Nidec-logo_primary_RGB.png'),
            ),
            const SizedBox(height: 20), //
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
            // Button for Create Schedule rerouting
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const SearchBarScreen();
                    },
                  ),
                );
              },
              child: const Text('Create Schedule'),
            ),
            // Button for Create Schedule rerouting
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
