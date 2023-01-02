import 'package:flutter/material.dart';
import 'package:gofast/exports/export_services.dart';

class GlobalMethod {
  static void showErrorDialog(
      {required String error, required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error Occurred',
                    style: textStyle(20, Colors.white, FontWeight.w500),
                  ),
                ),
              ],
            ),
            content: Text(
              error,
              style: textStyle(20, Colors.black, FontWeight.w300),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        });
  }
}
