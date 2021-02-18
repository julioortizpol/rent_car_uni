import 'package:flutter/material.dart';
import 'package:open_source_pro/models/Client.dart';

class ClientListComponent extends StatefulWidget {
  final Client client;
  final Function toEditComponent;
  ClientListComponent({this.client, this.toEditComponent});
  @override
  _ClientListComponentState createState() => _ClientListComponentState();
}

class _ClientListComponentState extends State<ClientListComponent> {
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
            widget.toEditComponent(widget.client);
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text(widget.client.name),
                subtitle: Text(
                  (widget.client.state) ? "Activo" : "Inactivo",
                  style: TextStyle(
                      color: (widget.client.state) ? Colors.green : Colors.red),
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
