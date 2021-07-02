import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context,StateSetter? stateSetter) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState1){
            stateSetter=setState1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  // value: _progress,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Loading. Please Wait"),
              ],
            );
          },
        ),
      );
    },
  );
}