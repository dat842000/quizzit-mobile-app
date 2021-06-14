class Group{
  final String name;
  final String imgUrl;
  final DateTime createdDate;
  final int numberMember;
  final List<String> subjects;
  final int userCreate;

  Group(this.name, this.imgUrl, this.createdDate, this.subjects, this.numberMember, this.userCreate);
}