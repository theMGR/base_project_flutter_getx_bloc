import 'package:flutter/material.dart';
import 'package:project/core/locale_utils/locale_provider.dart';
import 'package:project/data/local/repository/notification_local_repository.dart';
import 'package:project/data/remote/model/notification_local_dto.dart';

class Red extends StatelessWidget {
  const Red({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;
    NotificationLocalDTO? notificationLocalDTO;
    if (arguments != null) {
      notificationLocalDTO = arguments as NotificationLocalDTO?;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Red")),
      body: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Column(
          children: [
            // TODO
            // Text("${getString(context)?.language}", style: TextStyle(color: Colors.white, fontSize: 50)),
            notificationLocalDTO != null
                ? Column(
                    children: [
                      Text("${notificationLocalDTO.notificationId}", style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text("${notificationLocalDTO.value1}", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class Green extends StatelessWidget {
  const Green({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;
    NotificationLocalDTO? notificationLocalDTO;
    if (arguments != null) {
      notificationLocalDTO = arguments as NotificationLocalDTO?;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Green")),
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: Column(
          children: [
           // TODO
            // Text("${getString(context)?.language}", style: TextStyle(color: Colors.white, fontSize: 50)),
            notificationLocalDTO != null
                ? Column(
              children: [
                Text("${notificationLocalDTO.notificationId}", style: TextStyle(color: Colors.white, fontSize: 10)),
                Text("${notificationLocalDTO.value1}", style: TextStyle(color: Colors.white, fontSize: 10)),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  _NotificationTestState createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  NotificationLocalRepository? notificationLocalRepository = NotificationLocalRepositoryImpl();
  List<NotificationLocalDTO?>? listNotificationLocal = [];
  List<Widget> listWidgets = [];

  @override
  void initState() async {
    super.initState();

    listNotificationLocal = await notificationLocalRepository?.getNotificationLocalList();

    if (listNotificationLocal != null) {
      for (int i = 0; i < listNotificationLocal!.length; i++) {
        if (listNotificationLocal![i] != null) {
          Column column = Column(children: [
            Text("${listNotificationLocal![i]?.notificationId}", style: TextStyle(color: Colors.white, fontSize: 10)),
            Text("${listNotificationLocal![i]?.value1}", style: TextStyle(color: Colors.white, fontSize: 10)),
          ]);

          listWidgets.add(column);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Notification Test")),
      body: Container(
        color: Colors.deepPurpleAccent,
        alignment: Alignment.center,
        child: Column(
          children: [
            // TODO
            // Text("${getString(context)?.language}", style: TextStyle(color: Colors.white, fontSize: 50)),
            listWidgets.isNotEmpty
                ? Column(
                    children: listWidgets,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
