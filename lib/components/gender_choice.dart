import 'package:flutter/material.dart';

class GenderChoice extends StatefulWidget {
  const GenderChoice({Key? key,this.isRequired=false, required this.onSelected}) : super(key: key);
  final Function(int) onSelected;
  final isRequired;

  @override
  _GenderChoiceState createState() => _GenderChoiceState();
}

class _GenderChoiceState extends State<GenderChoice> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    widget.onSelected(_value);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(
          "Gender",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        widget.isRequired ? Text(
          "*",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.red),
        ):SizedBox()
      ]),
      SizedBox(
        height: 5,
      ),
      Row(children: [
        Wrap(alignment: WrapAlignment.start, children: [
          ChoiceChip(
            label: Text("Female"),
            selected: _value == 0 || !this.mounted,
            onSelected: (bool selected) {
              setState(() {
                _value = 0;
              });
            },
          ),
          ChoiceChip(
            label: Text("Male"),
            selected: _value == 1,
            onSelected: (bool selected) {
              setState(() {
                _value = 1;
              });
            },
          ),
          ChoiceChip(
            label: Text("Other"),
            selected: _value == 2,
            onSelected: (bool selected) {
              setState(() {
                _value = 2;
              });
            },
          )
        ])
      ])
    ]);
  }
}
