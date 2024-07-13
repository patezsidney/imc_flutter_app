import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  final double _weight;
  final double _height;
  final DateTime _creationDate = DateTime.now();

  IMC(this._height, this._weight);

  String get id => _id;

  String get height => _height.toStringAsFixed(2);

  String get weight => _weight.toStringAsFixed(2);

  DateTime get creationDate => _creationDate;

  String imcIndex() => _calculate().toStringAsFixed(2);

  double _calculate() {
    return _weight / (_height * _height);
  }

  String imcClassification() {
    String imcClassification;

    double imcIndex = _calculate();

    if (imcIndex < 16) {
      imcClassification = "Magreza grave";
    } else if (imcIndex < 17) {
      imcClassification = "Magreza moderada";
    } else if (imcIndex < 18.5) {
      imcClassification = "Magreza leve";
    } else if (imcIndex < 25) {
      imcClassification = "Saudável";
    } else if (imcIndex < 30) {
      imcClassification = "Sobrepeso";
    } else if (imcIndex < 35) {
      imcClassification = "Obesidade Grau I";
    } else if (imcIndex < 40) {
      imcClassification = "Obesidade Grau II (severa)";
    } else {
      imcClassification = "Obesidade Grau III (mórbida)";
    }

    return imcClassification;
  }
}
