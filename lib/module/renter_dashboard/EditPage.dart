import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/module/login.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/module/rentee_dashboard/rentee_dash.dart';
import 'package:p2pfordrental/repo/api_repo.dart';
import 'package:p2pfordrental/shared/all_cars_card.dart';
import 'package:p2pfordrental/shared/car_detail_card.dart';
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
  void initState() {
    super.initState();
    widget.appState.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appState.status != null) if (widget.appState.status == UserStatus.Renter)
      return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFEEB462),
                Color(0xFF534666),
              ]),
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              //scrollDirection: Axis.horizontal,
              children: [
                ProfileSideBar(appState: widget.appState),
                Expanded(
                  child: Container(
                    color: Colors.black12,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * .9,
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width * .7 * .4,
                                  child: CarCollection(
                                    appState: widget.appState,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .7 * .6,
                                    child: MapCard(
                                      appState: widget.appState,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .4,
                            child: CarDetail(appState: widget.appState),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          //todo: add rentee dashboard
          );
    else
      return RenteeDashBoard(appState: widget.appState);

    return Center(
        child: LoginPage(
      appState: widget.appState,
      callback: () {
        setState(() {});
      },
    ));
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
        child: Text(widget.appState.currentUser?.name ?? ''),
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
