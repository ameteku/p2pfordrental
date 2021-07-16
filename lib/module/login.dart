import 'package:flutter/material.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';

class LoginPage extends StatefulWidget {
  final AppState appState;
  final Function callback;
  const LoginPage({Key? key, required this.callback, required this.appState}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: OutlinedButton(
              onPressed: () {
                widget.appState.status = UserStatus.Renter;
                widget.callback();
              },
              child: Text(
                "Renter",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              widget.appState.status = UserStatus.Rentee;
              widget.callback();
            },
            child: Text(
              "Rentee",
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
