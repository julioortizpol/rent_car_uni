import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_source_pro/components/car_brand/add_car_brand_component.dart';
import 'package:open_source_pro/components/car_brand/car_brand_component.dart';
import 'package:open_source_pro/components/car_model/add_car_model_component.dart';
import 'package:open_source_pro/components/car_model/car_model_component.dart';
import 'package:open_source_pro/components/client/add_client_component.dart';
import 'package:open_source_pro/components/client/client_component.dart';
import 'package:open_source_pro/components/client/edit_client_component.dart';
import 'package:open_source_pro/components/employee/add_employee_component.dart';
import 'package:open_source_pro/components/employee/edit_employee_component.dart';
import 'package:open_source_pro/components/employee/employee_component.dart';
import 'package:open_source_pro/components/fuel_types/add_fuel_type_component.dart';
import 'package:open_source_pro/components/fuel_types/fuel_type_component.dart';
import 'package:open_source_pro/components/vehicle_type/add_vehicle_type_component.dart';
import 'package:open_source_pro/components/vehicle_type/vehicle_type_component.dart';
import 'package:open_source_pro/components/vehicles/add_vehicle_component.dart';
import 'package:open_source_pro/components/vehicles/edit_vehicle_component.dart';
import 'package:open_source_pro/components/vehicles/vehicles_component.dart';

class CrudScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyHomePage(
        title: "Rent Car",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;
  Widget _myAnimatedWidget;
  bool read = true;
  bool edit = false;

  Widget getReadComponents(index) {
    setState(() {
      edit = false;
    });
    switch (index) {
      case 0:
        return VehicleComponent(
          rentFlow: false,
          action: (vehicle) {
            setState(() {
              _myAnimatedWidget = getEditComponent(0, vehicle);
            });
          },
        );
      case 1:
        return CarBrandComponent();
      case 2:
        return FuelTypeComponent();
      case 3:
        return CarModelComponent();
      case 4:
        return VehicleTypeComponent();
      case 5:
        return EmployeeComponent(
          toEditComponent: (employee) {
            setState(() {
              _myAnimatedWidget = getEditComponent(1, employee);
            });
          },
        );
      case 6:
        return ClientComponent(
          rentFlow: false,
          toEditComponent: (client) {
            setState(() {
              _myAnimatedWidget = getEditComponent(2, client);
            });
          },
        );
      default:
        return Text("Hi Default");
    }
  }

  Widget getCreateComponents(index) {
    setState(() {
      edit = false;
    });
    switch (index) {
      case 0:
        return AddVehicleComponent();
      case 1:
        return AddCarBrandForm();
      case 2:
        return AddFuelTypeForm();
      case 3:
        return AddCarModelForm();
      case 4:
        return AddVehicleTypeForm();
      case 5:
        return AddEmployeeComponent();
      case 6:
        return AddClientComponent();
      default:
        return Text("Hi Default");
    }
  }

  Widget getEditComponent(index, dynamic object) {
    setState(() {
      edit = true;
    });
    switch (index) {
      case 0:
        return EditVehicleComponent(object);
      case 1:
        return EditEmployeeComponent(object);
      case 2:
        return EditClientComponent(object);
      default:
        return Text("Hi Default");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _myAnimatedWidget = getReadComponents(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'C R U D',
                  style: textTheme.headline6,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Vehiculo',
                ),
              ),
              ListTile(
                leading: Icon(Icons.car_rental),
                title: Text('Vehiculos'),
                selected: _selectedDestination == 0,
                onTap: () => selectDestination(0),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Marcas'),
                selected: _selectedDestination == 1,
                onTap: () => selectDestination(1),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Combustibles'),
                selected: _selectedDestination == 2,
                onTap: () => selectDestination(2),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Modelos'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Tipo de vehiculo'),
                selected: _selectedDestination == 4,
                onTap: () => selectDestination(4),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Personas',
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Empleados'),
                selected: _selectedDestination == 5,
                onTap: () => selectDestination(5),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Clientes'),
                selected: _selectedDestination == 6,
                onTap: () => selectDestination(6),
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/welcome'),
                child: Icon(
                  Icons.home, // add custom icons also
                ),
              ),
              title: Text(widget.title),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        read = !read;
                      });
                      selectDestination(_selectedDestination);
                    },
                    child: Text((read) ? "Agregar" : "Consultar"),
                    color: Colors.amberAccent,
                  ),
                ),
                Visibility(
                    visible: edit,
                    child: Center(
                      child: FlatButton(
                        onPressed: () {
                          selectDestination(_selectedDestination);
                        },
                        child: Text("Volver"),
                        color: Colors.amberAccent,
                      ),
                    )),
                SizedBox(
                  height: 5,
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
      ],
    );
  }

  void selectDestination(int index) {
    setState(() {
      _myAnimatedWidget =
          (read) ? getReadComponents(index) : getCreateComponents(index);
      _selectedDestination = index;
    });
  }
}
