import 'package:flutter/material.dart';
import 'package:open_source_pro/models/CarModel.dart';

import '../../components/custom_text_from_field.dart';
import '../../models/CarBrand.dart';
import '../../network/car_brand_service.dart';
import '../../network/car_model_service.dart';
import '../custom_submit_button.dart';
import 'car_brand_dropdown.dart';

class AddCarModelForm extends StatefulWidget {
  @override
  AddCarModelFormState createState() {
    return AddCarModelFormState();
  }
}

class AddCarModelFormState extends State<AddCarModelForm> {
  final _formKey = GlobalKey<FormState>();
  CarModel carModel;
  CarBrand carBrand;
  final nameController = TextEditingController();
  Future carBrands;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carBrands = getCarBrands();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> add() {
      Future futureCarModel = createCarModel(carModel);
      futureCarModel.then((value) {
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
                carModel = CarModel(
                    description: value, state: true, id: "", brand: carBrand);
              },
              hintText: "Modelo"),
          FutureBuilder<List<dynamic>>(
            future: carBrands, // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                carBrand = snapshot.data[0];
                children = <Widget>[
                  CarBrandDropDown(
                    carsBrands: snapshot.data,
                    actualBrand: carBrand.description,
                    getDropDownValue: (brand) {
                      carBrand = brand;
                    },
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
              return Column(
                children: children,
              );
            },
          ),

          SizedBox(
            height: 20,
          ),
          CustomSubmitButton(
            buttonText: "Agregar Modelo",
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
