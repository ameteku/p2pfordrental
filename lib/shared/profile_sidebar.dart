import 'package:flutter/material.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';

class ProfileSideBar extends StatefulWidget {
  final AppState appState;
  const ProfileSideBar({Key? key, required this.appState}) : super(key: key);

  @override
  _ProfileSideBarState createState() => _ProfileSideBarState();
}

class _ProfileSideBarState extends State<ProfileSideBar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          Text('Michael Ameteku'),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [Text('Cars Owned: '), Text("20")],
          )
        ],
      ),
    );
  }
}
