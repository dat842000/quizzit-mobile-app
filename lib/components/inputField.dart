import 'package:flutter/material.dart';

Widget inputField(
    {label,
      bool isRequired = false,
      obscureText = false,
      required Function exp}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87),
        ),
        isRequired
            ? Text(
          "*",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.red),
        )
            : SizedBox()
      ]),
      SizedBox(
        height: 5,
      ),
      TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!))),
          onChanged: (value) => exp(value)),
      SizedBox(
        height: 10,
      )
    ],
  );
}