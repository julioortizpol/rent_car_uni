import 'package:flutter/material.dart';
import 'package:open_source_pro/components/fuel_types/fuel_type_list_component.dart';

import '../../network/fuel_type_service.dart';

class FuelTypeComponent extends StatefulWidget {
  @override
  FuelTypeComponentState createState() {
    return FuelTypeComponentState();
  }
}

class FuelTypeComponentState extends State<FuelTypeComponent> {
  Future<List<dynamic>> fuelType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fuelType = getFuelType();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fuelType, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              child: ListView(
                children: snapshot.data.map((fuelType) {
                  print(fuelType);
                  return FuelTypeListComponent(
                    fuelType: fuelType,
                  );
                }).toList(),
              ),
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Expanded(
          child: Column(
            children: children,
          ),
        );
      },
    );
  }
}
