import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/utilities/export.dart';

/// This is the screen all users would see when sending messages to other users
class ChatScreen extends StatefulWidget {
  /// This variable stores the current users UID
  final String userID;

  /// This variable stores the document reference ID for the currently viewed conversation in firebase
  final String documentReferenceID;

  /// This is the constructor for this screen which assigns the document reference id and user id to their respective variables
  const ChatScreen({
    Key? key,
    required this.documentReferenceID,
    required this.userID,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  String messageText = '';
  final DatabaseProvider databaseProvider =
      DatabaseProvider(db: FirebaseFirestore.instance);
  late List<MessageModel> messages;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    textController.clear();
    FocusScope.of(context).unfocus();
    EasyLoading.show(status: 'loading...');
    final result = await authProvider.sendNewMessage(
      documentReferenceID: widget.documentReferenceID,
      message: messageText,
    );
    EasyLoading.dismiss();
    if (result != null) {
      EasyLoading.showError(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: databaseProvider.getMessages(
                documentReferenceID: widget.documentReferenceID,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'An error was encountered, messages were not fetched',
                      ),
                    );
                  }
                } else {
                  final messagesDB = snapshot.data!.docs;
                  messages = <MessageModel>[];
                  for (final item in messagesDB) {
                    final individualMessage = MessageModel(
                      senderID: item['senderID'] as String,
                      firstName: item['firstName'] as String,
                      lastName: item['lastName'] as String,
                      message: item['message'] as String,
                      createdAt: (item['createdAt'] as Timestamp).toDate(),
                    );
                    messages.add(individualMessage);
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment:
                              messages[index].senderID == widget.userID
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.all(16),
                              constraints: const BoxConstraints(maxWidth: 140),
                              decoration: BoxDecoration(
                                color: messages[index].senderID == widget.userID
                                    ? Colors.grey
                                    : Theme.of(context).colorScheme.secondary,
                                borderRadius:
                                    messages[index].senderID == widget.userID
                                        ? const BorderRadius.all(
                                            Radius.circular(12),
                                          ).subtract(
                                            const BorderRadius.only(
                                              bottomRight: Radius.circular(12),
                                            ),
                                          )
                                        : const BorderRadius.all(
                                            Radius.circular(12),
                                          ).subtract(
                                            const BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                            ),
                                          ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    messages[index].senderID == widget.userID
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messages[index].senderID != widget.userID
                                        ? '${messages[index].firstName.capitalize()} ${messages[index].lastName.capitalize()}\n${messages[index].message}\n${messages[index].createdAt.toLocal().toString()}'
                                        : '${messages[index].message}\n${messages[index].createdAt.toLocal().toString()}',
                                    style: TextStyle(
                                      color: messages[index].senderID ==
                                              widget.userID
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: messages[index].senderID ==
                                            widget.userID
                                        ? TextAlign.end
                                        : TextAlign.start,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      hintText: 'Type your message here',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0),
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onChanged: (value) => setState(() {
                      messageText = value;
                    }),
                  ),
                ),
                GestureDetector(
                  onTap: messageText.trim().isEmpty ? null : _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
