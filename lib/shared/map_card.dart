import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/map_coordinates.dart';
import 'package:p2pfordrental/module/navigation/app_state.dart';

class MapCard extends StatefulWidget {
  final AppState appState;
  final List<MapCoordinates>? coordinates;
  const MapCard({Key? key, required this.appState, this.coordinates}) : super(key: key);

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: Color(0xFF534666).withOpacity(.6),
        child: Icon(
          Icons.map,
          color: Colors.black,
        ),
      ),
    );
  }
}
