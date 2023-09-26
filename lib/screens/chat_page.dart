import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat.dart';
import '../models/message.dart';
import '../providers/providers.dart';

class ChatPage extends ConsumerStatefulWidget {
  final Chat chat;
  const ChatPage({required this.chat, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage>
    with SingleTickerProviderStateMixin {
  final _textMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myUid = ref.read(firebaseAuthProvider).currentUser!.uid;
    Widget sendMessageField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30, left: 4, right: 4),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(80)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          offset: const Offset(0.0, 0.50),
                          spreadRadius: 1,
                          blurRadius: 1),
                    ]),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.insert_emoticon,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 60,
                        ),
                        child: Scrollbar(
                          child: TextField(
                            maxLines: null,
                            style: const TextStyle(fontSize: 14),
                            controller: _textMessageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.link),
                        const SizedBox(
                          width: 10,
                        ),
                        _textMessageController.text.isEmpty
                            ? const Icon(Icons.camera_alt)
                            : const Text(""),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () async {
                if (_textMessageController.text.isNotEmpty) {
                  await ref.read(databaseProvider)!.sendMessage(
                      widget.chat.chatId,
                      Message(
                          text: _textMessageController.text,
                          myUid:
                              ref.read(firebaseAuthProvider).currentUser!.uid,
                          time: DateTime.now().toString()));
                  print("'message sent'");
                }
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.myUid == myUid
            ? widget.chat.otherName
            : widget.chat.myName),
        actions: const <Widget>[
          Icon(Icons.video_call),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
          Icon(Icons.call),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
          ),
          Icon(Icons.more_vert),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                "https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c949e91d20548b.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                sendMessageField(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
