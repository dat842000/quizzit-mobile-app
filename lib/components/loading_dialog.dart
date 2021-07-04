import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context,
    {StateSetter? stateSetter,
    String loadingText = "Loading. Please Wait..."}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState1) {
            stateSetter = setState1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                    // value: _progress,
                    ),
                SizedBox(
                  width: 8,
                ),
                Text(loadingText),
              ],
            );
          },
        ),
      );
    },
  );
}
