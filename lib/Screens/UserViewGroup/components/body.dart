import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_auth/Screens/ListUser/list_user.dart';
import 'package:flutter_auth/Screens/PostDetail/post_detail.dart';
import 'package:flutter_auth/Screens/quiz/quiz_screen.dart';
import 'package:flutter_auth/Screens/videocall/components/call.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/dtos/Group.dart';
import 'package:flutter_auth/dtos/Post.dart';
import 'package:flutter_auth/dtos/User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../global/UserLib.dart' as globals;

class Body extends StatelessWidget {
  DateTime date = DateTime.now();
  List<Post> posts = [
    Post(
        "title",
        DateTime.now(),
        "https://www.warmodroid.xyz/wp-content/uploads/2021/04/scheduling_background_task_flutter1-1024x576.png",
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch)."
            "4.6. Thay thế xâu con \n Sử dụng phương thức replaceAll(s, t) để thay thế tất cả các xâu con s bởi xâu t trong xâu ban đầu. Đương nhiên, kết quả trả về là một xâu mới.\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the \n 1960s with the release of Letraset sheets containing Lorem \n Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        User(
            "Dat Nguyen",
            "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
            "dnn8420@gmail.com")),
    Post(
        "Flutter",
        DateTime.now(),
        "https://banner2.cleanpng.com/20180421/fbq/kisspng-flutter-android-gesture-recognition-flutter-5adbdc9cb5e7d2.4449580015243583007451.jpg",
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch).",
        User(
            "Ojisan",
            "https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA",
            "haseoleonard@gmail.com")),
    Post(
        "Flutter",
        DateTime.now(),
        "https://banner2.cleanpng.com/20180421/fbq/kisspng-flutter-android-gesture-recognition-flutter-5adbdc9cb5e7d2.4449580015243583007451.jpg",
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch).",
        User(
            "Ojisan",
            "https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA",
            "haseoleonard@gmail.com")),
    Post(
        "Flutter",
        DateTime.now(),
        "",
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch).",
        User(
            "Vinh",
            "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/62118713_2352579395000621_7361899465210331136_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_aid=0&_nc_ohc=oJWBxQjFJMQAX_f7b-f&_nc_ht=scontent-sin6-3.xx&oh=f8a35487883d02632eaff1d2ed88cb17&oe=60E7D745",
            "Vinh@gmail.com")),
  ];
  final Group group;

  Body(this.group);

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e6eb),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 20,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(group.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 45 / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: group.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       IconButton(
                  //         icon: Icon(Icons.arrow_back_ios),
                  //         color: Colors.blue,
                  //         iconSize: 20,
                  //         onPressed: () => Navigator.pop(context),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListUser(group: group,),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
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
                      globals.userId == group.userCreate ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QuizScreen(),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: kPrimaryColor,
                              height: 60,
                              width: 60,
                              child: Icon(
                                FontAwesomeIcons.brain,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ) :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QuizScreen(),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: kPrimaryColor,
                              height: 60,
                              width: 60,
                              child: Icon(
                                FontAwesomeIcons.question,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            await _handleCameraAndMic(Permission.camera);
                            await _handleCameraAndMic(Permission.microphone);
                            // push video page with given channel name
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallPage(
                                  channelName: "test",
                                  role: ClientRole.Broadcaster,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: Color(0xFF8d949e),
                              height: 60,
                              width: 60,
                              child: Icon(
                                FontAwesomeIcons.video,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              color: Color(0xFFE46471),
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
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: posts.length,
              //     itemBuilder: (context, index) => PostCard(
              //       post: posts[index],
              //     ),
              //   ),
              // ),
              Column(
                children: <Widget>[
                  ...posts.map((item) {
                    return PostCard(
                      post: item,
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    String subContent = post.content.substring(0, 100) + "...";
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostDetailScreen(post)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(post.user.urlImg)),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.user.name,
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          post.user.email,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      post.urlImg.isEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            )
                          : CachedNetworkImage(
                              imageUrl: post.urlImg,
                              height: 200,
                              width:
                                  MediaQuery.of(context).size.width * 95 / 100,
                              fit: BoxFit.cover,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0,bottom: 4.0),
                        child: Align(
                          child: Text(post.title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Text(subContent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
