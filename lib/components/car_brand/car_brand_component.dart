import 'package:flutter/material.dart';
import 'package:open_source_pro/components/car_brand/car_brand_list_component.dart';

import '../../network/car_brand_service.dart';

class CarBrandComponent extends StatefulWidget {
  @override
  CarBrandComponentState createState() {
    return CarBrandComponentState();
  }
}

class CarBrandComponentState extends State<CarBrandComponent> {
  Future<List<dynamic>> carBrands;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carBrands = getCarBrands();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: carBrands, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              child: ListView(
                children: snapshot.data.map((carBrand) {
                  print(carBrand);
                  return CarBrandListComponent(
                    carBrand: carBrand,
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
