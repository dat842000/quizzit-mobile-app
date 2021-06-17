class Comment {
  final int id;
  final String name;
  final String content;
  final String imageUrl;
  final DateTime dateUp;

  Comment({
    required this.id,
    required this.name,
    required this.content,
    required this.imageUrl,
    required this.dateUp,
  });
}

// YOU - current user
final Comment currentUser = Comment(
  id: 1,
  name: 'Dat Nguyen',
  imageUrl: 'https://scontent.fsgn5-6.fna.fbcdn.net/v/t1.6435-9/172600480_2894518494156867_1493738166156079949_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=1aMndlcPap0AX85TE5l&_nc_ht=scontent.fsgn5-6.fna&oh=ef2bd4b0b4f5667097fff27829b948d5&oe=60D66539',
  content: "I like this post, very good",
  dateUp: DateTime.now()
);

// USERS
final Comment ojisan = Comment(
  id: 0,
  name: 'Ojisan',
  imageUrl: 'https://scontent-sin6-1.xx.fbcdn.net/v/t1.6435-1/p720x720/130926059_3586820534716638_8513722166239497233_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=52M4698X5oYAX9SLPFL&_nc_ht=scontent-sin6-1.xx&tp=6&oh=3b43fb51cf2698aefbd9f2ed29724085&oe=60E7FAEA',
  content: "This post is very useful. I can do it now",
  dateUp: DateTime.now()
);

final Comment anotherGuy = Comment(
  id: 2,
  name: 'Vinh',
  imageUrl: 'https://scontent-sin6-3.xx.fbcdn.net/v/t1.6435-9/62118713_2352579395000621_7361899465210331136_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=09cbfe&_nc_aid=0&_nc_ohc=oJWBxQjFJMQAX_f7b-f&_nc_ht=scontent-sin6-3.xx&oh=f8a35487883d02632eaff1d2ed88cb17&oe=60E7D745',
  content: "Ho ho ho",
  dateUp: DateTime.now()
);

final List<Comment> list = [
  currentUser,ojisan,anotherGuy
];
