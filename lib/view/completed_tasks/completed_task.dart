import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/utils/app_sessions.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/utils/image_constants.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key, required this.checkCount});
  final int checkCount;

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  var completedNoteBox = Hive.box(AppSessions.COMPLETEBOX);

  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue3,
      appBar: AppBar(
        backgroundColor: ColorConstants.blue1,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorConstants.mainwhite,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.checklist,
              color: ColorConstants.mainwhite,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tasks Overview",
              style: TextStyle(color: ColorConstants.mainwhite, fontSize: 25),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            widget.checkCount != 0
                ? Image.asset(
                    ImageConstants.claps,
                  )
                : Image.asset(
                    ImageConstants.notask,
                  ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.blue1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.checkCount}',
                    style: TextStyle(
                        color: ColorConstants.mainwhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Completed Tasks",
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var completedTask = completedNoteBox.getAt(index);
                    return Card(
                      color: ColorConstants.blue1,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              completedTask['title'],
                              style: TextStyle(
                                  color: ColorConstants.mainwhite,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                completedTask['desc'],
                                style:
                                    TextStyle(color: ColorConstants.mainwhite)),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(completedTask['date'],
                                style: TextStyle(
                                    color: ColorConstants.mainwhite,
                                    fontSize: 18)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(completedTask['time'],
                                style: TextStyle(
                                    color: ColorConstants.mainwhite,
                                    fontSize: 18)),
                          ],
                        ),
                        trailing: CircleAvatar(
                            radius: 15,
                            backgroundColor: ColorConstants.mainwhite,
                            child: Icon(Icons.check_circle,
                                size: 30, color: ColorConstants.green1)),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: completedNoteBox.length),
            )
          ],
        ),
      ),
    );
  }
}
