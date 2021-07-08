import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final Function(String value) onCompleted;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onCompleted,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width - 80,
      margin: const EdgeInsets.fromLTRB(0, 75, 5, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xfff6f6f6),
        // border: Border.all(color: Colors.black54,width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onCompleted('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onEditingComplete:()=>widget.onCompleted(controller.text),
      ),
    );
  }
}
