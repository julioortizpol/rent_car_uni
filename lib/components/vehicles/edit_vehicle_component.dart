import 'package:flutter/material.dart';
import 'package:open_source_pro/components/car_model/car_model_dropdown.dart';
import 'package:open_source_pro/components/fuel_types/fuel_type_dropdwon.dart';
import 'package:open_source_pro/components/vehicle_type/vehicle_type_dropdown.dart';
import 'package:open_source_pro/models/CarModel.dart';
import 'package:open_source_pro/models/Vehicle.dart';
import 'package:open_source_pro/network/car_model_service.dart';
import 'package:open_source_pro/network/fuel_type_service.dart';
import 'package:open_source_pro/network/vehicle_type_service.dart';

import '../../network/vehicle_servie.dart';
import '../custom_submit_button.dart';

class EditVehicleComponent extends StatefulWidget {
  Vehicle vehicle;
  EditVehicleComponent(this.vehicle);
  @override
  _EditVehicleComponentState createState() => _EditVehicleComponentState();
}

class _EditVehicleComponentState extends State<EditVehicleComponent> {
  Future<List<dynamic>> vehicleTypes;
  Future<List<dynamic>> fuelTypes;
  Future<List<dynamic>> carModels;
  String imageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png";

  List<CarModel> filterCarModelList;
  final chasisNumberController = TextEditingController();

  final descriptionController = TextEditingController();

  final motorNumberController = TextEditingController();

  final imageUrlController = TextEditingController();
  final licensePlateNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  setFormValues() {
    chasisNumberController.text = widget.vehicle.chasisNumber;
    descriptionController.text = widget.vehicle.description;
    motorNumberController.text = widget.vehicle.motorNumber;
    imageUrlController.text = widget.vehicle.photo;
    imageUrl = widget.vehicle.photo;
    licensePlateNumberController.text = widget.vehicle.licensePlateNumber;
  }

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicleTypes = getVehicleType();
    carModels = getCarModels();
    fuelTypes = getFuelType();
    setFormValues();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> edit() {
      Future futureVehicle = updateVehicle(widget.vehicle);
      futureVehicle.then((value) {
        final snackBar = SnackBar(content: Text('Completado'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((error) {
        print(error);
        final snackBar = SnackBar(content: Text('Error al agregar'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }

    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        vehicleTypes,
        fuelTypes,
        carModels
      ]), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Flexible(
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 200,
                              width: 300,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: null),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: chasisNumberController,
                            decoration:
                                InputDecoration(labelText: "Numero de Chasis"),
                            validator: (value) {
                              return validationFunction(value);
                            },
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                labelText: "Descripcion",
                                border: OutlineInputBorder()),
                            validator: (value) {
                              return validationFunction(value);
                            },
                          ),
                          TextFormField(
                            controller: imageUrlController,
                            decoration: InputDecoration(labelText: "Imagen"),
                            validator: (value) {
                              return validationFunction(value);
                            },
                            onChanged: (value) {
                              setState(() {
                                imageUrl = value;
                              });
                            },
                          ),
                          TextFormField(
                            controller: licensePlateNumberController,
                            decoration:
                                InputDecoration(labelText: "Numero Placa"),
                            validator: (value) {
                              return validationFunction(value);
                            },
                          ),
                          TextFormField(
                              controller: motorNumberController,
                              decoration:
                                  InputDecoration(labelText: "Numero Motor"),
                              validator: (value) {
                                return validationFunction(value);
                              }),
                          Padding(
                              padding: EdgeInsets.only(left: 22, top: 10),
                              child: Row(
                                children: [
                                  Text("Estado"),
                                  Switch(
                                    activeColor: Colors.amberAccent,
                                    value: widget.vehicle.state,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.vehicle.state = value;
                                      });
                                    },
                                  ),
                                ],
                              )),
                          FuelTypeDropDown(
                            fuelType: snapshot.data[1],
                            actualfuelType: widget.vehicle.fuelType.description,
                            getDropDownValue: (value) {
                              widget.vehicle.fuelType = value;
                            },
                          ),
                          VehicleTypeDropdown(
                            vehicleType: snapshot.data[0],
                            actualVehicleType:
                                widget.vehicle.vehicleType.description,
                            getDropDownValue: (value) {
                              widget.vehicle.vehicleType = value;
                            },
                          ),
                          CarModelDropdown(
                            actualCarModel:
                                "${widget.vehicle.carModel.description} - ${widget.vehicle.carModel.brand.description}",
                            carModel: snapshot.data[2],
                            getDropDownValue: (value) {
                              widget.vehicle.carModel = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomSubmitButton(
                            buttonText: "Editar Vehiculo",
                            buttonAction: () {
                              if (formKey.currentState.validate()) {
                                widget.vehicle.chasisNumber =
                                    chasisNumberController.text;
                                widget.vehicle.motorNumber =
                                    motorNumberController.text;
                                widget.vehicle.licensePlateNumber =
                                    licensePlateNumberController.text;
                                widget.vehicle.photo = imageUrl;
                                widget.vehicle.description =
                                    descriptionController.text;
                                widget.vehicle.carBrand =
                                    widget.vehicle.carModel.brand;
                                edit();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
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
        return Expanded(
          child: Column(
            children: children,
          ),
        );
      },
    );
  }
}
