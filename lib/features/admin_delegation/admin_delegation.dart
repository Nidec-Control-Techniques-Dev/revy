// // import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// // import 'package:revy/features/auth/application/presentation/screens/auth_screen.dart';
// // import 'package:revy/features/dashboard/application/presentation/screens/home_screen.dart';
// // import 'package:revy/firebase_options.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// // import 'env/env.dart';
// // import 'features/auth/application/presentation/screens/forgot_password_screen.dart';
// // import 'features/auth/application/presentation/screens/sign_in_screen.dart';
// // import 'features/create_schedule/create_schedule.dart';
// // import 'features/progress_tracker/application/presentations/screens/progress_tracker_screen.dart';
// // import 'bloc/main_bloc_observer.dart';
// // import 'package:bloc/bloc.dart';
// // import 'features/create_schedule/application/presentation/screens/ride_booking/ride_booking_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:pie_chart/pie_chart.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'filter_screen.dart';
// // import 'client_list.dart';
// // import 'client_page.dart';
// // import 'package:intl/intl.dart';
// // import 'date.dart';
// // import 'filter_bloc.dart';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// import 'application/presentation/screens/delegation_page_2.dart';


// Future<void> main() async {
//   // Firebase Initialization
  
//   await Supabase.initialize(
//     url: 'https://vngqmoieqkgihvnpudwa.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZuZ3Ftb2llcWtnaWh2bnB1ZHdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM5OTc1MDgsImV4cCI6MjAyOTU3MzUwOH0.yEWsHgV4WquWIV0aWUbXeIaCYCrF8UOAEnwdzL3xNjA',
//     authOptions: const FlutterAuthClientOptions(
//       authFlowType: AuthFlowType.pkce,
//     ),
//     realtimeClientOptions: const RealtimeClientOptions(
//       logLevel: RealtimeLogLevel.info,
//     ),
//     storageOptions: const StorageClientOptions(
//       retryAttempts: 10,
//     ),
//   );

//   runApp(const RevyApp());
// }

// class RevyApp extends StatelessWidget {
//   const RevyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //   Widget build(BuildContext context) {
//     // return BlocProvider(
//     //   create: (context) => DelegationBloc(),
//     return MaterialApp(
//       title: 'Revy - Your Intelligent Sales Assistant',
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFEEF1F8),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         fontFamily: "Intel",
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
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
//       ),
//       home: const HomeScreen(),
//       debugShowCheckedModeBanner: false,
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

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Revy'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             // Nidec Logo
//             Center(
//               child: Image.asset('assets/images/Nidec-logo_primary_RGB.png'),
//             ),
//             const SizedBox(height: 20),

//             // Button for the Sign-In screen.
//             FilledButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute<void>(
//                     builder: (BuildContext context) {
//                       return DelegationPageProvider();
//                       // return const Center(child: Text('Sign In'));
//                     },
//                   ),
//                 );
//               },
//                child: const Text('Delegation'),
//             ),

//             // Button for the Sign-in screen v2.
            
//           ],
//         ),
//       ),
//     );
//   }
// }