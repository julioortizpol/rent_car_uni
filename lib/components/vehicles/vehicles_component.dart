import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:open_source_pro/components/vehicles/vehicle_list_component.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../network/vehicle_servie.dart';

const double _minSpacingPx = 16;
const double _cardWidth = 360;

class VehicleComponent extends StatefulWidget {
  @override
  Function action;
  bool rentFlow;
  VehicleComponent({this.action, this.rentFlow});
  VehicleComponentState createState() {
    return VehicleComponentState();
  }
}

class VehicleComponentState extends State<VehicleComponent> {
  Future<List<dynamic>> vehicles;
  List<Widget> vehiclesComponent;
  List<Widget> searchResult = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicles = getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: vehicles, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          vehiclesComponent = snapshot.data
              .map((vehicle) => VehicleListComponent(
                    vehicle: vehicle,
                    toEditComponent: widget.action,
                  ))
              .toList()
              .where((element) => !widget.rentFlow || element.vehicle.state)
              .toList();
          child = Column(
            children: [
              Visibility(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      searchResult = snapshot.data
                          .map((vehicle) => VehicleListComponent(
                                vehicle: vehicle,
                                toEditComponent: widget.action,
                              ))
                          .toList()
                          .where((element) =>
                              (!widget.rentFlow || element.vehicle.state) &&
                              (element.vehicle.carModel.description
                                      .contains(value) ||
                                  element.vehicle.carBrand.description
                                      .contains(value)))
                          .toList();
                      setState(() {});
                    },
                    decoration: InputDecoration(labelText: "Modelo"),
                  ),
                ),
                visible: widget.rentFlow,
              ),
              Expanded(
                  child: ResponsiveGridList(
                desiredItemWidth: math.min(_cardWidth,
                    MediaQuery.of(context).size.width - (2 * _minSpacingPx)),
                minSpacing: _minSpacingPx,
                children: (searchResult.length != 0)
                    ? searchResult
                    : vehiclesComponent,
              ))
            ],
          );
        } else if (snapshot.hasError) {
          child = Column(
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ],
          );
        } else {
          child = Column(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ],
          );
        }
        return Container(
          constraints: BoxConstraints(maxWidth: 1280),
          child: child,
        );
      },
    );
  }
}
