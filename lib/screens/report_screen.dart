import 'package:flutter/material.dart';
import 'package:open_source_pro/components/report_taps/chart_report_component.dart';
import 'package:open_source_pro/components/report_taps/report_table_component.dart';
import 'package:open_source_pro/models/Employee.dart';
import 'package:open_source_pro/models/ReportElements.dart';
import 'package:open_source_pro/network/employee_service.dart';
import 'package:open_source_pro/network/rent_and_return_service.dart';
import 'package:open_source_pro/network/vehicle_servie.dart';
import 'package:open_source_pro/utilities/csv_report.dart';
import 'package:open_source_pro/utilities/local_storage_web.dart';

import '../utilities/constants.dart';

class RentCarReportScreen extends StatefulWidget {
  @override
  _RentCarReportScreenState createState() => _RentCarReportScreenState();
}

class _RentCarReportScreenState extends State<RentCarReportScreen> {
  Future<List<dynamic>> rentsAndReturns;
  Future<List<dynamic>> vehicles;
  List<ReportElement> reportElements = [];
  List<String> reportLabels = generalReportTableLabels;

  Employee employee;
  getData() async {
    final employeeData =
        await getEmployee(await WebLocalStorage().get("employeeId"));
    employee = Employee.fromJson(employeeData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rentsAndReturns = getRentsAndReturns();
    vehicles = getVehicles();
    getData();
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
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          rentsAndReturns,
          vehicles
        ]), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            reportElements = [];
            dynamic rentAndReturnList = snapshot.data[0];
            dynamic vehicles = snapshot.data[1];
            rentAndReturnList.forEach((rentAndReturn) {
              reportElements.add(ReportElement(
                  rentAndReturn,
                  vehicles
                      .where((element) => element.id == rentAndReturn.vehicle)
                      .toList()[0]));
            });
            print(rentAndReturnList);
            child = Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reportes",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Center(
                          child: FlatButton(
                            onPressed: () {
                              Report(reportElements, "General");
                            },
                            child: Text("Crear reporte"),
                            color: Colors.amberAccent,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: (MediaQuery.of(context).size.width * 0.6),
                        child: DefaultTabController(
                          length: 3,
                          child: Scaffold(
                            appBar: TabBar(
                              indicatorColor: Colors.amberAccent,
                              tabs: [
                                Tab(
                                    text: "Tabla",
                                    icon: Icon(
                                      Icons.view_comfortable_sharp,
                                    )),
                                Tab(
                                    text: "Grafico",
                                    icon: Icon(
                                      Icons.bar_chart_rounded,
                                    )),
                                Tab(
                                    text: "Ajustes",
                                    icon: Icon(
                                      Icons.settings,
                                    )),
                              ],
                            ),
                            body: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ReportTableView(reportElements, "General"),
                                ChartReportView(reportElements, "General"),
                                Center(
                                  child: Text("To be Implemented"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            child = Column(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            child = Column(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            );
          }
          return Container(
            child: child,
          );
        },
      ),
    );
  }
}
