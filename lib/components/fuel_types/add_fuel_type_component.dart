import 'package:flutter/material.dart';
import 'package:open_source_pro/models/FuelType.dart';

import '../../components/custom_text_from_field.dart';
import '../../network/fuel_type_service.dart';
import '../custom_submit_button.dart';

class AddFuelTypeForm extends StatefulWidget {
  @override
  AddFuelTypeFormState createState() {
    return AddFuelTypeFormState();
  }
}

class AddFuelTypeFormState extends State<AddFuelTypeForm> {
  final _formKey = GlobalKey<FormState>();
  FuelType fuelType;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> add() {
      Future futureCarBrand = createFuelTypes(fuelType);
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
                fuelType = FuelType(description: value, state: true, id: "");
              },
              hintText: "Combustible"),

          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
            buttonText: "Agregar Combustible",
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
