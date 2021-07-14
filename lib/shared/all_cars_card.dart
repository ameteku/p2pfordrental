import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';
import 'package:p2pfordrental/shared/car_card.dart';

class CarCollection extends StatefulWidget {
  final AppState appState;
  final List<Vehicle>? cars;
  const CarCollection({Key? key, required this.appState, this.cars}) : super(key: key);

  @override
  _CarCollectionState createState() => _CarCollectionState();
}

class _CarCollectionState extends State<CarCollection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: widget.cars != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return CarCard(car: widget.cars![index]);
                },
              )
            : Text('No cars yet...'),
      ),
    );
  }
}
