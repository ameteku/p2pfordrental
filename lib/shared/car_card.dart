import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/vehicle.dart';

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
              "https://www.ford.com/cmslibs/content/dam/vdm_ford/live/en_us/ford/nameplate/maverick/2022/collections/3-2/P758_Hybrid_XLT_08_219.jpg/_jcr_content/renditions/cq5dam.web.1440.1440.jpeg"),
        ),
        title: Text(car.name!),
      ),
    );
  }
}
