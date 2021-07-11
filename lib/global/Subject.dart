library globals;

import 'package:quizzit/models/group/Group.dart';
import 'package:quizzit/models/post/Post.dart';
import 'package:quizzit/models/subject/Subject.dart';

List<Subject> subjects = [];
Function()? forceRefresh;
List<Function(Group)> setState = [];
List<Function(Post)> setPost = [];
