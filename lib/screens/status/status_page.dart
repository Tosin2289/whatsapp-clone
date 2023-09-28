import 'package:flutter/material.dart';

import '../../models/statusmodel.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, color: Colors.grey, size: 30),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          title: const Text(
            "My Status",
          ),
          subtitle: Text(
            status[0].time,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Recent Updates",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: status.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[600],
                  backgroundImage: AssetImage(status[index].image),
                ),
                title: Text(
                  status[index].name,
                ),
                subtitle: Text(
                  status[index].time,
                ),
              ),
            );
          },
        ))
      ],
    ));
  }
}
