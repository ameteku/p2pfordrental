import 'package:flutter/material.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';

class LoginPage extends StatefulWidget {
  final AppState appState;
  const LoginPage({Key? key, required this.appState}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              widget.appState.status = UserStatus.Renter;
            },
            child: Text("Renter"),
          ),
          OutlinedButton(
            onPressed: () {
              widget.appState.status = UserStatus.Rentee;
            },
            child: Text("Rentee"),
          )
        ],
      ),
    );
  }
}
