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
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: Color(0xFF534666).withOpacity(.6),
        child: widget.cars != null
            ? ListView.builder(
                itemCount: widget.cars?.length ?? 0,
                itemBuilder: (context, index) {
                  return CarCard(car: widget.cars![index]);
                },
              )
            : Text('No cars yet...'),
      ),
    );
  }
}
