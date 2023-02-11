import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFieldStyleWidget(String label, Widget widget) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 20),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: widget,
      ),
    ),
  );
}
