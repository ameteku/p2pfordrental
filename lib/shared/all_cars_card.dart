import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/repo/user_repo.dart';
import 'package:p2pfordrental/shared/car_card.dart';

import 'car_detail_card.dart';

class CarCollection extends StatefulWidget {
  final AppState appState;
  const CarCollection({
    Key? key,
    required this.appState,
  }) : super(key: key);

  @override
  _CarCollectionState createState() => _CarCollectionState();
}

class _CarCollectionState extends State<CarCollection> {
  List<Vehicle>? cars;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
          color: Color(0xFF534666).withOpacity(.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Owned Cars",
                  style: kheadingStyle(),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .4,
                child: FutureBuilder<List<Vehicle>?>(
                    future: UserRepo().getUserVehicles(widget.appState.currentUser!.id!),
                    initialData: [
                      Vehicle(
                        currentMileage: 20000,
                        oldMileage: 170000,
                        name: "Ford mustang",
                      )
                    ],
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        List<Vehicle>? vehicles = snapshot.data;
                        return ListView.builder(
                          itemCount: vehicles!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print("Setting car");
                                widget.appState.car = vehicles[index];
                                print("done setting car");
                              },
                              child: CarCard(
                                car: vehicles[index],
                              ),
                            );
                          },
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Center(
                          child: Text('No cars yet.. checking with ford'),
                        );
                      }
                    }),
              ),
            ],
          )),
    );
  }
}
