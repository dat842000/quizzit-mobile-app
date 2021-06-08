import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          right: 27.0,
          left: 27.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Groups",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF0D253F),
                      fontWeight: FontWeight.w600),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),

                  child: Container(
                    color: Color(0xFF309398),
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.group,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    child: Container(
                      color: Color(0xFFE46471),
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.how_to_reg_sharp,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Group',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text('Quantity: 1')
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    child: Container(
                      color: Color(0xFFF9BE7C),
                      height: 40,
                      width: 40,
                      child: Icon(
                        FontAwesomeIcons.userAlt,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Group Join',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Quantity: 5')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
