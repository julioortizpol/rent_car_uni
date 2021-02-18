import 'package:flutter/material.dart';
import 'package:open_source_pro/models/CarBrand.dart';

import '../../network/car_brand_service.dart';
import '../custom_text_from_field.dart';

class CarBrandListComponent extends StatefulWidget {
  final CarBrand carBrand;
  CarBrandListComponent({this.carBrand});
  @override
  _CarBrandListComponentState createState() => _CarBrandListComponentState();
}

class _CarBrandListComponentState extends State<CarBrandListComponent> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  bool isVisible = false;
  setFormsValues() {
    nameController.text = widget.carBrand.description;
  }

  Future<void> updateCarBrand() {
    Future futureCarBrand = updateCarBrands(widget.carBrand);
    futureCarBrand.then((value) {
      final snackBar = SnackBar(content: Text('Completado'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      print(error);
      final snackBar = SnackBar(content: Text('Error al editar'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> deleteCarBrand() {
    Future futureCarBrand = updateCarBrands(widget.carBrand);
    futureCarBrand.then((value) {
      final snackBar = SnackBar(content: Text('Completado'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
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
              title: Text(widget.carBrand.description),
              subtitle: Text(
                (widget.carBrand.state) ? "Activo" : "Inactivo",
                style: TextStyle(
                    color: (widget.carBrand.state) ? Colors.green : Colors.red),
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
                              widget.carBrand.description = value;
                            },
                            hintText: "Marca Carro"),

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
                            value: widget.carBrand.state,
                            onChanged: (value) {
                              setState(() {
                                widget.carBrand.state = value;
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
                            updateCarBrand();
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
