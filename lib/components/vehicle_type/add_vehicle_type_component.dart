import 'package:flutter/material.dart';
import 'package:open_source_pro/models/VehicleType.dart';

import '../../components/custom_text_from_field.dart';
import '../../network/vehicle_type_service.dart';
import '../custom_submit_button.dart';

class AddVehicleTypeForm extends StatefulWidget {
  @override
  AddVehicleTypeFormState createState() {
    return AddVehicleTypeFormState();
  }
}

class AddVehicleTypeFormState extends State<AddVehicleTypeForm> {
  final _formKey = GlobalKey<FormState>();
  VehicleType vehicleType;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> add() {
      Future futureCarBrand = createVehicleType(vehicleType);
      futureCarBrand.then((value) {
        final snackBar = SnackBar(content: Text('Completado'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((error) {
        print(error);
        final snackBar = SnackBar(content: Text('Error al agregar'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          CustomTextFormField(
              myController: nameController,
              getValue: (value) {
                vehicleType =
                    VehicleType(description: value, state: true, id: "");
              },
              hintText: "Tipo de Vehiculo"),

          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
            buttonText: "Agregar Tipo de Vehiculo",
            buttonAction: () {
              if (_formKey.currentState.validate()) {
                add();
              }
            },
          ),
          // Add TextFormFields and RaisedButton here.
        ]));
  }
}
