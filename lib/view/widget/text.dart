import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFieldStyleText(String label, String content) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(content),
      ),
    ),
  );
}
