


import 'dart:io';

import 'package:flutter_auth/dtos/Post.dart';
import 'package:flutter_auth/dtos/User.dart';

class ListPost{
  static List<Post> listPost = [
    Post(
        "title",
        DateTime.now(),
        File('/data/user/0/com.quizgroup.quizzit/cache/image_picker5672831292116088876.jpg'),
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch)."
            "4.6. Thay thế xâu con \n Sử dụng phương thức replaceAll(s, t) để thay thế tất cả các xâu con s bởi xâu t trong xâu ban đầu. Đương nhiên, kết quả trả về là một xâu mới.\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the \n 1960s with the release of Letraset sheets containing Lorem \n Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        User(
            1,
            "Dat Nguyen",
            "https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539",
            "dnn8420@gmail.com",
            DateTime.now())),
    Post(
        "Flutter",
        DateTime.now(),
        File('/data/user/0/com.quizgroup.quizzit/cache/image_picker6205381347959650373.png'),
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch).",
        User(
            2,
            "Ojisan",
            "https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA",
            "haseoleonard@gmail.com",
            DateTime.now())),
    Post(
        "Flutter",
        DateTime.now(),
        File('/data/user/0/com.quizgroup.quizzit/cache/image_picker9052444345513280065.jpg'),
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch).",
        User(
            2,
            "Ojisan",
            "https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA",
            "haseoleonard@gmail.com",
            DateTime.now())),
    Post(
        "Flutter",
        DateTime.now(),
        null,
        "Như ví dụ trên, tạo ra hàng số a. Hằng số này sau khi khởi tạo thì không thay đổi nữa. Vấn đề hằng số này được khởi tạo bằng một giá trị ngẫu nhiên sinh ra bởi hàm Random, vậy mỗi lần chạy ứng dụng hằng số này có thể có giá trị khác nhau. Nó khác với const là cố định ngay từ khi viết code (hằng số biên dịch).",
        User(
            3,
            "Vinh",
            "https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/62118713_2352579395000621_7361899465210331136_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_aid=0&_nc_ohc=oJWBxQjFJMQAX_f7b-f&_nc_ht=scontent-sin6-3.xx&oh=f8a35487883d02632eaff1d2ed88cb17&oe=60E7D745",
            "Vinh@gmail.com",
            DateTime.now())),
  ];
}