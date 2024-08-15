import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/utils/app_sessions.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/utils/image_constants.dart';
// import 'package:to_do_app/view/home_screen/widget/task_card.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key, required this.checkCount});
  final int checkCount;

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  bool isCompleted = false;

  final noteBox = Hive.box(AppSessions.NOTEBOX);

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
        title: Text(
          "Tasks Overview",
          style: TextStyle(
              color: ColorConstants.mainwhite,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            widget.checkCount == 0
                ? Image.asset(
                    ImageConstants.notask,
                  )
                : Image.asset(
                    ImageConstants.claps,
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
                  widget.checkCount != 0
                      ? Text(
                          '${widget.checkCount}',
                          style: TextStyle(
                              color: ColorConstants.mainwhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        )
                      : Image.asset(
                          ImageConstants.thumb,
                          height: 60,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  widget.checkCount != 0
                      ? Text(
                          "Completed Tasks",
                          style: TextStyle(
                              color: ColorConstants.mainwhite, fontSize: 20),
                        )
                      : Text(
                          "Complete your Tasks",
                          style: TextStyle(
                              color: ColorConstants.mainwhite, fontSize: 20),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
