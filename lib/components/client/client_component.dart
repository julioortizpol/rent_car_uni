import 'package:flutter/material.dart';

import '../../network/client_service.dart';
import 'client_list_component.dart';

class ClientComponent extends StatefulWidget {
  @override
  Function toEditComponent;
  bool rentFlow;
  ClientComponent({this.toEditComponent, this.rentFlow});
  ClientComponentState createState() {
    return ClientComponentState();
  }
}

class ClientComponentState extends State<ClientComponent> {
  Future<List<dynamic>> client;
  List<Widget> clientsComponent;
  List<Widget> searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = getClients();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: client, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          clientsComponent = snapshot.data
              .map((client) {
                return ClientListComponent(
                  client: client,
                  toEditComponent: widget.toEditComponent,
                );
              })
              .toList()
              .where((element) => !widget.rentFlow || element.client.state)
              .toList();
          children = <Widget>[
            Visibility(
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  onChanged: (value) {
                    searchResult = snapshot.data
                        .map((client) {
                          return ClientListComponent(
                            client: client,
                            toEditComponent: widget.toEditComponent,
                          );
                        })
                        .toList()
                        .where((element) =>
                            (!widget.rentFlow || element.client.state) &&
                            element.client.name.contains(value))
                        .toList();
                    setState(() {});
                  },
                  decoration: InputDecoration(labelText: "Nombre"),
                ),
              ),
              visible: widget.rentFlow,
            ),
            Expanded(
              child: (searchResult.length != 0)
                  ? ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return searchResult[index];
                      },
                    )
                  : ListView.builder(
                      itemCount: clientsComponent.length,
                      itemBuilder: (context, index) {
                        return clientsComponent[index];
                      },
                    ),
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Expanded(
          child: Column(
            children: children,
          ),
        );
      },
    );
  }
}
