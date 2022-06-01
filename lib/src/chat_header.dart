import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/chat.dart';
import 'model/state.dart';

class FlutterSupportChatHeaderButton extends StatelessWidget {
  FlutterSupportChatHeaderButton({
    Key? key,
    required this.supporterID,
    required this.currentID,
    required this.firestoreInstance,
    required this.closeCaseText,
    required this.id,
    required this.back,
  }) : super(key: key);

  /// `supporterID` is a required list of Ids.
  /// Ids can be Email or FirebaseUsersIds
  /// This Ids are able to view all Cases.
  final List<String> supporterID;

  /// `currentID` is a required ID.
  /// Id can be Email or FirebaseUsersId
  /// Cases are visible based on this ID, comments are made for this id.
  final String currentID;

  /// `firestoreInstance` is required for using firestore
  final FirebaseFirestore firestoreInstance;

  /// `closeCaseText` is a optional String.
  /// This text is when a case should be closed
  final String closeCaseText;

  /// `id` is should only used in FlutterSupportChat.
  final String id;

  /// `back` is should only used in FlutterSupportChat.
  final Function back;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => back(),
              child: Container(
                height: 60,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                        ),
                      ],
                    ),
                    Text('Go back')
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                    closeCaseText,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_sharp,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final SupportChat c = SupportChat.fromFireStore(
                          await firestoreInstance
                              .collection(
                                'flutter_support_chat',
                              )
                              .doc(id)
                              .get(),
                        );
                        c.state = SupportCaseState.closed;
                        await c.update(
                          firestoreInstance.collection(
                            'flutter_support_chat',
                          ),
                        );
                        Navigator.pop(context);
                        back();
                      },
                      icon: Icon(
                        Icons.check,
                      ),
                    )
                  ],
                ),
              ),
              child: Container(
                height: 60,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.close,
                        ),
                      ],
                    ),
                    Text('End support')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
