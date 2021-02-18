import 'package:flutter/material.dart';
import 'package:open_source_pro/models/CarModel.dart';

import '../../network/car_model_service.dart';
import '../custom_text_from_field.dart';
import 'car_brand_dropdown.dart';

class CarModelListComponent extends StatefulWidget {
  CarModel carModel;
  Future<List<dynamic>> carsBrands;
  CarModelListComponent({this.carModel, this.carsBrands});
  @override
  _CarModelListComponentState createState() => _CarModelListComponentState();
}

class _CarModelListComponentState extends State<CarModelListComponent> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  bool isVisible = false;
  setFormsValues() {
    nameController.text = widget.carModel.description;
  }

  Future<void> update() {
    Future futureCarModel = updateCarModel(widget.carModel);
    futureCarModel.then((value) {
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
              title: Text(widget.carModel.description),
              subtitle: Text(
                (widget.carModel.state) ? "Activo" : "Inactivo",
                style: TextStyle(
                    color: (widget.carModel.state) ? Colors.green : Colors.red),
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
              child: FutureBuilder<List<dynamic>>(
                future: widget
                    .carsBrands, // a previously-obtained Future<String> or null
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            CustomTextFormField(
                                myController: nameController,
                                getValue: (value) {
                                  widget.carModel.description = value;
                                },
                                hintText: "Modelo Carro"),

                            SizedBox(
                              height: 20,
                            ),

                            // Add TextFormFields and RaisedButton here.
                          ])),
                      CarBrandDropDown(
                        carsBrands: snapshot.data,
                        actualBrand: widget.carModel.brand.description,
                        getDropDownValue: (brand) {
                          widget.carModel.brand = brand;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 22, top: 10),
                          child: Row(
                            children: [
                              Text("Estado"),
                              Switch(
                                activeColor: Colors.amberAccent,
                                value: widget.carModel.state,
                                onChanged: (value) {
                                  setState(() {
                                    widget.carModel.state = value;
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
            ),
          ],
        ),
      ),
    );
  }
}
