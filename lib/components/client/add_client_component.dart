import 'package:flutter/material.dart';
import 'package:open_source_pro/models/Client.dart';

import '../../network/client_service.dart';
import '../../utilities/validators.dart';
import '../custom_drop_down.dart';
import '../custom_submit_button.dart';

class AddClientComponent extends StatefulWidget {
  @override
  _AddClientComponentState createState() => _AddClientComponentState();
}

class _AddClientComponentState extends State<AddClientComponent> {
  Client client;

  final String dominicanRepublicIdFormat = "00000000000";

  final idController = TextEditingController();

  final nameController = TextEditingController();

  final creditLimitController = TextEditingController();

  final creditCardController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String personType = "Fisica";

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> add() {
      Future futureClient = createClient(client);
      futureClient.then((value) {
        final snackBar = SnackBar(content: Text('Completado'));
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
            TextFormField(
              keyboardType: TextInputType.number,
              controller: idController,
              decoration: InputDecoration(
                  labelText: "Cedula", hintText: dominicanRepublicIdFormat),
              validator: (value) {
                if (value.isNotEmpty) {
                  dynamic validationText =
                      (validateDominicanId(value)) ? null : "Cedula Invalida";
                  return validationText;
                }
                return "Campo Obligatorio";
              },
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nombre"),
              validator: (value) {
                return validationFunction(value);
              },
            ),
            TextFormField(
              controller: creditCardController,
              decoration: InputDecoration(labelText: "Tarjeta de Credito"),
              validator: (value) {
                return validationFunction(value);
              },
            ),
            TextFormField(
                controller: creditLimitController,
                decoration: InputDecoration(labelText: "Limitie de credito"),
                validator: (value) {
                  return validationFunction(value);
                }),
            Row(
              children: [
                Text("Tipo de persona: "),
                SizedBox(
                  width: 30,
                ),
                CustomDropDown(
                  dropDownValue: "Seleccione tipo de persona",
                  dropDownItems: [
                    "Seleccione tipo de persona",
                    "Fiscal",
                    "Fisica",
                  ],
                  getDropDownValue: (value) {
                    personType = value;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomSubmitButton(
              buttonText: "Agregar Cliente",
              buttonAction: () {
                if (formKey.currentState.validate()) {
                  client = Client(
                      personId: idController.text,
                      name: nameController.text,
                      creditCard: creditCardController.text,
                      creditLimit: creditCardController.text,
                      personType: personType,
                      state: true,
                      id: "");

                  add();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
