import 'package:flutter/material.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/shared/all_cars_card.dart';
import 'package:p2pfordrental/shared/consts.dart';
import 'package:p2pfordrental/shared/map_card.dart';
import 'package:p2pfordrental/shared/profile_sidebar.dart';

class DashBoard extends StatefulWidget {
  final AppState appState;
  const DashBoard({Key? key, required this.appState}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: kFooter,
      appBar: MainAppBar(context),
      body: widget.appState!.currentUser == null
          ? SingleChildScrollView(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //todo : profile sidebar
                    ProfileSideBar(appState: widget.appState),
                    Column(
                      children: [
                        Row(
                          children: [
                            //todo : cars owned card( and cars card)
                            CarCollection(
                              appState: widget.appState,
                              cars: [],
                            ),
                            //todo : map card
                            MapCard(
                              appState: widget.appState,
                            )
                          ],
                        )

                        //todo: car detail card
                      ],
                    )
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.black12,
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.tag_faces),
                      Text(
                        'Not Logged In,\n Waiting for Admins Approval',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
    ;
  }

  AppBar MainAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 90,
      elevation: 2,
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: kBrand,
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 23.0, left: 10),
        child: Text(widget.appState!.currentUser?.name ?? ''),
      ),
      automaticallyImplyLeading: true,
      actions: [
        Container(
          margin: EdgeInsets.only(top: 25, right: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text("Home"),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
