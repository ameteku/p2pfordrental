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
          ? Column(
              children: [
                //this takes the car name(model)
                SizedBox(
                  child: Text(widget.appState.car!.name!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Mileage Used: ${mileageUsed()}"),
                        Divider(
                          height: 5,
                          thickness: 2,
                          color: Colors.black12,
                        ),
                        Text("Last Known location: ${carLocation() ?? "Not known"}")
                      ],
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width * .3,
                      child: RenteeCard(
                          rentee: User(name: "john", userName: "johhny", email: "@gmail.com", phoneNumber: "3307807220"),
                          mileageUsed: mileageUsed()),
                    )
                  ],
                )
              ],
            )
          : Center(
              child: Text('Select a Car :)'),
            ),
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

class RenteeCard extends StatelessWidget {
  final User rentee;
  final int mileageUsed;
  const RenteeCard({Key? key, required this.rentee, required this.mileageUsed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFEEB462).withOpacity(.6),
      child: Column(
        children: [
          CircleAvatar(backgroundColor: Color(0xFF138086), child: Icon(Icons.person)),
          Text(rentee!.name!),
          ListTile(
            leading: Text("Phone Number:"),
            trailing: Text(rentee!.phoneNumber ?? "No number"),
          ),
          ListTile(
            leading: Text("Amount due:"),
            trailing: Text(amountDue().toString()),
          )
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
