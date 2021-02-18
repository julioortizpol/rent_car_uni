import 'package:flutter/material.dart';
import 'package:open_source_pro/components/rent_and_return/taps_components/associate_info.dart';
import 'package:open_source_pro/components/rent_and_return/taps_components/inspection_info.dart';
import 'package:open_source_pro/components/rent_and_return/taps_components/vehicle_info.dart';
import 'package:open_source_pro/models/RentAndReturn.dart';
import 'package:open_source_pro/network/rent_and_return_service.dart';

class RentAndReturnDetailsComponent extends StatefulWidget {
  RentAndReturn rentAndReturn;
  RentAndReturnDetailsComponent(this.rentAndReturn);
  @override
  _RentAndReturnDetailsComponentState createState() =>
      _RentAndReturnDetailsComponentState();
}

class _RentAndReturnDetailsComponentState
    extends State<RentAndReturnDetailsComponent> {
  final commentController = TextEditingController();

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmacion de Retorno'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  maxLines: 2,
                  controller: commentController,
                  decoration: InputDecoration(
                      labelText: "Comentarios", border: OutlineInputBorder()),
                  validator: (value) {
                    return validationFunction(value);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retorno'),
              onPressed: () {
                widget.rentAndReturn.comment = commentController.text;
                widget.rentAndReturn.close = true;
                Navigator.of(context).pop();
                Future futureRentAndReturn =
                    updateRentAndReturn(widget.rentAndReturn);
                futureRentAndReturn.then((value) {
                  final snackBar = SnackBar(content: Text('Completado'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {});
                }).catchError((error) {
                  print(error);
                  final snackBar = SnackBar(content: Text('Error al agregar'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.6),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: TabBar(
              indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(
                    text: "Asociados",
                    icon: Icon(
                      Icons.person,
                    )),
                Tab(
                    text: "Vehiculo",
                    icon: Icon(
                      Icons.car_rental,
                    )),
                Tab(
                    text: "Inspeccion",
                    icon: Icon(
                      Icons.search,
                    )),
              ],
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Center(
                    child: AssociateInfo(
                  rentAndReturn: widget.rentAndReturn,
                )),
                Center(
                    child: VehicleInfo(
                  vehicleId: widget.rentAndReturn.vehicle,
                )),
                Center(
                  child: InspectionInfo(
                    inspectionId: widget.rentAndReturn.inspection,
                  ),
                )
              ],
            ),
            bottomNavigationBar: (!widget.rentAndReturn.close)
                ? Container(
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                        onPressed: () {
                          _showMyDialog();
                        },
                        child: Text("Retornar"),
                      ),
                    ),
                  )
                : null),
      ),
    );
  }
}
