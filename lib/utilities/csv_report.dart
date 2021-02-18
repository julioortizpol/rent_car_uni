import 'dart:html';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:open_source_pro/models/ReportElements.dart';

import 'constants.dart';

final format = DateFormat("dd-MM-yyyy");

class Report {
  String reportType;
  List<ReportElement> data;

  Report(this.data, this.reportType) {
    this.makeReport();
  }

  makeReport() async {
    await this.getCsv(data, tableReportLabels[reportType]);
  }

  getCsv(data, labels) async {
    List<List<dynamic>> rows = List<List<dynamic>>();

    rows.add(labels);

    data.forEach((reportElement) {
      List<dynamic> row = List<dynamic>();
      row.add(format.format(reportElement.rentAndReturn.devolutionDay));
      row.add(
          "${reportElement.rentAndReturn.employee.name} - ${reportElement.rentAndReturn.employee.personId}");
      row.add(
          "${reportElement.rentAndReturn.client.name} - ${reportElement.rentAndReturn.client.personId}");
      row.add(
          "${reportElement.vehicle.carModel.brand.description} - ${reportElement.vehicle.carModel.description}");
      row.add(reportElement.rentAndReturn.id);
      row.add((reportElement.rentAndReturn.close)
          ? "Retornado"
          : ((reportElement.rentAndReturn.devolutionDay
                  .isAfter(DateTime.now())))
              ? "Rentado"
              : "Atrasado");
      rows.add(row);
    });

    String csv = const ListToCsvConverter().convert(rows);
    new AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
      ..setAttribute("download", "data.csv")
      ..click();
  }
}
