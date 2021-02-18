import 'package:flutter/material.dart';

import '../../components/custom_text_from_field.dart';
import '../../models/CarBrand.dart';
import '../../network/car_brand_service.dart';
import '../custom_submit_button.dart';

class AddCarBrandForm extends StatefulWidget {
  @override
  AddCarBrandFormState createState() {
    return AddCarBrandFormState();
  }
}

class AddCarBrandFormState extends State<AddCarBrandForm> {
  final _formKey = GlobalKey<FormState>();
  CarBrand carBrand;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> addCarBrand() {
      Future futureCarBrand = createCarBrands(carBrand);
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
                carBrand = CarBrand(description: value, state: true, id: "");
              },
              hintText: "Marca"),

          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
            buttonText: "Agregar Marca",
            buttonAction: () {
              if (_formKey.currentState.validate()) {
                addCarBrand();
              }
            },
          ),
          // Add TextFormFields and RaisedButton here.
        ]));
  }
}
