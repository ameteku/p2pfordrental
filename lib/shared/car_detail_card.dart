import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/map_coordinates.dart';
import 'package:p2pfordrental/models/user.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/shared/consts.dart';

class CarDetail extends StatefulWidget {
  final AppState appState;

  const CarDetail({Key? key, required this.appState}) : super(key: key);

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF534666).withOpacity(.6),
      elevation: 5,
      child: widget.appState.car != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(5),
                  child: Card(
                    color: Colors.green,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Image.network(
                      widget.appState.car!.imageUrl ??
                          "https://images.unsplash.com/photo-1514316454349-750a7fd3da3a?ixid=Mnwx"
                              "MjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w"
                              "=1534&q=80",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //width: window.physicalSize.width * ,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        //this takes the car name(model)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: VehicleInfo(context)),
                            Expanded(child: RentHistory(context)),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topRight,
                                width: MediaQuery.of(context).size.width * .16,
                                child: RenteeCard(
                                    rentee: User(name: "john", userName: "johhny", email: "@gmail.com", phoneNumber: "3307807220"),
                                    mileageUsed: mileageUsed()),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text('Select a Car :)'),
            ),
    );
  }

  Container RentHistory(BuildContext context) {
    return Container(
      // alignment: Alignment.topLeft,
      decoration: BoxDecoration(border: Border(right: BorderSide(width: 3))),
      child: Column(
        children: [
          Container(
            child: Text(
              "Rent history",
              style: kheadingStyle(),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(bottom: 7),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 3,
              ),
            )),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * .35,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(5),
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  title: Text("Mileage:"
                      "\$200.00"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://images.unsplash.com/photo-1513594979850-55e46e3e1555?ixid=Mnwx"
                        "MjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1."
                        "2.1&auto=format&fit=crop&w=1350&q=80"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container VehicleInfo(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "Vehicle Information",
              style: kheadingStyle(),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(bottom: 7),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 3,
              ),
            )),
          ),
          Container(
            // height: MediaQuery.of(context).size.height * .3,
            child: ListView(
              shrinkWrap: true,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KeyValueTile("Model:", widget.appState.car!.name!),
                KeyValueTile("Last Known location:", "${carLocation()}"),
                KeyValueTile("Mileage Used:", mileageUsed().toString()),
                KeyValueTile("Total Mileage:", widget.appState.car!.currentMileage.toString())
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(border: Border(right: BorderSide(width: 3))),
    );
  }

  int mileageUsed() {
    Vehicle temp = widget.appState.car!;
    return ((temp.currentMileage ?? 0) - (temp.oldMileage ?? 0)).abs();
  }

  String carLocation() {
    MapCoordinates? coordinates = widget.appState.car?.currentLocation;
    print("converting coordinates");
    if (coordinates == null) {
      return "No location found";
    }

    return "Working on google api";
  }
}

Padding KeyValueTile(String key, String value) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      title: Text(key),
      trailing: Text(value),
    ),
  );
}

TextStyle kheadingStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}

class RenteeCard extends StatelessWidget {
  final User rentee;
  final int mileageUsed;
  const RenteeCard({Key? key, required this.rentee, required this.mileageUsed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        children: [
          Container(
            child: Text(
              "Current Rentee",
              style: kheadingStyle(),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(bottom: 7),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 3,
              ),
            )),
          ),
          CircleAvatar(backgroundColor: Color(0xFF138086), child: Icon(Icons.person)),
          KeyValueTile("Rentee:", rentee.name!),
          KeyValueTile("Phone Number:", rentee.phoneNumber ?? "No number"),
          KeyValueTile("Amount due: ", '\$' + amountDue().toString())
        ],
      ),
    );
  }

  double amountDue() {
    int chargableMileage = mileageUsed - kMileageBound;

    if (chargableMileage < 0) {
      return 100;
    }
    return chargableMileage * 0.5 + 100;
  }
}
