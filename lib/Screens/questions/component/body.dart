import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/questions/component/QuestionCard.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/paging/PagingParams.dart';
import 'package:flutter_auth/models/paging/Page.dart' as Model;
import 'package:flutter_auth/models/questions/Question.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  Future<Model.Page<Question>> fetchQuestionPage(
      {String content = "", int page = 1, required int groupId}) async {
    var paging = PagingParam(page: page, sort: "createAt_desc");
    Map<String, String> params = {
      ...paging.build(),
      // ...{"content": content},
    };
    var response = await fetch(
        Host.groupOwnerQuestion(groupId: groupId), HttpMethod.GET,
        params: params);

    var jsonRes = json.decode(response.body);
    if (response.statusCode.isOk())
      return Model.Page<Question>.fromJson(jsonRes, Question.fromJsonModel);
    else
      throw new Exception(response.body);
  }

  final int groupId;
  int _currentPage = 1;

  Body(this.groupId);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model.Page<Question>>(
        future: widget.fetchQuestionPage(groupId: widget.groupId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("${snapshot.error}");
          if (snapshot.hasData)
            return Column(children: [
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                    itemCount: snapshot.data!.content.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => QuestionCard(
                        snapshot.data!.content[index], widget.groupId),
                  ),
                ),
              ),
            ]);
          return Center(child: CircularProgressIndicator());
        });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      widget.fetchQuestionPage(groupId: widget.groupId);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      widget.fetchQuestionPage(groupId: widget.groupId ,page: ++widget._currentPage);
    });
    _refreshController.loadComplete();
  }

  @override
  // ignore: must_call_super
  void initState() {
    widget.fetchQuestionPage(groupId: widget.groupId);
  }
}
