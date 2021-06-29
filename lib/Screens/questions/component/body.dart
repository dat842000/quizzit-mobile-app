import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/questions/component/QuestionCard.dart';
import 'package:flutter_auth/Screens/questions/component/search_question_widget.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/group/Group.dart';
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/questions/Question.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  final Group group;
  int _currentPage = 1;

  Body(this.group);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  Future<Model.Page<Question>> fetchQuestionPage(
      {String content = "", int page = 1, required int groupId}) async {
    var paging = PagingParam(page: page, sort: "createAt_desc");

    Map<String, String> params = {
      ...paging.build(),
      ...{"content": content},
    };
    var response = await fetch(
        Host.groupOwnerQuestion(groupId: groupId), HttpMethod.GET,
        params: params);
    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk()) {
      setState(() {
        isLast = Model.Page<Question>.fromJson(jsonRes, Question.fromJsonModel).isLast;
      });

      return Model.Page<Question>.fromJson(jsonRes, Question.fromJsonModel);
    } else
      throw new Exception(response.body);
  }

  late Future<Model.Page<Question>> _questionFuture;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isLast = false;

  String _searchQuestion = "";

  List<Question> listQuestion = [];

  @override
  Widget build(BuildContext context) {
    return listQuestion.length != 0
        ? Column(children: [
            buildSearchQuestion(),
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: !isLast,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  itemCount: listQuestion.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      QuestionCard(listQuestion[index], widget.group),
                ),
              ),
            ),
          ])
        : Column(children: [
            buildSearchQuestion(),
            Center(child: CircularProgressIndicator())
          ]);
  }

  Widget buildSearchQuestion() => SearchQuestion(
        text: _searchQuestion,
        hintText: 'Nội dung câu hỏi',
        onCompleted: searchQuestion,
      );

  void searchQuestion(String search) {
    this._refreshController.requestRefresh();
    setState(() {
      this._searchQuestion = search;
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _questionFuture =
        fetchQuestionPage(groupId: widget.group.id, content: _searchQuestion);
    listQuestion = [];
    widget._currentPage = 1;
    setState(() {
      _questionFuture.then((value) => setState(() {
            listQuestion.addAll(value.content);
          }));
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _questionFuture = fetchQuestionPage(
        groupId: widget.group.id, page: ++widget._currentPage, content: _searchQuestion);
    _questionFuture.then((value) => setState(() {
          listQuestion.addAll(value.content);
        }));
    _refreshController.loadComplete();
  }

  @override
  // ignore: must_call_super
  void initState() {
    _questionFuture = fetchQuestionPage(groupId: widget.group.id);
    _questionFuture.then((value) => setState(() {
          listQuestion.addAll(value.content);
          // isLast = value.isLast;
        }));
  }
}
