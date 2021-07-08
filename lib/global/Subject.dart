library globals;

import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/subject/Subject.dart';

List<Subject> subjects = [];

List<Function(Group)> setState = [];