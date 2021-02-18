import 'package:flutter/material.dart';
import 'package:open_source_pro/models/VehicleType.dart';

import '../../network/vehicle_type_service.dart';
import '../custom_text_from_field.dart';

class VehicleTypeListComponent extends StatefulWidget {
  final VehicleType vehicleType;
  VehicleTypeListComponent({this.vehicleType});
  @override
  _VehicleTypeListComponentState createState() =>
      _VehicleTypeListComponentState();
}

class _VehicleTypeListComponentState extends State<VehicleTypeListComponent> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  bool isVisible = false;
  setFormsValues() {
    nameController.text = widget.vehicleType.description;
  }

  Future<void> update() {
    Future futureVehicleType = updateVehicleType(widget.vehicleType);
    futureVehicleType.then((value) {
      final snackBar = SnackBar(content: Text('Completado'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      print(error);
      final snackBar = SnackBar(content: Text('Error al editar'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFormsValues();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.label),
              title: Text(widget.vehicleType.description),
              subtitle: Text(
                (widget.vehicleType.state) ? "Activo" : "Inactivo",
                style: TextStyle(
                    color:
                        (widget.vehicleType.state) ? Colors.green : Colors.red),
              ),
              trailing: Padding(
                padding: EdgeInsets.only(left: 15),
                child: IconButton(
                  icon: Icon((isVisible)
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                      setFormsValues();
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        CustomTextFormField(
                            myController: nameController,
                            getValue: (value) {
                              widget.vehicleType.description = value;
                            },
                            hintText: "Tipo de vehiculo"),

                        SizedBox(
                          height: 20,
                        ),

                        // Add TextFormFields and RaisedButton here.
                      ])),
                  Padding(
                      padding: EdgeInsets.only(left: 22, top: 10),
                      child: Row(
                        children: [
                          Text("Estado"),
                          Switch(
                            activeColor: Colors.amberAccent,
                            value: widget.vehicleType.state,
                            onChanged: (value) {
                              setState(() {
                                widget.vehicleType.state = value;
                              });
                            },
                          ),
                        ],
                      )),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text(
                          "EDITAR",
                          style: TextStyle(color: Colors.amber),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            update();
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
