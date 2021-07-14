import 'package:flutter/material.dart';

final BottomSheet kFooter = BottomSheet(
  builder: (context) => Container(
    color: Colors.black12,
    height: 20,
  ),
  onClosing: () {},
);

const int kMileageBound = 20;

final Text kBrand = Text('P2PFords');
