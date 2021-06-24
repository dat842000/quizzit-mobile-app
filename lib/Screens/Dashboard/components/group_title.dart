import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/components/status_button.dart';
import 'package:flutter_auth/Screens/UserViewGroup/user_view_group.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import 'Tags.dart';
import 'alert_widget.dart';

class GroupsTitle extends StatelessWidget {
  final Group _group;
  final bool isLast;

  GroupsTitle(this._group, {this.isLast = false});

  _showDialog(BuildContext context) {

    VoidCallback continueCallBack = () => {
      Navigator.of(context).pop(),
      // code on continue comes here
      // setState()
    };
    BlurryDialog alert = BlurryDialog(
        "Application",
        "Tell us the reason why you want to join this group?",
        continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      isLast ? const EdgeInsets.only(bottom: 45) : const EdgeInsets.only(),
      child: Center(
        child: Wrap(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigate.push(context, UserViewScreen(this._group));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width - 50,
                height: 245,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: CachedNetworkImage(
                        imageUrl: this._group.image ?? "",
                        height: 135,
                        width: MediaQuery.of(context).size.width - 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 10,
                              bottom: 0,
                            ),
                            child: Text(
                              this._group.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 3,
                              bottom: 7,
                            ),
                            child: Container(
                              height:27,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _group.subjects.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Tag(text: _group.subjects[index].name),
                                      const SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0xfff3f4fb),
                            height: 0,
                            thickness: 2,
                          ),
                          MemberStatus.inGroupStatuses.contains(_group.currentMemberStatus)
                              ? Padding(
                            padding: const EdgeInsets.only(
                              left: 12.4,
                              top: 15.5,
                              bottom: 15.5,
                              right: 0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 14.0),
                                      child: Text(
                                        DateFormat('EEE d MMM yyyy')
                                            .format(_group.createAt),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 14.0),
                                      child: Text(
                                        _group.totalMem.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                              left: 12.4,
                              top: 0,
                              bottom: 2,
                              right: 0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 14.0),
                                      child: Text(
                                        DateFormat('EEE d MMM yyyy')
                                            .format(_group.createAt),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 14.0),
                                      child: Text(
                                        _group.totalMem.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                    padding:
                                    const EdgeInsets.only(right: 10),
                                    child: StatusButton(_group.currentMemberStatus,onPressed: (){
                                      switch(_group.currentMemberStatus){
                                        case MemberStatus.notInGroup:
                                          return _showDialog(context);
                                        case MemberStatus.pending:
                                        //TODO Cancel
                                          break;
                                      }
                                    },)
                                  // _group.currentMemberStatus == 0
                                  //     ? FlatButton(
                                  //         minWidth: 110,
                                  //         onPressed: () {
                                  //           _showDialog(context);
                                  //         },
                                  //         child: Padding(
                                  //           padding:
                                  //               const EdgeInsets.all(0.0),
                                  //           child: Row(
                                  //             children: [
                                  //               Icon(
                                  //                 Icons.arrow_circle_down,
                                  //                 color: kPrimaryColor,
                                  //               ),
                                  //               SizedBox(
                                  //                 width: 10,
                                  //               ),
                                  //               Text(
                                  //                 "JOIN",
                                  //                 style: TextStyle(
                                  //                   fontWeight:
                                  //                       FontWeight.bold,
                                  //                   color: kPrimaryColor,
                                  //                 ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //         textColor: kPrimaryColor,
                                  //         shape: RoundedRectangleBorder(
                                  //             side: BorderSide(
                                  //                 color: Colors.blue,
                                  //                 width: 2,
                                  //                 style:
                                  //                     BorderStyle.solid),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(
                                  //                     10)),
                                  //       )
                                  //     : _group.currentMemberStatus == 2
                                  //         ? FlatButton(
                                  //             onPressed: () {
                                  //               //TODO ??
                                  //               // setState();
                                  //             },
                                  //             color: Colors.redAccent,
                                  //             child: Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(
                                  //                       0.0),
                                  //               child: Row(
                                  //                 children: [
                                  //                   Icon(
                                  //                     Icons.cancel,
                                  //                     color: Colors
                                  //                         .grey[200],
                                  //                   ),
                                  //                   SizedBox(
                                  //                     width: 5,
                                  //                   ),
                                  //                   Text(
                                  //                     "CANCEL",
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight
                                  //                                 .bold,
                                  //                         color: Colors
                                  //                             .grey[200]),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             textColor: kPrimaryColor,
                                  //             shape:
                                  //                 RoundedRectangleBorder(
                                  //                     side: BorderSide(
                                  //                         color: Colors
                                  //                             .redAccent,
                                  //                         width: 2,
                                  //                         style:
                                  //                             BorderStyle
                                  //                                 .solid),
                                  //                     borderRadius:
                                  //                         BorderRadius
                                  //                             .circular(
                                  //                                 10)),
                                  //           )
                                  //         : null,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}