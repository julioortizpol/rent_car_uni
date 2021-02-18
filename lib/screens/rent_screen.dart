import 'package:flutter/material.dart';
import 'package:open_source_pro/components/rent_and_return/create_rent_stepper.dart';
import 'package:open_source_pro/components/rent_and_return/details_rent_and_return_component.dart';
import 'package:open_source_pro/components/rent_and_return/rent_and_return_component.dart';

import '../models/Employee.dart';
import '../network/employee_service.dart';
import '../utilities/local_storage_web.dart';

class RentCarScreen extends StatefulWidget {
  @override
  _RentCarScreenState createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  Employee employee;
  Widget _myAnimatedWidget;
  bool rentFlow = false;
  bool detailsComponent = false;
  Widget getComponent(index) {
    switch (index) {
      case 0:
        return RentAndReturnComponent(
          action: (rentAndReturn, vehicleJson) {
            setState(() {
              detailsComponent = true;

              _myAnimatedWidget = RentAndReturnDetailsComponent(rentAndReturn);
            });
          },
        );
      case 1:
        return CreateRentComponent();
      default:
        return Text("Hi Default");
    }
  }

  getData() async {
    final employeeData =
        await getEmployee(await WebLocalStorage().get("employeeId"));
    employee = Employee.fromJson(employeeData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _myAnimatedWidget = getComponent(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/welcome'),
          child: Icon(
            Icons.home, // add custom icons also
          ),
        ),
        title: Text('RentCar'),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white,
            tooltip: "Usuario",
            icon: Icon(Icons.account_circle_rounded),
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  child: Card(
                    elevation: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 40,
                          ),
                          title: Text(employee.name),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Cerrar seccion'),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/');
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Rentas",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Center(
                    child: FlatButton(
                      onPressed: (rentFlow || detailsComponent)
                          ? () {
                              setState(() {
                                rentFlow = false;
                                detailsComponent = false;
                                _myAnimatedWidget = getComponent(0);
                              });
                            }
                          : () {
                              setState(() {
                                rentFlow = true;
                                _myAnimatedWidget = getComponent(1);
                              });
                            },
                      child: Text((rentFlow || detailsComponent)
                          ? (detailsComponent)
                              ? "Volver"
                              : "Cancelar"
                          : "Crear"),
                      color: Colors.amberAccent,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: AnimatedSwitcher(
                  switchInCurve: Curves.decelerate,
                  duration: const Duration(milliseconds: 1),
                  child: _myAnimatedWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
