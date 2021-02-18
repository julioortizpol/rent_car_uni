import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_source_pro/models/Inspection.dart';
import 'package:open_source_pro/network/inspection_service.dart';
import 'package:open_source_pro/utilities/local_storage_web.dart';

import '../custom_drop_down.dart';
import '../custom_submit_button.dart';

class AddInspectionComponent extends StatefulWidget {
  Function action;
  AddInspectionComponent({this.action});
  @override
  _AddInspectionComponentState createState() => _AddInspectionComponentState();
}

class _AddInspectionComponentState extends State<AddInspectionComponent> {
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");
  String inspectionId;

  String fuelQuantity = "Seleccione Cantidad de combustible";
  bool grated = false;
  List<bool> wheelState = [false, false, false, false];
  bool replacementRubber = false;
  bool vehicleJack = false;
  bool breakingGlass = false;

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> add() async {
      final employeeId = await WebLocalStorage().get("employeeId");
      final vehicleId = await WebLocalStorage().get("vehicleId");
      Future futureInspection = createInspection(Inspection(
          id: "",
          breakingGlass: breakingGlass,
          grated: grated,
          vehicleJack: vehicleJack,
          wheelState: wheelState,
          replacementRubber: replacementRubber,
          vehicle: vehicleId,
          employee: employeeId,
          state: true,
          fuelQuantity: fuelQuantity,
          date: format.parse(DateTime.now().toString())));

      futureInspection.then((value) {
        final snackBar = SnackBar(content: Text('Completado'));
        widget.action(value['_id']);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((error) {
        print(error);
        final snackBar = SnackBar(content: Text('Error al agregar'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }

    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text("Cantidad de combustible: "),
                SizedBox(
                  width: 30,
                ),
                CustomDropDown(
                  dropDownValue: fuelQuantity,
                  dropDownItems: [
                    "Seleccione Cantidad de combustible",
                    "1/4",
                    "1/2",
                    "2/4",
                    "Lleno",
                  ],
                  getDropDownValue: (value) {
                    fuelQuantity = value;
                  },
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text("Tiene Ralladuras: "),
                    Switch(
                      activeColor: Colors.amberAccent,
                      value: grated,
                      onChanged: (value) {
                        setState(() {
                          grated = value;
                        });
                      },
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text("Tiene Goma de repuesta: "),
                    Switch(
                      activeColor: Colors.amberAccent,
                      value: replacementRubber,
                      onChanged: (value) {
                        setState(() {
                          replacementRubber = value;
                        });
                      },
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text("Tiene roturas de cristal: "),
                    Switch(
                      activeColor: Colors.amberAccent,
                      value: breakingGlass,
                      onChanged: (value) {
                        setState(() {
                          breakingGlass = value;
                        });
                      },
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text("Tiene Gato: "),
                    Switch(
                      activeColor: Colors.amberAccent,
                      value: vehicleJack,
                      onChanged: (value) {
                        setState(() {
                          vehicleJack = value;
                        });
                      },
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                child: Text(
                  "Estado Gomas: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.bottomLeft,
              ),
            ),
            Row(
              children: [
                Text("Goma 1: "),
                Switch(
                  activeColor: Colors.amberAccent,
                  value: wheelState[0],
                  onChanged: (value) {
                    setState(() {
                      wheelState[0] = value;
                    });
                  },
                ),
                Text("Goma 2: "),
                Switch(
                  activeColor: Colors.amberAccent,
                  value: wheelState[1],
                  onChanged: (value) {
                    setState(() {
                      wheelState[1] = value;
                    });
                  },
                ),
                Text("Goma 3: "),
                Switch(
                  activeColor: Colors.amberAccent,
                  value: wheelState[2],
                  onChanged: (value) {
                    setState(() {
                      wheelState[2] = value;
                    });
                  },
                ),
                Text("Goma 4: "),
                Switch(
                  activeColor: Colors.amberAccent,
                  value: wheelState[3],
                  onChanged: (value) {
                    setState(() {
                      wheelState[3] = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomSubmitButton(
              buttonText: "Agregar Inspeccion",
              buttonAction: () async {
                add();
              },
            )
          ],
        ),
      ),
    );
  }
}
