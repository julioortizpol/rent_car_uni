import 'package:flutter/material.dart';
import 'package:open_source_pro/models/Employee.dart';

class EmployeeListComponent extends StatefulWidget {
  final Employee employee;
  final Function toEditComponent;
  EmployeeListComponent({this.employee, this.toEditComponent});
  @override
  _EmployeeListComponentState createState() => _EmployeeListComponentState();
}

class _EmployeeListComponentState extends State<EmployeeListComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Card(
        child: InkWell(
          onTap: () {
            print("klk");
            widget.toEditComponent(widget.employee);
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text(widget.employee.name),
                subtitle: Text(
                  (widget.employee.state) ? "Activo" : "Inactivo",
                  style: TextStyle(
                      color:
                          (widget.employee.state) ? Colors.green : Colors.red),
                ),
                trailing: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
