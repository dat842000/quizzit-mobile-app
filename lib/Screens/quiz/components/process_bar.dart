import 'package:flutter/material.dart';

class ProcessBar extends StatefulWidget {
  double widthProcess;

  ProcessBar({required this.widthProcess});

  @override
  _ProcessBarState createState() => _ProcessBarState();
}

class _ProcessBarState extends State<ProcessBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
        children: [
      Container(
        height: 15,
        decoration: BoxDecoration(
            color: Color(0xffe8e8e8),
            border: Border.all(color: Colors.black87, width: 2),
            borderRadius: BorderRadius.circular(10)),
      ),
      Container(
        height: 15,
        width: widget.widthProcess,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black87, width: 2),
            color: Color(0xfffeba3b),
            borderRadius: BorderRadius.circular(10)),
      ),
      Positioned(
        left: widget.widthProcess-10,
        top: -2.5,
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87, width: 2),
            color: Color(0xfffeba3b),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ]);
  }
}
