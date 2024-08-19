import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:revy/features/auth/application/presentation/screens/auth_screen.dart';
// import 'package:revy/features/dashboard/application/presentation/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'features/auth/application/presentation/screens/forgot_password_screen.dart';
// import 'features/auth/application/presentation/screens/sign_in_screen.dart';
import 'features/create_schedule/create_schedule.dart';
import 'features/progress_tracker/progress_tracker_screen.dart';
import 'features/admin_delegation/application/presentation/screens/admin_delegation_screen.dart';
import 'features/admin_analytics/presentation/screens/filter_screen.dart';
import 'bloc/main_bloc_observer.dart';
import 'env/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'features/progress_tracker/presentation/widgets/map.dart';

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
        home: BlocProvider(
          create: (context) => AuthBloc(),
          child: AuthPage(),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/');
  }
}

class AuthPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Supabase Auth'),
      // ),
      body: BlocListener<AuthBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Authenticated!')),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is AuthAuthenticated){
              // return const HomeScreen();
              if (state.isSalesPerson == 0){
                return const HomeScreenAdmin();
              }
              return const HomeScreenSalesPerson();
            }
            else{
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSignIn(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        },
                        child: const Text('Sign In'),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     BlocProvider.of<AuthBloc>(context).add(
                      //       AuthSignUp(
                      //         emailController.text,
                      //         passwordController.text,
                      //       ),
                      //     );
                      //   },
                      //   child: Text('Sign Up'),
                      // ),
                    ],
                  ),
                ),
              );
            }

          },
        ),
      ),
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

class HomeScreenSalesPerson extends StatelessWidget {
  const HomeScreenSalesPerson({super.key});

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
          ],
        ),
      ),
    );
  }
}


class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({super.key});

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
