import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_source_pro/models/RentAndReturn.dart';
import 'package:open_source_pro/network/vehicle_servie.dart';

class RentAndReturnListComponent extends StatefulWidget {
  final RentAndReturn rentAndReturn;
  final Function toDetailsComponent;
  RentAndReturnListComponent({this.rentAndReturn, this.toDetailsComponent});
  @override
  _RentAndReturnListComponentState createState() =>
      _RentAndReturnListComponentState();
}

class _RentAndReturnListComponentState
    extends State<RentAndReturnListComponent> {
  Future<dynamic> vehicle;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicle = getVehicle(widget.rentAndReturn.vehicle);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: vehicle, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          print(snapshot.hasData);
          child = Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Card(
              child: InkWell(
                onTap: () {
                  widget.toDetailsComponent(
                      widget.rentAndReturn, snapshot.hasData);
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.car_rental),
                        title: Text('Vehiculo'),
                        subtitle: Text(
                            "Modelo: ${snapshot.data.carModel.description} | Marca: ${snapshot.data.carModel.brand.description}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Empleado'),
                        subtitle: Text(
                            "${widget.rentAndReturn.employee.name} - ${widget.rentAndReturn.employee.personId}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Cliente'),
                        subtitle: Text(
                            '${widget.rentAndReturn.client.name} - ${widget.rentAndReturn.client.personId}'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  (widget.rentAndReturn.close)
                                      ? "Retornado | Placa: ${widget.rentAndReturn.state}"
                                      : ((widget.rentAndReturn.devolutionDay
                                              .isAfter(DateTime.now())))
                                          ? "Rentado | Fecha Retorno: ${DateFormat("dd/MM/yyyy").format(widget.rentAndReturn.devolutionDay)}"
                                          : "Atrasado | Fecha Retorno: ${DateFormat("dd/MM/yyyy").format(widget.rentAndReturn.devolutionDay)}",
                                  style: TextStyle(
                                      color: (widget.rentAndReturn.close ||
                                              (widget
                                                  .rentAndReturn.devolutionDay
                                                  .isAfter(DateTime.now())))
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.rentAndReturn.comment,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
              CircularProgressIndicator(),
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
