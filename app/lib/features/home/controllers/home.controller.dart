import 'package:app/features/home/classes/person.class.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeController {
  Person person = Person();

  ///// Native Controllers
  final namePerson = TextEditingController();
  final weightPerson = TextEditingController();
  final heightPerson = TextEditingController();

  ///// States
  final _dateTime = RxNotifier<String>('');

  final _validName = RxNotifier<String>('');
  final _validWeight = RxNotifier<String>('');
  final _validHeight = RxNotifier<String>('');

  final _invalidValueToCalc = RxNotifier<String>('');

  final _calcList = RxList<String>([]);

  ///// Getters/Setters
  String get getDateTime => _dateTime.value;
  set setDateTime(String parValue) => _dateTime.value = parValue;

  String get getValidName => _validName.value;
  set setValidName(String parValue) => _validName.value = parValue;

  String get getValidWeight => _validWeight.value;
  set setValidWeight(String parValue) => _validWeight.value = parValue;

  String get getValidHeight => _validHeight.value;
  set setValidHeight(String parValue) => _validHeight.value = parValue;

  String get getInvalidValueToCalc => _invalidValueToCalc.value;
  set setInvalidValueToCalc(String parValue) => _invalidValueToCalc.value = parValue;

  List<String> get calcList => _calcList;

  ///// Functions

  // Add String to list
  void addCalcList(String parValue) {
    _calcList.add(parValue);
  }

  // Clear output data
  void clearCalcList() {
    _calcList.clear();
  }

  // Clear temp data
  void clearCalc() {
    person.setName('');
    person.setHeight(0.0);
    person.setWeight(0.0);
    namePerson.text = '';
    heightPerson.text = '';
    weightPerson.text = '';
  }

  // Make calc
  void calcImc() async {
    if (await validValues()) {
      person.setName(namePerson.text);
      person.setWeight(double.parse(weightPerson.text.replaceAll(',', '.')));
      person.setHeight(double.parse(heightPerson.text.replaceAll(',', '.')));
      var calcImc = person.getWeight() / (person.getHeight() * person.getHeight());
      selecionaOpcao(calcImc);
      clearCalc();
    }
  }

  // verify if is valid values
  Future<bool> validValues() async {
    final valid = RxNotifier<bool>(false);
    if (namePerson.text.isNotEmpty && !namePerson.text.contains('!@#\$%º¨&*()-_:;^~}]{[}/*+|?')) {
      valid.value = true;
    } else {
      _validName.value = 'Nome Inválido';
      _invalidValueToCalc.value = 'Preencha corretamente os campos';
      valid.value = false;
    }
    if (weightPerson.text.isNotEmpty && !weightPerson.text.contains('!@#\$%º¨&*()-_:;^~}]{[}/*+|?') && !weightPerson.text.contains(RegExp(r'^[a-z]+$')) && weightPerson.text != '0') {
      valid.value = true;
    } else {
      _validWeight.value = 'Peso Inválido';
      _invalidValueToCalc.value = 'Preencha corretamente os campos';
      valid.value = false;
    }
    if (heightPerson.text.isNotEmpty && !heightPerson.text.contains('!@#\$%º¨&*()-_:;^~}]{[}/*+|?') && !heightPerson.text.contains(RegExp(r'^[a-z]+$')) && heightPerson.text != '0') {
      valid.value = true;
    } else {
      _validHeight.value = 'Altura Inválida';
      _invalidValueToCalc.value = 'Preencha corretamente os campos';
      valid.value = false;
    }
    return valid.value;
  }

  // Verify status IMC Table
  void selecionaOpcao(double value) {
    switch (value) {
      case < 16:
        showMessage(value, 'Magreza grave!');
        break;
      case 16:
        showMessage(value, 'Magreza moderada!');
        break;
      case >= 17 && < 18.5:
        showMessage(value, 'Magreza leve!');
        break;
      case >= 18.5 && < 25:
        showMessage(value, 'Saudável!');
        break;
      case >= 25 && < 30:
        showMessage(value, 'Sobrepeso!');
        break;
      case >= 30 && < 35:
        showMessage(value, 'Obesidade Grau I!');
        break;
      case >= 35 && < 40:
        showMessage(value, 'Obesidade Grau II (severa)!');
        break;
      case >= 40:
        showMessage(value, 'Obesidade Grau III (mórbida)!');
        break;
      default:
        _invalidValueToCalc.value = 'Não foi possível calcular as medidas inseridas';
        break;
    }
  }

  // String to show screen
  void showMessage(double result, String classification) {
    final message = '${person.getName()} seu IMC é: ${result.toStringAsFixed(2)} classificado como: $classification';
    addCalcList(message);
  }
}
