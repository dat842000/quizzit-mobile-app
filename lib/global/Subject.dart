library globals;

import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/post/Post.dart';
import 'package:flutter_auth/models/subject/Subject.dart';

List<Subject> subjects = [];

List<Function(Group)> setState = [];
List<Function(Post)> setPost = [];