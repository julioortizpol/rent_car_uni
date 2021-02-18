import 'package:flutter/material.dart';

import '../../network/employee_service.dart';
import 'employee_list_component.dart';

class EmployeeComponent extends StatefulWidget {
  @override
  Function toEditComponent;
  EmployeeComponent({this.toEditComponent});
  EmployeeComponentState createState() {
    return EmployeeComponentState();
  }
}

class EmployeeComponentState extends State<EmployeeComponent> {
  Future<List<dynamic>> employees;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employees = getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: employees, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              child: ListView(
                children: snapshot.data.map((employee) {
                  return EmployeeListComponent(
                    employee: employee,
                    toEditComponent: widget.toEditComponent,
                  );
                }).toList(),
              ),
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
        return Expanded(
          child: Column(
            children: children,
          ),
        );
      },
    );
  }
}
