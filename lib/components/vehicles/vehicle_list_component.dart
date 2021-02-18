import 'package:flutter/material.dart';
import 'package:open_source_pro/models/Vehicle.dart';

class VehicleListComponent extends StatefulWidget {
  final Vehicle vehicle;
  final Function toEditComponent;
  VehicleListComponent({this.vehicle, this.toEditComponent});
  @override
  _VehicleListComponentState createState() => _VehicleListComponentState();
}

class _VehicleListComponentState extends State<VehicleListComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Card(
        child: InkWell(
          onTap: () {
            widget.toEditComponent(widget.vehicle);
          },
          child: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.vehicle.photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: null),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.vehicle.carModel.description,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(
                            widget.vehicle.carBrand.description,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, (identical(0, 0.0) ? 0 : 2), 0, 4),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          (widget.vehicle.state)
                              ? "Activo | Placa: ${widget.vehicle.licensePlateNumber} | Numero Motor: ${widget.vehicle.motorNumber}"
                              : "Inactivo | Placa: ${widget.vehicle.licensePlateNumber}",
                          style: TextStyle(
                              color: (widget.vehicle.state)
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.vehicle.description,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
