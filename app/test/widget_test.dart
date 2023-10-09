import 'package:app/features/home/classes/person.class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test if appBar title is equals "Calculadora IMC"', () {
    find.ancestor(of: find.byType(AppBar), matching: find.text("Calculadora IMC"));
  });
  test('Test if Person name propriety start empty', () {
    expect(Person().getName(), equals(''));
  });

  test('Test if Person weight propriety start 0.0', () {
    expect(Person().getWeight(), equals(0.0));
  });

  test('Test if Person height propriety start 0.0', () {
    expect(Person().getHeight(), equals(0.0));
  });
}
