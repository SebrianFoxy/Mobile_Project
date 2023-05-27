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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ListGame(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Text(exitlevel),
          )
        ],
      );
    },
  );
}
