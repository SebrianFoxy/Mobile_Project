import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../text/text.dart';
import '../../ui/listgame.dart';

void menulevel(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(levelmenu),
        content: Text(wtf),
        actions: [
          ElevatedButton(
            child: Text(nthg),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => ListGame()),
              );
            },
            child: Text(exitlevel),
          )
        ],
      );
    },
  );
}
