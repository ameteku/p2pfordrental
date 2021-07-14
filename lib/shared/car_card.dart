import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';

class CarCard extends StatelessWidget {
  final Vehicle car;
  final Function? onTap;
  const CarCard({Key? key, required this.car, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Card(
        child: Row(
          children: [
            Text(car.name!),
            CircleAvatar(
              child: ImageIcon(NetworkImage('.com')),
            )
          ],
        ),
      ),
    );
  }
}
