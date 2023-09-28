import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/camera/camera_page.dart';

class DialogComponet extends StatefulWidget {
  const DialogComponet({Key? key}) : super(key: key);

  @override
  State<DialogComponet> createState() => _DialogComponetState();
}

class _DialogComponetState extends State<DialogComponet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sdig();
  }

  sdig() async {
    await availableCameras()
        .then((value) => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CameraPage(
                  cameras: value,
                );
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
