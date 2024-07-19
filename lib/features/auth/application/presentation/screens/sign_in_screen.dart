import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  // final String googleIconPath = 'assets/icons/icons8-google.svg';
  // final String facebookIconPath = 'assets/icons/icons8-facebook.svg';
  // final String anonymousIconPath = 'assets/icons/icons8-incognito-48.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Welcome message.
                  Text(
                    'Welcome to Revy!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text('Sign in to continue.'),
                  const SizedBox(height: 40.0),

                  SvgPicture.asset(
                    'assets/illustrations/undraw_secure_login_pdn4.svg',
                    width: 150.0,
                    height: 150.0,
                    semanticsLabel: 'Secure Login Illustration',
                  ),

                  const SizedBox(height: 40.0),

                  // Log in with Email form.
                  const SignInForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
