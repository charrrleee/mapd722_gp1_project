import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField(String label, String content, ValueChanged<String>? onChanged, Function? validationFunction) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        initialValue: content,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        onChanged: onChanged,
        validator: (value) {
          if (validationFunction != null) {
            return validationFunction(value);
          }
          return null;
        },
      ),
    ),
  );
}