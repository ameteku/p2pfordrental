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
      child: Card(
        child: Icon(Icons.map),
      ),
    );
  }
}
