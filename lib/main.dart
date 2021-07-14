import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:p2pfordrental/module/error_page.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/module/renter_dashboard/EditPage.dart';

import 'module/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("error occured in initializing app: ${snapshot.error.toString()}");
          return ErrorPage();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(

                  // primarySwatch: Color(0xFF138086),
                  ),
              home: DashBoard(
                appState: AppState(),
              ));
        }

        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('LOADING'),
      ),
    );
  }
}
