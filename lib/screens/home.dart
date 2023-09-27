import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/screens/calls/calls_page.dart';
import '../providers/providers.dart';
import 'camera/camera_page.dart';
import 'chats/list_chat_screens.dart';
import 'chats/select_person_to_chatpage.dart';
import 'status/status_page.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(text: "CHATS"),
            Tab(text: "STATUS"),
            Tab(text: "CALLS"),
          ],
        ),
        actions: <Widget>[
          const Icon(Icons.search),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // sign out popup
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Sign out?"),
                  actions: [
                    ElevatedButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: const Text("Sign out"),
                      onPressed: () async {
                        await ref
                            .read(firebaseAuthProvider)
                            .signOut()
                            .then((value) => Navigator.pop(context));
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          CameraPage(),
          ListChatScreen(), // Todo, change to list of chats
          StatusPage(),
          CallsPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff25D366),
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SelectPersonToChat();
        })),
      ),
    );
  }
}

// TODO: to implement
class OtherTab extends StatelessWidget {
  final String tabName;
  const OtherTab({required this.tabName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(tabName),
    );
  }
}
