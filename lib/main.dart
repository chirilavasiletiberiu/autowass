import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> _products = new List<Product>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
      children: <Widget>[
        new Column(
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
            new Padding(
              padding: EdgeInsets.only(top: 40, left: 10, bottom: 10),
              child: new Text(
                "Task 1",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            new Expanded(
              child: _productsList(),
            ),
          ],
        ),
        new Align(
          alignment: FractionalOffset.bottomRight,
          child: new Container (
            margin: EdgeInsets.only(bottom: 20, right: 20),
            child: new FlatButton(onPressed: () {
              pushToNextScreen();
            }, child: new Text(
              'INAINTE',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(80, 80, 80, 1),
              ),
            )),
          )
        )
      ],
      ),
    );
  }

  //region List View Widgets
  ListView _productsList() {
    return ListView.builder(
        itemBuilder: (BuildContext _context, int i) {
          if (i == 0) {
            return _buildHeader();
          }

          if (i == _products.length + 1) {
            return _buildAddRow();
          }

          return _buildRow(_products[i - 1]);
        },
        itemCount: _products.length + 2);
  }

  Widget _buildRow(Product product) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(180, 180, 180, 0.4)))),
      height: 40,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              product.name,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "${product.quantity}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "${product.price}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "${product.price * product.quantity}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FlatButton(
              onPressed: () {
                removeProduct(product);
              },
              child: Image.asset('assets/images/remove_icon.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRow() {
    return Container(
        margin: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 10),
        child: new Row(
          children: <Widget>[
            Container(
              width: 120,
              height: 30,
              child: TextField(
                controller: _productNameController,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Nume',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 40,
              height: 30,
              child: TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Cant.',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 30,
              height: 30,
              child: SizedBox.fromSize(
                size: Size(56, 56), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Color.fromRGBO(132, 7, 0, 1), // button color
                    child: InkWell(
                      splashColor: Color.fromRGBO(132, 7, 0, 1), // splash color
                      onTap: () {
                        if (_productNameController.text.isEmpty ||
                            _quantityController.text.isEmpty) {
                          showAlert(
                              "Please make sure both values are completed");
                        } else {
                          int value = int.tryParse(_quantityController.text);

                          if (value != null) {
                            addNewProduct(_productNameController.text, value);
                          }
                        }
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '+',
                            style: TextStyle(color: Colors.white),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildHeader() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(180, 180, 180, 0.4)))),
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              'Produs',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Cantitate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Pret Unitar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Total',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
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
                color: Color.fromRGBO(132, 7, 0, 1)),
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
                    color: Color.fromRGBO(180, 180, 180, 1)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextEditingController _productNameController =
      TextEditingController(text: "");
  TextEditingController _quantityController = TextEditingController();

//endregion

  void addNewProduct(String name, int quantity) {
    setState(() {
      _productNameController.text = "";
      _quantityController.text = "";

      Product product = Product.newProduct(name, quantity);
      _products.add(product);
    });
  }

  void removeProduct(Product product) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure you want to remove this product?"),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  _products.remove(product);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void pushToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondRoute()),
    );

//    if (_products.length == 0) {
//        showAlert("Please add your products.");
//    }
//    else {
//    }
  }

  Future<void> showAlert(String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
