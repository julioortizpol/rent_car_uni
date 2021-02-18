import 'package:flutter/material.dart';
import 'package:open_source_pro/components/vehicle_type/vehicle_type_list_component.dart';

import '../../network/vehicle_type_service.dart';

class VehicleTypeComponent extends StatefulWidget {
  @override
  VehicleTypeComponentState createState() {
    return VehicleTypeComponentState();
  }
}

class VehicleTypeComponentState extends State<VehicleTypeComponent> {
  Future<List<dynamic>> vehicleType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleType = getVehicleType();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: vehicleType, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              child: ListView(
                children: snapshot.data.map((vehicleType) {
                  return VehicleTypeListComponent(
                    vehicleType: vehicleType,
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
