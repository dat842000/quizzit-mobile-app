import 'package:flutter/material.dart';
import 'package:quizzit/models/user/UserInfo.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget(this._user);
  final UserInfo _user;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // buildButton(context, '4.8', 'Ranking'),
          // buildDivider(),
          buildButton(context, _user.totalJoinedGroup.toString(), 'Join Group'),
          buildDivider(),
          buildButton(context, _user.totalOwnedGroup.toString(), 'Own Group'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(
          color: Colors.black,
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
