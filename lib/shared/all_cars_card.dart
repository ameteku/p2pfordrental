import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/shared/car_card.dart';

class CarCollection extends StatefulWidget {
  final AppState appState;
  final List<Vehicle> cars;
  const CarCollection({
    Key? key,
    required this.appState,
    required this.cars,
  }) : super(key: key);

  @override
  _CarCollectionState createState() => _CarCollectionState();
}

class _CarCollectionState extends State<CarCollection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: Color(0xFF534666).withOpacity(.6),
        child: widget.cars != null
            ? ListView.builder(
                itemCount: widget.cars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      print("Setting car");
                      widget.appState.car = widget.cars[index];
                      print("done setting car");
                    },
                    child: CarCard(
                      car: widget.cars[0],
                    ),
                  );
                },
              )
            : Text('No cars yet...'),
      ),
    );
  }
}
