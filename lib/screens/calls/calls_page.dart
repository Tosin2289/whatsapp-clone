import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/screens/calls/video_call.dart';

import '../../models/chat.dart';
import '../../providers/providers.dart';

class CallsPage extends ConsumerStatefulWidget {
  const CallsPage({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallsPageState();
}

class _CallsPageState extends ConsumerState<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<Chat?>>(
      stream: ref.read(databaseProvider)!.getChats(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong!"),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chats = snapshot.data ?? [];
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index]; // type Chat
            final myUser =
                ref.read(firebaseAuthProvider).currentUser!; // type User
            if (chat == null) {
              return Container();
            }
            return Column(
              children: [
                ListTile(
                  title: Text(
                      myUser.uid == chat.myUid ? chat.otherName : chat.myName),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VideoCall(
                              remoteUid: chat.otherUid, inCommingcall: false);
                        }));
                      },
                      icon: Icon(
                        Icons.video_call,
                        color: Colors.green.shade700,
                      )),
                ),
              ],
            );
          },
        );
      },
    ));
  }
}
