import 'package:open_source_pro/models/RentAndReturn.dart';
import 'package:open_source_pro/models/Vehicle.dart';

class ReportElement {
  Vehicle vehicle;
  RentAndReturn rentAndReturn;

  ReportElement(this.rentAndReturn, this.vehicle);
}
