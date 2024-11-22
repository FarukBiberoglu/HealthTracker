import 'package:flutter/cupertino.dart';

class UserProivder extends ChangeNotifier {
  double protein = 0.0;
  double karbonhidrat = 0.0;
  double yag = 0.0;

  void alinanMakrolar(double newPro, double newKarb, double newYag) {
    protein = newPro;
    karbonhidrat = newKarb;
    yag = newYag;
    notifyListeners();
  }
}