import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CreatePost/create_post.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/ListUser/list_user.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';

class GroupTopBar extends StatelessWidget {
  GroupTopBar(this.group);
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: Container(
            color: Colors.white,
            height: 76,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Container(
                child: InkWell(
                  onTap: () {
                    Navigate.push(context, CreatePostScreen(group));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 8.0, top: 8, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      child: Container(
                        color: Color(0xFF309398),
                        height: 60,
                        width: 60,
                        child: Icon(
                          FontAwesomeIcons.plusSquare,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // width: 62,
              ),
              InkWell(
                onTap: () {
                  Navigate.push(context, ListUser(group: group));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    child: Container(
                      color: Color(0xFFF9BE7C),
                      height: 60,
                      width: 60,
                      child: Icon(
                        FontAwesomeIcons.userAlt,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // globals.userId == group.userCreate
              //     ? Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: InkWell(
              //           onTap: () {
              //             Navigator.of(context)
              //                 .push(MaterialPageRoute(
              //               builder: (context) => QuizScreen(),
              //             ));
              //           },
              //           child: ClipRRect(
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0)),
              //             child: Container(
              //               color: kPrimaryColor,
              //               height: 60,
              //               width: 60,
              //               child: Icon(
              //                 FontAwesomeIcons.question,
              //                 size: 26,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) =>
              //             ChatScreen(user: us.ironMan),
              //       ));
              //     },
              //     child: ClipRRect(
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(25.0)),
              //       child: Container(
              //         color: Color(0xFFE46471),
              //         height: 60,
              //         width: 60,
              //         child: Icon(
              //           FontAwesomeIcons.comment,
              //           size: 26,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => QuizScreen(),
                    //   ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    child: Container(
                      color: kPrimaryColor,
                      height: 60,
                      width: 60,
                      child: Icon(
                        FontAwesomeIcons.info,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 16, top: 8, bottom: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    child: Container(
                      color: Colors.grey,
                      height: 60,
                      width: 60,
                      child: Icon(
                        FontAwesomeIcons.link,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    child: Container(
                      color: Colors.redAccent,
                      height: 60,
                      width: 60,
                      child: Icon(
                        Icons.logout,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ])
        )
    );
  }
}

// class GroupTopBar extends StatelessWidget {
//   final Group group;
//
//   const GroupTopBar({Key? key, required this.group}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         navigate(context, CreatePostScreen(group));
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
//         child: Container(
//           color: Colors.white,
//           height: 76,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//
//               ///Create new Post
//               Container(
//                 child: InkWell(
//                   onTap: () {
//                     navigate(context, CreatePostScreen(group));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 16.0, right: 8.0, top: 8, bottom: 8),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                       child: Container(
//                         color: Color(0xFF309398),
//                         height: 60,
//                         width: 60,
//                         child: Icon(
//                           FontAwesomeIcons.plusSquare,
//                           size: 26,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               ///END CREATE NEW POST
//               ///MEMBER LIST
//               InkWell(
//                 onTap: () {
//                   navigate(context, ListUser(group: group));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                     child: Container(
//                       color: Color(0xFFF9BE7C),
//                       height: 60,
//                       width: 60,
//                       child: Icon(
//                         FontAwesomeIcons.userAlt,
//                         size: 17,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               ///END MEMBER LIST
//               ///Quiz Sections
//               int.parse(FirebaseAuth.instance.currentUser!.uid) == group.owner.id
//                   ? Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     navigate(context, QuizScreen());
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                     child: Container(
//                       color: kPrimaryColor,
//                       height: 60,
//                       width: 60,
//                       child: Icon(
//                         FontAwesomeIcons.question,
//                         size: 26,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//                   : Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     navigate(context, QuizScreen());
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                     child: Container(
//                       color: kPrimaryColor,
//                       height: 60,
//                       width: 60,
//                       child: Icon(
//                         FontAwesomeIcons.brain,
//                         size: 26,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               ///END Quiz Sections
//               ///Chat Button
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     navigate(context, ChatScreen(user: us.ironMan));
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                     child: Container(
//                       color: Color(0xFFE46471),
//                       height: 60,
//                       width: 60,
//                       child: Icon(
//                         FontAwesomeIcons.comment,
//                         size: 26,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               ///End Chat Button
//               ///Leave Button
//               InkWell(
//                 onTap: () {
//                   navigate(context, DashboardScreen());
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                     child: Container(
//                       color: Colors.redAccent,
//                       height: 60,
//                       width: 60,
//                       child: Icon(
//                         Icons.logout,
//                         size: 26,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               ///End Leave Button
//               ///Share Group Button
//               InkWell(
//                 onTap: () {
//                   navigate(context, DashboardScreen());
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 8.0, right: 16, top: 8, bottom: 8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                     child: Container(
//                       color: Colors.grey,
//                       height: 60,
//                       width: 60,
//                       child: Icon(
//                         FontAwesomeIcons.link,
//                         size: 26,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               ///End Share Group Button
//             ],
//             ///End Bar Children Widget
//           ),
//         ),
//       ),
//     );
//   }
// }
