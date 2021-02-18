import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_source_pro/models/ReportElements.dart';

import '../../utilities/constants.dart';

class ReportTableView extends StatefulWidget {
  List<ReportElement> reportElements;
  String typeFlag;
  ReportTableView(this.reportElements, this.typeFlag);
  @override
  _ReportTableViewState createState() => _ReportTableViewState();
}

class _ReportTableViewState extends State<ReportTableView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.reportElements.forEach((element) {
      tableData.add(dataRowGeneralReport(element));
    });
    labels = tableReportLabels[widget.typeFlag];
  }

  final format = DateFormat("dd-MM-yyyy");
  List<DataRow> tableData = [];
  List<String> labels;

  @override
  DataColumn dataColumnCreator(String text) {
    return DataColumn(
      label: Text(
        text,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  DataRow dataRowGeneralReport(ReportElement reportElement) {
    return DataRow(
      cells: <DataCell>[
        DataCell(
            Text(format.format(reportElement.rentAndReturn.devolutionDay))),
        DataCell(Text(
            "${reportElement.rentAndReturn.employee.name} - ${reportElement.rentAndReturn.employee.personId}")),
        DataCell(Text(
            "${reportElement.rentAndReturn.client.name} - ${reportElement.rentAndReturn.client.personId}")),
        DataCell(Text(
            "${reportElement.vehicle.carModel.brand.description} - ${reportElement.vehicle.carModel.description}")),
        DataCell(Text(reportElement.rentAndReturn.id)),
        DataCell(Text((reportElement.rentAndReturn.close)
            ? "Retornado"
            : ((reportElement.rentAndReturn.devolutionDay
                    .isAfter(DateTime.now())))
                ? "Rentado"
                : "Atrasado")),
      ],
    );
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          columns: labels.map((e) => dataColumnCreator(e)).toList(),
          rows: tableData,
        ),
      ),
    );
  }
}
