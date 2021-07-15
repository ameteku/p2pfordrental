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
    return Card(
      //margin: EdgeInsets.only(right: 15, top: 5),

      elevation: 7,
      color: Color(0xFF534666).withOpacity(.6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/cassandra-hamer-OCIicZ3Tfco-unsplash.jpg"),
                backgroundColor: Color(0xFF138086),
                maxRadius: 40,
                // child: Icon(
                //   Icons.person,
                //   size: 40,
                // ),
              ),
            ),
            Divider(
              height: 5,
              thickness: 20,
              color: Colors.black,
            ),
            Text(widget.appState.currentUser?.name ?? 'Michael Ameteku'),
            Divider(
              height: 5,
              thickness: 20,
              color: Colors.white,
            ),
            Row(
              children: [Text('Cars Owned: '), Text(widget.appState.currentUser?.carIds?.length.toString() ?? "20")],
            )
          ],
        ),
      ),
    );
  }
}
