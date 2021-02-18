import 'package:flutter/material.dart';
import 'package:open_source_pro/network/vehicle_servie.dart';

class VehicleInfo extends StatefulWidget {
  String vehicleId;
  VehicleInfo({this.vehicleId});
  @override
  _VehicleInfoState createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  Future<dynamic> vehicle;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicle = getVehicle(widget.vehicleId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: vehicle, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = Flexible(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data.photo),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: null),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Modelo'),
                        subtitle: Text(
                            "${snapshot.data.carModel.brand.description} ${snapshot.data.carModel.description}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Descripción'),
                        subtitle: Text(snapshot.data.description),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Numero Chasis'),
                        subtitle: Text(snapshot.data.chasisNumber),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Numero Motor'),
                        subtitle: Text(snapshot.data.motorNumber),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Tipo de vehiculo'),
                        subtitle: Text(snapshot.data.vehicleType.description),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Tipo de combustible'),
                        subtitle: Text(snapshot.data.fuelType.description),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                    ],
                  ),
                )
              ],
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
          constraints: BoxConstraints(maxWidth: 1280),
          child: child,
        );
      },
    );
  }
}
