import 'dart:math';

import 'package:flutter_app/additional/utils.dart';

class Service {
  String name = "";
  String description = "";
  int rating = 0;
  int reviews = 0;
  String price = "";

  static Service generateRandomService() {
    Service service = new Service();
    service.name = RandomString(10);
    service.price = RandomPriceString(3);
    service.description = "Just description";

    var rng = new Random();
    int randomValue = rng.nextInt(5);

    service.rating = randomValue;
    service.reviews = rng.nextInt(1000);

    return service;
  }
}