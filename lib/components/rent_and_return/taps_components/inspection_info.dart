import 'package:flutter/material.dart';
import 'package:open_source_pro/network/inspection_service.dart';

class InspectionInfo extends StatefulWidget {
  String inspectionId;
  InspectionInfo({this.inspectionId});
  @override
  _InspectionInfoState createState() => _InspectionInfoState();
}

class _InspectionInfoState extends State<InspectionInfo> {
  Future<dynamic> inspection;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.inspectionId);
    inspection = getInspection(widget.inspectionId);
  }

  Widget getElementStateText(state) {
    return Text((state) ? "Activo" : "Inactivo",
        style: TextStyle(color: (state) ? Colors.green : Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: inspection, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          print(snapshot.data);
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
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Cantidad de combustible: '),
                        subtitle: Text("${snapshot.data.fuelQuantity}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Ralladuras: '),
                        subtitle: getElementStateText(snapshot.data.grated),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Goma de repuesta: '),
                        subtitle: getElementStateText(
                            snapshot.data.replacementRubber),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Roturas de cristal: '),
                        subtitle:
                            getElementStateText(snapshot.data.breakingGlass),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text('Gato: '),
                        subtitle:
                            getElementStateText(snapshot.data.vehicleJack),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          child: Text(
                            "Estado Gomas: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      Row(
                        children: [
                          Text("Goma 1: "),
                          getElementStateText(snapshot.data.wheelState[0]),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Goma 2: "),
                          getElementStateText(snapshot.data.wheelState[1]),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Goma 3: "),
                          getElementStateText(snapshot.data.wheelState[2]),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Goma 4: "),
                          getElementStateText(snapshot.data.wheelState[3]),
                        ],
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
