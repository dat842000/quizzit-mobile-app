import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class StatusButton extends StatelessWidget{
  final int _currentMemberStatus;
  late final Color? _btnColor;
  late final String _btnText;
  late final Widget _icon;
  late final double _sizedBoxWidth;
  late final Color? _textColor;
  late final Color _borderColor;
  late final double? _minWidth;
  final VoidCallback onPressed;

  StatusButton(this._currentMemberStatus, {required this.onPressed}){
    switch(this._currentMemberStatus){
      case MemberStatus.kicked:
      case MemberStatus.leave:
      case MemberStatus.notInGroup:{
        this._btnColor=null;
        this._btnText="JOIN";
        this._textColor=kPrimaryColor;
        this._icon=Icon(
          Icons.arrow_circle_down,
          color: this._textColor,
        );
        this._sizedBoxWidth=10;
        this._borderColor=Colors.blue;
        this._minWidth=110;
        break;
      }
      case MemberStatus.pending:{
        this._btnColor=Colors.redAccent;
        this._btnText="CANCEL";
        this._textColor=Colors.grey[200];
        this._icon=Icon(
          Icons.cancel,
          color: this._textColor,
        );
        this._sizedBoxWidth=5;
        this._borderColor=Colors.redAccent;
        this._minWidth=null;
        break;
      }case MemberStatus.banned:{
      this._btnColor=Colors.redAccent;
      this._btnText="BANNED";
      this._textColor=Colors.grey[200];
      this._icon=Icon(
        Icons.cancel,
        color: this._textColor,
      );
      this._sizedBoxWidth=5;
      this._borderColor=Colors.redAccent;
      this._minWidth=null;
      break;
    }
      case MemberStatus.member:
      case MemberStatus.owner:
        this._btnColor=Color(0xFFbada85);
        this._btnText="JOINED";
        this._textColor=Colors.grey[200];
        this._icon=Icon(
          Icons.check,
          color: this._textColor,
        );
        this._sizedBoxWidth=5;
        this._borderColor=Color(0xFFbada85);
        this._minWidth=null;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: this._minWidth,
      onPressed: onPressed,
      color: this._btnColor,
      child: Padding(
        padding:
        const EdgeInsets.all(0.0),
        child: Row(
          children: [
            this._icon,
            SizedBox(
              width: this._sizedBoxWidth,
            ),
            Text(
              _btnText,
              style: TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  color: this._textColor),
            ),
          ],
        ),
      ),
      textColor: kPrimaryColor,
      shape:
      RoundedRectangleBorder(
          side: BorderSide(
              color: _borderColor,
              width: 2,
              style:BorderStyle.solid),
          borderRadius:BorderRadius.circular(10)),
    );
  }
}