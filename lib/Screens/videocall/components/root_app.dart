import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/videocall/components/participants_page.dart';
import 'package:flutter_auth/Screens/videocall/json/root_app_json.dart';
import 'package:flutter_auth/Screens/videocall/theme/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 2;
  List<String> url = [
    "https://www.androidcentral.com/sites/androidcentral.com/files/styles/xlarge/public/article_images/2020/07/android-11-screen-record-how-to-1.jpg",
    "https://media.giphy.com/media/UtcBRO8cxulRzkrVLc/giphy.gif",
    "https://upanh123.com/wp-content/uploads/2020/12/hinh-nen-den-tron1-576x1024.jpg"
  ];
  var linkUrl = "https://media.giphy.com/media/UtcBRO8cxulRzkrVLc/giphy.gif";

  void onDataChange(val) {
    setState(() {
      linkUrl = val;
      print(linkUrl);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorItems[2] = grey;
    bottomItems[1] = FontAwesomeIcons.video;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: headerAndFooter,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.volumeMute,
                  color: grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  FontAwesomeIcons.camera,
                  color: grey,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.security_outlined,
                  color: green,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Zoom",
                  style: TextStyle(
                      fontSize: 17, color: grey, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: grey,
                  size: 20,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => DashboardScreen()),
                    (route) => false);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: red, borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 5, bottom: 5),
                  child: Text("Leave",
                      style: TextStyle(
                          fontSize: 15,
                          color: grey,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ],
        ),
      ),
      body: getBody(linkUrl: linkUrl),
      bottomNavigationBar:
          getFooter(linkUrl: linkUrl, callback: (val) => onDataChange(val)),
    );
  }

  Widget getBody({linkUrl}) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 600,
              height: 515,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(linkUrl == null ? url[0] : linkUrl),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              width: 120,
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://media.giphy.com/media/WoKqL8nGDJfFwGzrmR/giphy.gif"),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFooter({linkUrl, callback}) {
    void onDataChange(val) {
      setState(() {
        linkUrl = val;
      });
    }

    void change() {
      setState(() {
        print(linkUrl);
        callback(linkUrl);
      });
    }

    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
          color: headerAndFooter,
          border: Border(
              top: BorderSide(width: 2, color: black.withOpacity(0.06)))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
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
                      colorItems[2] = grey;
                    } else {
                      colorItems[2] = green;
                    }
                    if (bottomItems[1] == FontAwesomeIcons.videoSlash) {
                      bottomItems[1] = FontAwesomeIcons.video;
                    }
                  }
                  if (index == 1) {
                    if (bottomItems[1] == FontAwesomeIcons.videoSlash) {
                      colorItems[2] = grey;
                      linkUrl = url[2];
                    } else {
                      colorItems[2] = grey;
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
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      textItems[index],
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: colorItems[index]),
                    )
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
