import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_source_pro/models/Client.dart';
import 'package:open_source_pro/models/Employee.dart';
import 'package:open_source_pro/models/RentAndReturn.dart';
import 'package:open_source_pro/network/rent_and_return_service.dart';
import 'package:open_source_pro/utilities/local_storage_web.dart';

import '../custom_date_picker.dart';
import '../custom_submit_button.dart';

class AddRentAndReturnComponent extends StatefulWidget {
  @override
  _AddRentAndReturnComponentState createState() =>
      _AddRentAndReturnComponentState();
}

class _AddRentAndReturnComponentState extends State<AddRentAndReturnComponent> {
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy");
  String inspectionId;
  RentAndReturn rentAndReturn;
  String devolutionDateString = "";
  final commentController = TextEditingController();
  final daysController = TextEditingController();
  final devolutionDateController = TextEditingController();
  dynamic date;

  validationFunction(value) {
    if (value.isEmpty) {
      return "Campo Obligatorio";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> add() async {
      Future futureRentAndReturn = createRentAndReturn(rentAndReturn);

      futureRentAndReturn.then((value) {
        final snackBar = SnackBar(content: Text('Completado'));
        Navigator.pushNamed(context, "/rent");
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((error) {
        print(error);
        final snackBar = SnackBar(content: Text('Error al retornar'));
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
              controller: daysController,
              decoration: InputDecoration(labelText: "Dias de renta"),
              validator: (value) {
                return validationFunction(value);
              },
              onChanged: (value) {
                devolutionDateController.text = format.format(
                    DateTime.now().add(Duration(days: int.parse(value))));
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomDateFormPicker(
              controller: devolutionDateController,
              hintText: "Fecha De devolucion",
              action: (value) {
                daysController.text = DateTime.now()
                    .difference(format.parse(value))
                    .inDays
                    .toString();
                date = value;
                setState(() {});
              },
              format: format,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 2,
              controller: commentController,
              decoration: InputDecoration(
                  labelText: "Comentarios", border: OutlineInputBorder()),
              validator: (value) {
                return validationFunction(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomSubmitButton(
              buttonText: "Agregar Renta",
              buttonAction: () async {
                final vehicleId = await WebLocalStorage().get("vehicleId");
                final employeeId = await WebLocalStorage().get("employeeId");
                final clientId = await WebLocalStorage().get("clientId");
                final inspectionId =
                    await WebLocalStorage().get("inspectionId");
                rentAndReturn = RentAndReturn(
                    vehicle: vehicleId,
                    employee: Employee(
                        personId: "",
                        state: true,
                        workShift: "",
                        name: "",
                        commissionPercent: "",
                        dateOfAdmission: DateTime.now(),
                        id: employeeId),
                    client: Client(
                        state: true,
                        personId: "",
                        personType: "",
                        creditLimit: "",
                        creditCard: "",
                        id: clientId),
                    state: true,
                    close: false,
                    devolutionDay: format.parse(devolutionDateController.text),
                    dayAmount: 0,
                    rentDate: DateTime.now(),
                    comment: commentController.text,
                    inspection: inspectionId,
                    id: "");
                add();
              },
            )
          ],
        ),
      ),
    );
  }
}
