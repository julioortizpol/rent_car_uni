import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:open_source_pro/models/ReportElements.dart';

import '../../utilities/constants.dart';

class ChartReportView extends StatefulWidget {
  List<ReportElement> reportElements;
  String typeFlag;

  ChartReportView(this.reportElements, this.typeFlag);
  @override
  State<StatefulWidget> createState() => ChartReportViewState();
}

class ChartReportViewState extends State<ChartReportView> {
  List<BarChartGroupData> graphData = [];

  BarChartGroupData graphElement(month, rents) {
    return BarChartGroupData(
      x: month,
      barRods: [
        BarChartRodData(y: rents, colors: [Colors.amber, Colors.black54])
      ],
      showingTooltipIndicators: [0],
    );
  }

  generateGraphData() {
    List data = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    widget.reportElements.forEach((element) {
      int month = (element.rentAndReturn.rentDate.month);
      data[(month - 1)] = data[(month - 1)] + 1;
    });
    data.asMap().forEach((index, value) {
      graphData.add(graphElement(index, value));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateGraphData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Rentas: Año 2021",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: const EdgeInsets.all(0),
                      tooltipBottomMargin: 8,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.y.round().toString(),
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      margin: 20,
                      getTitles: generalReportChartTitles,
                    ),
                    leftTitles: SideTitles(showTitles: false),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: graphData,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
