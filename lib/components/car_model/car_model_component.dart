import 'package:flutter/material.dart';

import '../../network/car_brand_service.dart';
import '../../network/car_model_service.dart';
import 'car_model_list_component.dart';

class CarModelComponent extends StatefulWidget {
  @override
  CarModelComponentState createState() {
    return CarModelComponentState();
  }
}

class CarModelComponentState extends State<CarModelComponent> {
  Future<List<dynamic>> carModels;
  Future<List<dynamic>> carBrands;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carModels = getCarModels();
    carBrands = getCarBrands();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: carModels, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              child: ListView(
                children: snapshot.data.map((carModel) {
                  return CarModelListComponent(
                    carModel: carModel,
                    carsBrands: carBrands,
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
