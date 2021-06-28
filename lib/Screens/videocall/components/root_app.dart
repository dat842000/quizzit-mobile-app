import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/videocall/components/participants_page.dart';
import 'package:flutter_auth/Screens/videocall/json/root_app_json.dart';
import 'package:flutter_auth/Screens/videocall/theme/colors.dart';
import 'package:flutter_auth/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int index = 0;
  int pageIndex = 2;
  bool changeView = false;
  List<String> url = [
    "https://www.androidcentral.com/sites/androidcentral.com/files/styles/xlarge/public/article_images/2020/07/android-11-screen-record-how-to-1.jpg",
    "https://media.giphy.com/media/7dO0jm9QlETWd4ASF3/giphy.gif",
    "https://upanh123.com/wp-content/uploads/2020/12/hinh-nen-den-tron1-576x1024.jpg",
    "https://media.giphy.com/media/kD6WDs6oYVkuHo4g4O/giphy.gif"
  ];
  var linkUrl = "https://media.giphy.com/media/7dO0jm9QlETWd4ASF3/giphy.gif";

  void onDataChange(val) {
    setState(() {
      linkUrl = val;
    });
  }

  void change() {
    setState(() {
      if (changeView == false) {
        changeView = true;
      } else {
        changeView = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorItems[2] = white;
    bottomItems[1] = FontAwesomeIcons.video;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.volumeMute,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.eye,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        change();
                      })
                ],
              ),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.security_outlined,
              //       color: green,
              //       size: 15,
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       "Zoom",
              //       style: TextStyle(
              //           fontSize: 17, color: grey, fontWeight: FontWeight.bold),
              //     ),
              //     Icon(
              //       Icons.keyboard_arrow_down,
              //       color: grey,
              //       size: 20,
              //     ),
              //   ],
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => DashboardScreen()),
                      (route) => false);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 5, bottom: 5),
                    child: Text("Leave",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: getBody(linkUrl: linkUrl),
        bottomNavigationBar:
            getFooter(linkUrl: linkUrl, callback: (val) => onDataChange(val)),
        extendBodyBehindAppBar: true,
        extendBody: true,
      ),
      bottomNavigationBar: changeView ? controllerView() : null,
    );
  }

  Widget controllerView() {
    return Container(
        height: 100,
        color: Colors.black,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 1.5, bottom: 3.0, left: 3.0, right: 1.5),
              child: Container(
                width: 97,
                decoration: BoxDecoration(
                    color: Color(0xffB4B5D4),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://scontent-hkt1-2.xx.fbcdn.net/v/t1.6435-9/204333890_2947606698848046_2471054969970351329_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=g8Wz8eFbP3AAX_FTsPW&_nc_ht=scontent-hkt1-2.xx&oh=0563a1113b085a8dcade125928cb0b9b&oe=60DC7412")),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.screen_share,
                              color: Colors.lightGreenAccent,
                              size: 20,
                            ),
                            SizedBox(width: 5,),
                            Icon(
                              Icons.mic_off_rounded,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 1.5, bottom: 3.0, left: 3.0, right: 1.5),
              child: Container(
                width: 97,
                decoration: BoxDecoration(
                    color: Color(0xffB4B5D4),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://vtv1.mediacdn.vn/thumb_w/650/2019/6/15/cristiano-ronaldo-nations-league-1200x700-15605556325522018215593-crop-1622762075691274255505.jpg")),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.white,
                          size: 20,
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 1.5, bottom: 3.0, left: 3.0, right: 1.5),
              child: Container(
                width: 97,
                decoration: BoxDecoration(
                    color: Color(0xffB4B5D4),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://scontent.fhan5-2.fna.fbcdn.net/v/t1.15752-9/202463407_501900284252626_3664018998250728780_n.png?_nc_cat=102&ccb=1-3&_nc_sid=ae9488&_nc_ohc=Y5Ntt4KLmDwAX8tBCNx&_nc_ht=scontent.fhan5-2.fna&oh=e97eb2185f7537c0235c9c567fd76923&oe=60DCF747")),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.lightGreenAccent,
                          size: 20,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget getBody({linkUrl}) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: changeView
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      image: DecorationImage(
                          image:
                              NetworkImage(linkUrl == null ? url[0] : linkUrl),
                          fit: BoxFit.cover)),
                ),
              )
            : Stack(children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 600,
                    height: size.height * 50 / 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                linkUrl == null ? url[0] : linkUrl),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 2,
                  child: Container(
                    width: size.width * 49 / 100,
                    height: size.height * 49 / 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://www.androidcentral.com/sites/androidcentral.com/files/styles/xlarge/public/article_images/2020/07/android-11-screen-record-how-to-1.jpg"),
                            fit: BoxFit.cover)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mic_off_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(
                                    Icons.screen_share,
                                    color: Colors.lightGreenAccent,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Dat Nguyen",
                                      style: TextStyle(color: Colors.white,fontSize: 13)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 2,
                  child: Container(
                    width: size.width * 49 / 100,
                    height: size.height * 49 / 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://scontent.fhan5-2.fna.fbcdn.net/v/t1.15752-9/202463407_501900284252626_3664018998250728780_n.png?_nc_cat=102&ccb=1-3&_nc_sid=ae9488&_nc_ohc=Y5Ntt4KLmDwAX8tBCNx&_nc_ht=scontent.fhan5-2.fna&oh=e97eb2185f7537c0235c9c567fd76923&oe=60DCF747"),
                            fit: BoxFit.cover)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(6.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mic_rounded,
                                    color: Colors.lightGreenAccent,
                                    size: 20,
                                  ),
                                  Text("Thay Kiem",
                                      style: TextStyle(color: Colors.white,fontSize: 13)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]));
  }

  Widget getFooter({linkUrl, callback}) {
    void change() {
      setState(() {
        callback(linkUrl);
      });
    }

    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 65,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              top: BorderSide(width: 2, color: black.withOpacity(0.06)))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                  if (index == 2) {
                    if (linkUrl == url[0]) {
                      linkUrl = url[1];
                    } else {
                      linkUrl = url[0];
                    }
                    if (colorItems[2] == green) {
                      colorItems[2] = white;
                    } else {
                      colorItems[2] = green;
                    }
                    if (bottomItems[1] == FontAwesomeIcons.videoSlash) {
                      bottomItems[1] = FontAwesomeIcons.video;
                    }
                  }
                  if (index == 1) {
                    if (bottomItems[1] == FontAwesomeIcons.videoSlash) {
                      colorItems[2] = white;
                      linkUrl = url[2];
                    } else {
                      colorItems[2] = white;
                      linkUrl = url[1];
                    }
                  }
                  change();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(bottomItems[index],
                        size: sizedItems[index], color: colorItems[index]),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   textItems[index],
                    //   style: TextStyle(
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.w600,
                    //       color: colorItems[index]),
                    // )
                  ],
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
    if (index == 0) {
      bottomItems[0] == FontAwesomeIcons.microphone
          ? bottomItems[0] = FontAwesomeIcons.microphoneSlash
          : bottomItems[0] = FontAwesomeIcons.microphone;
    }
    if (index == 1) {
      bottomItems[1] == FontAwesomeIcons.video
          ? bottomItems[1] = FontAwesomeIcons.videoSlash
          : bottomItems[1] = FontAwesomeIcons.video;
    }
    if (index == 2) {
      // if (colorItems[2] == green) {
      //   bottomItems[1] = FontAwesomeIcons.video;
      // } else {
      //   bottomItems[1] = FontAwesomeIcons.videoSlash;
      // }
    }
    if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true, builder: (_) => ParticipantsPage()));
    }
    if (index == 4) {
      getBottomSheet();
    }
  }

  getBottomSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: List.generate(actionSheetItems.length, (index) {
                if (actionSheetItems[index] == "Disconnect Audio") {
                  return CupertinoActionSheetAction(
                    child: Text(
                      actionSheetItems[index],
                      style: TextStyle(color: red),
                    ),
                    onPressed: () {
                      Navigator.pop(context, 'One');
                    },
                  );
                } else if (actionSheetItems[index] ==
                    "👏   👍   💔   🤣   😮   🎉") {
                  return CupertinoActionSheetAction(
                    child: Text(
                      actionSheetItems[index],
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.pop(context, 'One');
                    },
                  );
                }
                return CupertinoActionSheetAction(
                  child: Text(actionSheetItems[index]),
                  onPressed: () {
                    Navigator.pop(context, 'One');
                  },
                );
              }),
              cancelButton: CupertinoActionSheetAction(
                child: const Text(
                  'Cancel',
                ),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ));
  }
}
