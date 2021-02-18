import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:open_source_pro/components/rent_and_return/rent_and_return_list_component.dart';
import 'package:open_source_pro/network/rent_and_return_service.dart';
import 'package:responsive_grid/responsive_grid.dart';

const double _minSpacingPx = 16;
const double _cardWidth = 360;

class RentAndReturnComponent extends StatefulWidget {
  @override
  Function action;
  RentAndReturnComponent({this.action});
  RentAndReturnComponentState createState() {
    return RentAndReturnComponentState();
  }
}

class RentAndReturnComponentState extends State<RentAndReturnComponent> {
  Future<List<dynamic>> rentsAndReturns;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rentsAndReturns = getRentsAndReturns();
  }

//                           (element) => element.id == rentAndReturn.vehicle),
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: rentsAndReturns, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = ResponsiveGridList(
            // ResponsiveGridList crashes if desiredItemWidth + 2*minSpacing > Device window on Android
            desiredItemWidth: math.min(_cardWidth,
                MediaQuery.of(context).size.width - (2 * _minSpacingPx)),
            minSpacing: _minSpacingPx,
            children: snapshot.data
                .map((rentAndReturn) => RentAndReturnListComponent(
                      rentAndReturn: rentAndReturn,
                      toDetailsComponent: widget.action,
                    ))
                .toList(),
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
