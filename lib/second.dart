import 'package:flutter/material.dart';
import 'package:flutter_app/third.dart';

import 'additional/calendar.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 40, left: 20),
            child: new Text(
              "LICITEAZA",
              textAlign: TextAlign.start,
              style:
                  TextStyle(color: Color.fromRGBO(132, 7, 0, 1), fontSize: 18),
            ),
          ),
          _dotsWidget(),
          new Align(
            alignment: FractionalOffset.topRight,
            child: new Container(
              margin: EdgeInsets.only(right: 6, top: 4),
              child: new Text(
                'Stabileste\nora',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(80, 80, 80, 1.0)),
              ),
            ),
          ),
          new Expanded(
              child: new Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new GridCalendar(currentDate: DateTime.now())),
              ],
            ),
          )),
          new Stack(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 10, bottom: 10),
                child: new FlatButton(
                    onPressed: () {
                      goBack(context);
                    },
                    child: new Text(
                      'INAPOI',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(80, 80, 80, 1),
                      ),
                    )),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: new FlatButton(
                        onPressed: () {
                          goNext(context);
                        },
                        child: new Text(
                          'CREAZA',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(80, 80, 80, 1),
                          ),
                        )),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _dotsWidget() {
    return new Container(
      height: 30,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: new Stack(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            width: 30,
            height: 30,
            child: Center(
              child: new Text("1",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
            ),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                color: Colors.green),
          ),
          new Center(
            child: new Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 30, right: 30, top: 0),
                height: 1,
                color: Color.fromRGBO(236, 236, 236, 1)),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                width: 30,
                height: 30,
                child: Center(
                  child: new Text("2",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900)),
                ),
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                    color: Color.fromRGBO(132, 7, 0, 1)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //region Actions
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void goNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThirdPage(title: "Third Page")),
    );
  }
//endregion
}
