import 'package:flutter/material.dart';
import 'package:open_source_pro/components/car_model/car_model_dropdown.dart';
import 'package:open_source_pro/components/fuel_types/fuel_type_dropdwon.dart';
import 'package:open_source_pro/components/vehicle_type/vehicle_type_dropdown.dart';
import 'package:open_source_pro/models/CarBrand.dart';
import 'package:open_source_pro/models/CarModel.dart';
import 'package:open_source_pro/models/FuelType.dart';
import 'package:open_source_pro/models/Vehicle.dart';
import 'package:open_source_pro/models/VehicleType.dart';
import 'package:open_source_pro/network/car_brand_service.dart';
import 'package:open_source_pro/network/car_model_service.dart';
import 'package:open_source_pro/network/fuel_type_service.dart';
import 'package:open_source_pro/network/vehicle_type_service.dart';

import '../../network/vehicle_servie.dart';
import '../custom_submit_button.dart';

class AddVehicleComponent extends StatefulWidget {
  @override
  _AddVehicleComponentState createState() => _AddVehicleComponentState();
}

class _AddVehicleComponentState extends State<AddVehicleComponent> {
  Vehicle vehicle;
  Future<List<dynamic>> vehicleTypes;
  Future<List<dynamic>> fuelTypes;
  Future<List<dynamic>> carModels;
  Future<List<dynamic>> carBrands;
  String imageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png";
  CarBrand carBrand;
  FuelType fuelType;
  VehicleType vehicleType;
  CarModel carModel;
  List<CarModel> filterCarModelList;
  final chasisNumberController = TextEditingController();

  final descriptionController = TextEditingController();

  final motorNumberController = TextEditingController();

  final imageUrlController = TextEditingController();
  final licensePlateNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
    carBrands = getCarBrands();
    fuelTypes = getFuelType();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> add() {
      Future futureVehicle = createVehicle(vehicle);
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
        carBrands,
        carModels
      ]), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          carBrand = snapshot.data[2][0];
          fuelType = snapshot.data[1][0];
          vehicleType = snapshot.data[0][0];
          carModel = snapshot.data[3][0];

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
                          FuelTypeDropDown(
                            fuelType: snapshot.data[1],
                            actualfuelType: fuelType.description,
                            getDropDownValue: (value) {
                              fuelType = value;
                            },
                          ),
                          VehicleTypeDropdown(
                            vehicleType: snapshot.data[0],
                            actualVehicleType: vehicleType.description,
                            getDropDownValue: (value) {
                              vehicleType = value;
                            },
                          ),
                          CarModelDropdown(
                            actualCarModel:
                                "${carModel.description} - ${carModel.brand.description}",
                            carModel: snapshot.data[3],
                            getDropDownValue: (value) {
                              carModel = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomSubmitButton(
                            buttonText: "Agregar Vehiculo",
                            buttonAction: () {
                              if (formKey.currentState.validate()) {
                                vehicle = Vehicle(
                                    id: "",
                                    chasisNumber: chasisNumberController.text,
                                    state: true,
                                    motorNumber: motorNumberController.text,
                                    licensePlateNumber:
                                        licensePlateNumberController.text,
                                    carBrand: carModel.brand,
                                    carModel: carModel,
                                    fuelType: fuelType,
                                    vehicleType: vehicleType,
                                    photo: imageUrl,
                                    description: descriptionController.text);
                                add();
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
