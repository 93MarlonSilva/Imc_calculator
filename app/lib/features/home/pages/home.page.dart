import 'dart:async';

import 'package:app/features/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController parHomeController;

  @override
  void initState() {
    super.initState();
    parHomeController = HomeController();
    showTimer();
  }

  // State footer timer
  void showTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      parHomeController.setDateTime = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()).replaceAll('-', '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Calculadora IMC'),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.brightness_1_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: RxBuilder(builder: (context) {
          return Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Bem Vindo!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  ),
                ),
                RxBuilder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 32),
                          child: TextField(
                              onChanged: (focus) {
                                parHomeController.setInvalidValueToCalc = '';
                                parHomeController.setValidName = '';
                              },
                              cursorColor: Theme.of(context).colorScheme.onPrimary,
                              controller: parHomeController.namePerson,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Nome:',
                                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary))))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          parHomeController.getValidName.isNotEmpty ? parHomeController.getValidName : '',
                          style: TextStyle(color: Theme.of(context).colorScheme.error, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  );
                }),
                RxBuilder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16),
                          child: TextField(
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              onChanged: (focus) {
                                parHomeController.setInvalidValueToCalc = '';
                                parHomeController.setValidWeight = '';
                              },
                              cursorColor: Theme.of(context).colorScheme.onPrimary,
                              controller: parHomeController.weightPerson,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Peso:',
                                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary))))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          parHomeController.getValidWeight.isNotEmpty ? parHomeController.getValidWeight : '',
                          style: TextStyle(color: Theme.of(context).colorScheme.error, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  );
                }),
                RxBuilder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16),
                          child: TextField(
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              onChanged: (focus) {
                                parHomeController.setInvalidValueToCalc = '';
                                parHomeController.setValidHeight = '';
                              },
                              cursorColor: Theme.of(context).colorScheme.onPrimary,
                              controller: parHomeController.heightPerson,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Altura:',
                                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                  border: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary))))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          parHomeController.getValidHeight.isNotEmpty ? parHomeController.getValidHeight : '',
                          style: TextStyle(color: Theme.of(context).colorScheme.error, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 28),
                  child: ElevatedButton(
                      onPressed: () {
                        parHomeController.calcImc();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),
                        minimumSize: const MaterialStatePropertyAll<Size>(Size(double.infinity, 40)),
                      ),
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                      )),
                ),
                Text(
                  parHomeController.getInvalidValueToCalc,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16),
                  child: Text(
                    'Histórico',
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                  child: RxBuilder(builder: (context) {
                    return Visibility(
                      visible: parHomeController.calcList.isNotEmpty,
                      child: RawScrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: parHomeController.calcList.toList().map<Column>((item) {
                              return Column(
                                children: [
                                  RxBuilder(builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item,
                                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                      ),
                                    );
                                  }),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        parHomeController.clearCalcList();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),
                        minimumSize: const MaterialStatePropertyAll<Size>(Size(double.infinity, 30)),
                      ),
                      child: Text(
                        'Limpar Histórico',
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
                      )),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(child: RxBuilder(builder: (context) {
                    return Text(
                      '®Santa ${parHomeController.getDateTime}',
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    );
                  })),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
