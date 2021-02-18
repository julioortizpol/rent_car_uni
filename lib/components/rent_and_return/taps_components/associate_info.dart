import 'package:flutter/material.dart';
import 'package:open_source_pro/models/RentAndReturn.dart';

class AssociateInfo extends StatelessWidget {
  RentAndReturn rentAndReturn;
  AssociateInfo({this.rentAndReturn});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Empleado",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Nombre'),
                  subtitle: Text(rentAndReturn.employee.name),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Cedula'),
                  subtitle: Text(rentAndReturn.employee.personId),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Comisión'),
                  subtitle: Text(rentAndReturn.employee.commissionPercent),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Tanda Laboral'),
                  subtitle: Text(rentAndReturn.employee.workShift),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Cliente",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Nombre'),
                  subtitle: Text(rentAndReturn.client.name),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Cedula'),
                  subtitle: Text(rentAndReturn.client.personId),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Tipo de persona'),
                  subtitle: Text(rentAndReturn.client.personType),
                ),
                ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Limite de credito'),
                  subtitle: Text("${rentAndReturn.client.creditLimit}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
