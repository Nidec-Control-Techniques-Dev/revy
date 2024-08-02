import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:revy/features/auth/application/presentation/screens/auth_screen.dart';
import 'package:revy/features/dashboard/application/presentation/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/application/presentation/screens/forgot_password_screen.dart';
import 'features/auth/application/presentation/screens/sign_in_screen.dart';
import 'features/create_schedule/create_schedule.dart';
import 'features/progress_tracker/progress_tracker_screen.dart';
import 'features/admin_delegation/application/presentation/screens/admin_delegation_screen.dart';
import 'features/admin_analytics/presentation/screens/filter_screen.dart';
import 'bloc/main_bloc_observer.dart';
import 'env/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  Bloc.observer = MainBlocObserver();
  await Supabase.initialize(
    url: Env.publicSupabaseUrl,
    anonKey: Env.publicSupabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
  runApp(const RevyApp());
}

class RevyApp extends StatelessWidget {
  const RevyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revy - Your Intelligent Sales Assistant',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: "Intel",
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/'
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);


// class RevyApp extends StatelessWidget {
//   const RevyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Revy - Your Intelligent Sales Assistant',
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFEEF1F8),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         fontFamily: "Intel",
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
//         ),
//         inputDecorationTheme: const InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.white,
//           errorStyle: TextStyle(height: 0),
//           border: defaultInputBorder,
//           enabledBorder: defaultInputBorder,
//           focusedBorder: defaultInputBorder,
//           errorBorder: defaultInputBorder,
//         ),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white, // Set AppBar color to white
//           iconTheme: IconThemeData(color: Colors.black), // Set icon color to black
//           titleTextStyle: TextStyle(color: Colors.black, fontSize: 20), // Set text color to black
//         ),
//       ),
//       home: const HomeScreen(),
//       // home: const SignInScreen(),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/'
//     );
//   }
// }

// const defaultInputBorder = OutlineInputBorder(
//   borderRadius: BorderRadius.all(Radius.circular(16)),
//   borderSide: BorderSide(
//     color: Color(0xFFDEE3F2),
//     width: 1,
//   ),
// );

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Revy'),
      // ),
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
            const SizedBox(height: 20),

            // Button for the Sign-In screen.
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const SignInScreen();
                      // return const Center(child: Text('Sign In'));
                    },
                  ),
                );
              },
              child: const Text('Sign In'),
            ),

            // Button for the Sign-in screen v2.
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const AuthScreen();
                    },
                  ),
                );
              },
              child: const Text('Sign In (v2)'),
            ),

            // Button for the Dashboard screen.
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              child: const Text('Dashboard (Beta)'),
            ),

            // Button for the Reset Password screen.
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const ForgotPasswordScreen();
                      // return const Center(child: Text('Reset Password'));
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
                      return const CreateScheduleScreen();
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
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const AdminDelegationScreen();
                    },
                  ),
                );
              },
              child: const Text('Admin Delegation'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const FilterScreen();
                    },
                  ),
                );
              },
              child: const Text('Admin Analytics'),
            ),
          ],
        ),
      ),
    );
  }
}
