import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providerConfigs: const [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId:
                      '404625750871-9u4pms3caehifoo34fi35o7ambqk7tpa.apps.googleusercontent.com',
                ),
              ],
              headerBuilder: (context, constraints, _) {
                return CircleAvatar(
                  radius: 65,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/blue.png', // Update the path with your image file
                      width: 130, // set the width and height here
                      height: 130,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      action == AuthAction.signIn
                          ? 'Bluberry AI - Sign In'
                          : 'Bluberry AI - Sign Up',
                    ));
              },
              footerBuilder: (context, action) {
                return const Text(
                  'By signing in, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                );
              },
            );
          }
          // return MaterialApp(home: MainPage());
          return HomeScreen(
            user: snapshot.data!,
            child: const SizedBox(),
          );
        });
  }
}
