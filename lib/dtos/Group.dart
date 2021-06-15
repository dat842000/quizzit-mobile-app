class Group{
  final String name;
  final String imgUrl;
  final DateTime createdDate;
  final int numberMember;
  final List<String> subjects;
  final int userCreate;
  int isJoin;
  //0 chua join; 1 joined; 2 pending

  Group(this.name, this.imgUrl, this.createdDate, this.subjects, this.numberMember, this.userCreate, this.isJoin);
}