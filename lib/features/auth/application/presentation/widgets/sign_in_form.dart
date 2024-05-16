import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormFieldState<String>>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Email text field.
          FormBuilderTextField(
            key: _emailFieldKey,
            name: 'email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
            // validator: FormBuilderValidators.compose(
            //   [
            //     FormBuilderValidators.required(),
            //     FormBuilderValidators.email(),
            //   ],
            // ),
          ),
          const SizedBox(height: 32.0),

          // Password text field.
          FormBuilderTextField(
            name: 'password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: _isPasswordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                color: _isPasswordVisible
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
            // validator: FormBuilderValidators.compose(
            //   [
            //     FormBuilderValidators.required(),
            //     FormBuilderValidators.minLength(8),
            //   ],
            // ),
          ),

          // Forgot password?
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 32.0),

          // Log in button.
          FilledButton(
            onPressed: () async {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                print(_formKey.currentState?.value['email']);
                print(_formKey.currentState?.value['password']);

                try {
                  final supabase = Supabase.instance.client;
                  final AuthResponse res =
                      await supabase.auth.signInWithPassword(
                    email: _formKey.currentState?.value['email'],
                    password: _formKey.currentState?.value['password'],
                  );
                  final Session? session = res.session;
                  final User? user = res.user;

                  // Show a dialog if the login was successful, if not, show the error message.
                  if (session != null && user != null) {
                    showDialog<void>(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text('You have successfully logged in.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  // Show a dialog if the login was unsuccessful.
                  showDialog<void>(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text('An error occurred: $e'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            child: const Text('Log in'),
          ),
          const SizedBox(height: 16.0),

          // Don't have an account? Sign up.
          Row(
            children: <Widget>[
              const Text('Don\'t have an account? '),
              TextButton(
                onPressed: () => {},
                child: const Text('Sign up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
