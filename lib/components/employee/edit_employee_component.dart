import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_source_pro/models/Employee.dart';

import '../../network/employee_service.dart';
import '../../utilities/validators.dart';
import '../custom_date_picker.dart';
import '../custom_drop_down.dart';
import '../custom_submit_button.dart';

class EditEmployeeComponent extends StatefulWidget {
  Employee employee;

  EditEmployeeComponent(this.employee);

  @override
  _EditEmployeeComponentState createState() => _EditEmployeeComponentState();
}

class _EditEmployeeComponentState extends State<EditEmployeeComponent> {
  final format = DateFormat("dd-MM-yyyy");

  final String dominicanRepublicIdFormat = "00000000000";

  final idController = TextEditingController();

  final nameController = TextEditingController();

  final mailController = TextEditingController();

  final commissionController = TextEditingController();

  final startDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  setFormValue() {
    idController.text = widget.employee.personId;
    nameController.text = widget.employee.name;
    mailController.text = "julioortizpol@gmail.com";
    commissionController.text = widget.employee.commissionPercent;
    startDateController.text = format.format(widget.employee.dateOfAdmission);
  }

  @override
  Widget build(BuildContext context) {
    setFormValue();
    Future<void> edit() {
      Future futureEmployee = updateEmployee(widget.employee);
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
              controller: commissionController,
              decoration: InputDecoration(labelText: "Comision"),
              validator: (value) {
                return validationFunction(value);
              },
            ),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: mailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  return validationFunction(value);
                }),
            Row(
              children: [
                Text("Tanda Laboral: "),
                SizedBox(
                  width: 30,
                ),
                CustomDropDown(
                  dropDownValue: widget.employee.workShift,
                  dropDownItems: [
                    "Seleccion de tanda",
                    "Nocturna",
                    "Diurna",
                    "Mixta"
                  ],
                  getDropDownValue: (value) {
                    widget.employee.workShift = value;
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Fecha de Admision: "),
                SizedBox(
                  width: 30,
                ),
                CustomDateFormPicker(
                  controller: startDateController,
                  hintText: "Fecha De admision",
                  action: (value) {
                    widget.employee.dateOfAdmission = value;
                  },
                  format: format,
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
                      value: widget.employee.state,
                      onChanged: (value) {
                        setState(() {
                          widget.employee.state = value;
                        });
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            CustomSubmitButton(
              buttonText: "Editar Empleado",
              buttonAction: () {
                if (formKey.currentState.validate()) {
                  widget.employee.personId = idController.text;
                  widget.employee.name = "${nameController.text}";
                  widget.employee.commissionPercent = commissionController.text;
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
