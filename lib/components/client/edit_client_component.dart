import 'package:flutter/material.dart';
import 'package:open_source_pro/models/Client.dart';

import '../../network/client_service.dart';
import '../../utilities/validators.dart';
import '../custom_drop_down.dart';
import '../custom_submit_button.dart';

class EditClientComponent extends StatefulWidget {
  Client client;

  EditClientComponent(this.client);

  @override
  _EditClientComponentState createState() => _EditClientComponentState();
}

class _EditClientComponentState extends State<EditClientComponent> {
  final String dominicanRepublicIdFormat = "00000000000";

  final idController = TextEditingController();

  final nameController = TextEditingController();

  final creditLimitController = TextEditingController();

  final creditCardController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  setFormValue() {
    idController.text = widget.client.personId;
    nameController.text = widget.client.name;
    creditLimitController.text = widget.client.creditLimit;
    creditCardController.text = widget.client.creditCard;
  }

  @override
  Widget build(BuildContext context) {
    setFormValue();
    Future<void> edit() {
      Future futureEmployee = updateClient(widget.client);
      futureEmployee.then((value) {
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
                  dropDownValue: widget.client.personType,
                  dropDownItems: [
                    "Fiscal",
                    "Fisica",
                  ],
                  getDropDownValue: (value) {
                    widget.client.personType = value;
                  },
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 22, top: 10),
                child: Row(
                  children: [
                    Text("Estado"),
                    Switch(
                      activeColor: Colors.amberAccent,
                      value: widget.client.state,
                      onChanged: (value) {
                        setState(() {
                          widget.client.state = value;
                        });
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            CustomSubmitButton(
              buttonText: "Editar Cliente",
              buttonAction: () {
                if (formKey.currentState.validate()) {
                  widget.client.personId = idController.text;
                  widget.client.name = "${nameController.text}";
                  widget.client.creditLimit = creditLimitController.text;
                  widget.client.creditCard = creditCardController.text;
                  edit();
                  //add();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
