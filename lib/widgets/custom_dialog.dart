import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'custom_text.dart';

showMyDialog(BuildContext context, Function(DateTime) onChangeJumma,
    Function(DateTime) onChangeDhulr, Function onUpdate) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Namaz Time'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    DatePicker.showTime12hPicker(context,
                        showTitleActions: true,
                        onConfirm: (value) => onChangeJumma(value),
                        currentTime: DateTime.now());
                  },
                  child: Text("Select Jumma Namaz Time")),
              InkWell(
                  onTap: () {
                    DatePicker.showTime12hPicker(context,
                        showTitleActions: true,
                        onConfirm: (value) => onChangeDhulr(value),
                        currentTime: DateTime.now());
                  },
                  child: Text("Select Dhuhr Namaz Time")),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Update'),
            onPressed: () => onUpdate(),
          ),
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
