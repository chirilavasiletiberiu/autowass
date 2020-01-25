import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/service.dart';

class ServicesGrid extends StatefulWidget {
  List<Service> services;

  ServicesGrid({@required this.services});

  @override
  _ServicesGridState createState() => _ServicesGridState();
}

class _ServicesGridState extends State<ServicesGrid> {
//  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return _buildPage(widget.services);
  }

  Widget _buildPage(List<Service> services) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(child: _buildGridService(services)),
      ],
    );
  }

  Widget _buildGridService(List<Service> services) {
    return GridView.count(
      childAspectRatio: 1.7,
        crossAxisCount: 2,
        children: List.generate(widget.services.length * 1, (int index) {
          return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(1),
              color: Colors.blueGrey.shade50,
              child:
                  new Center(child: _buildServiceTile(widget.services[index])));
        }));
  }

  Widget _buildServiceTile(Service service) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 4, left: 4, right: 10),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                service.name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              new Text(
                service.description,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
              new Container(
                margin: EdgeInsets.only(top: 6),
                child: new Text(
                  'COST ESTIMAT ${service.price} RON',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 10),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      width: 20,
                      height: 20,
                      child: new Image.asset('assets/images/star.png'),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 6),
                      child: new Text(
                        '${service.rating} (${service.reviews})',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
