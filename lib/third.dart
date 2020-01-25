import 'package:flutter/material.dart';
import 'package:flutter_app/additional/services_grid.dart';
import 'package:flutter_app/enumeration/services_sort.dart';
import 'package:flutter_app/models/service.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key key, this.title}) : super(key: key);

  final String title;

  List<Service> _services = List();

  @override
  _ThirdPageState createState() {
    for (int i = 0; i < 10; i++) {
      _services.add(Service.generateRandomService());
    }

    _services.sort((a, b) {
      int value = a.rating.compareTo(b.rating);
      if (value == -1) {
        return 1;
      }
      return -1;
    });

    return _ThirdPageState();
  }
}

class _ThirdPageState extends State<ThirdPage> {
  ServiceSort serviceSort = ServiceSort.RATING;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 40),
            child: new Align(
              alignment: FractionalOffset.center,
              child: new Container(
                margin: EdgeInsets.only(right: 6, top: 4),
                child: new Text(
                  'Programarea P1\n02.04.2019 08:30',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          _appointmentWidget(),
          new Align(
            alignment: FractionalOffset.center,
            child: new Container(
              margin: EdgeInsets.only(right: 6, top: 20),
              child: new Text(
                'Ofertanti',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          new Align(
            alignment: FractionalOffset.center,
            child: new Container(
              width: 300,
              height: 40,
              child: TextField(
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Cauta Ofertanti',
                ),
              ),
            ),
          ),
          _sortWidget(context),
          _servicesGrid(),
        ],
      ),
    );
  }

  //region Widgets
  Widget _servicesGrid() {
    return new Expanded(
        child: new Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: new Row(
        children: <Widget>[
          new Expanded(child: new ServicesGrid(services: widget._services)),
        ],
      ),
    ));
  }

  Widget _sortWidget(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.center,
      child: new Container(
        height: 40,
        margin: EdgeInsets.only(top: 40),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              'sortare dupa',
              style: TextStyle(
                  fontSize: 14, color: Color.fromRGBO(80, 80, 80, 1.0)),
            ),
            new Container(
              margin: EdgeInsets.only(left: 10),
              child: new RaisedButton(
                child: Text(_sortTitle(serviceSort)),
                onPressed: () {
                  showPicker(context);
                },
                textColor: Colors.blue,
                splashColor: Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appointmentWidget() {
    return new Align(
      child: new Container(
        margin: EdgeInsets.only(top: 20),
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(80, 80, 80, 0.4))),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              width: 60,
              child: new FittedBox(
                child: Image.asset('assets/images/car_icon.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 4, left: 4, right: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    'Seat Ibiza',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    '2017',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 6),
                    child: new Text(
                      'SERVISARE',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //endregion

  //region Additional
  String _sortTitle(ServiceSort sort) {
    switch (sort) {
      case ServiceSort.RATING:
        return "Rating";
      case ServiceSort.PRICE:
        return "Price";
      case ServiceSort.NAME:
        return "Name";
    }

    return "";
  }

  List<ServiceSort> _sortArray() {
    List<ServiceSort> array = new List();
    array.add(ServiceSort.RATING);
    array.add(ServiceSort.PRICE);
    array.add(ServiceSort.NAME);

    return array;
  }

  //endregion

  //region Actions
  void showPicker(BuildContext context) {
    PickerController pickerController = PickerController(
        count: 1, selectedItems: [_sortArray().indexOf(serviceSort)]);

    PickerViewPopup.showMode(
        PickerShowMode.BottomSheet, // AlertDialog or BottomSheet
        controller: pickerController,
        context: context,
        title: Text(
          'Sortare dupa:',
          style: TextStyle(fontSize: 14),
        ),
        cancel: Text(
          'Cancel',
          style: TextStyle(color: Colors.grey),
        ),
        onCancel: () {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('AlertDialogPicker.cancel')));
        },
        confirm: Text(
          'Confirm',
          style: TextStyle(color: Colors.blue),
        ),
        onConfirm: (controller) {
          changeSortType(controller);
        },
        builder: (context, popup) {
          return Container(
            height: 200,
            child: popup,
          );
        },
        itemExtent: 40,
        numberofRowsAtSection: (section) {
          return _sortArray().length;
        },
        itemBuilder: (section, row) {
          return Text(
            _sortTitle(_sortArray()[row]),
            style: TextStyle(fontSize: 12),
          );
        });
  }

  void changeSortType(PickerController controller) {
    setState(() {
      serviceSort = _sortArray()[controller.selectedRowAt(section: 0)];

      switch (serviceSort) {
        case ServiceSort.RATING:
          widget._services.sort((a, b) {
            int value = a.rating.compareTo(b.rating);

            if (value == -1) {
              return 1;
            }

            return -1;
          });
          break;
        case ServiceSort.PRICE:
          widget._services.sort((a, b) => a.price.compareTo(b.price));
          break;
        case ServiceSort.NAME:
          widget._services.sort((a, b) => a.name.compareTo(b.name));
          break;
      }
    });
  }

  void goBack(BuildContext context) {}

  void goNext(BuildContext context) {}
//endregion
}
