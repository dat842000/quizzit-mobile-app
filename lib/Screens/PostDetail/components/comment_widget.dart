import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/navigate.dart';
import 'package:flutter_auth/components/popup_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/comment/Comment.dart';
import 'package:flutter_auth/models/comment/CreateCommentModel.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatefulWidget {
  final Comment _comment;
  final Function(int commentId) onDelete;

  CommentWidget(this._comment, {required this.onDelete});

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  static const double _borderRadius = 20;
  bool _isUpdate = false;
  TextEditingController _editingController =
      TextEditingController(text: "widget._comment");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: ListTile(
            leading: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(55))),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                      widget._comment.user.avatar ?? defaultAvatar),
                ),
              ),
            ),
            title: this._isUpdate
                ? Column(
                    children: [
                      Material(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(_borderRadius),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: IntrinsicHeight(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(7)),
                                controller: _editingController,
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                // widget._comment.content,,
                              ),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            minWidth: 80,
                            onPressed: () {
                              fetch(Host.commentWithId(widget._comment.id),
                                      HttpMethod.PUT,
                                      data: CreateCommentModel(
                                          _editingController.text))
                                  .then((value) {
                                setState(() {
                                  widget._comment.content =
                                      _editingController.text;
                                  this._isUpdate = false;
                                });
                              });
                            },
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Update",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            textColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(width: 4),
                          // ignore: deprecated_member_use
                          FlatButton(
                            minWidth: 80,
                            onPressed: () {
                              setState(() {
                                this._isUpdate = false;
                              });
                            },
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            textColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      )
                    ],
                  )
                : Material(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(_borderRadius),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        onLongPress: () {
                          if (widget._comment.user.id ==
                              int.parse(FirebaseAuth.instance.currentUser!.uid))
                            _showCommentMenu(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget._comment.user.fullName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${DateFormat('hh:mm a').format(widget._comment.createdAt)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: IntrinsicHeight(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(7)),
                                      controller: new TextEditingController(text: widget._comment.content),
                                      readOnly: true,
                                      expands: true,
                                      minLines: null,
                                      maxLines: null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )))),
      ),
    );
  }

  void _showCommentMenu(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  this._editingController.text = widget._comment.content;
                  this._isUpdate = true;
                  Navigate.pop(context);
                });
              },
              child: Center(
                child: const Text("Update"),
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigate.pop(context);
                showOkCancelAlert(context,
                    "Delete Confirm",
                    "Are you sure to permanently delete this Comment ?",
                    onOkPressed:widget.onDelete(widget._comment.id)
                );
              },
              child: Center(
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              )),
          CupertinoActionSheetAction(
              child: Text("Cancel"), onPressed: () => Navigate.pop(context))
        ],
      ),
    );
  }
}
