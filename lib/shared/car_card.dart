import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/repo/user_repo.dart';

class CarCard extends StatelessWidget {
  final Vehicle car;
  final Function? onTap;
  const CarCard({Key? key, required this.car, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: onTap != null ? () => onTap!() : null,
        hoverColor: Color(0xFFDC8665).withOpacity(.3),
        focusColor: Color(0xFFDC8665).withOpacity(.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        tileColor: Color(0xFFDC8665),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(car.imageUrl ??
              "https://images.unsplash.com/photo-1514316454349-750a7fd3da3a?ixid=Mnwx"
                  "MjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w"
                  "=1534&q=80"),
        ),
        title: Text(car.name!),
        trailing: Switch(
          onChanged: (value) {
            UserRepo().updateVehicle(car);
            car.rented = value;
          },
          value: car.rented,
        ),
      ),
    );
  }
}
