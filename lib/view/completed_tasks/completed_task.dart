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
  // List<dynamic> completedTasks = [];
  final noteBox = Hive.box(AppSessions.NOTEBOX);
  @override
  void initState() {
    // _loadCompletedTasks();
    super.initState();
  }

  // void _loadCompletedTasks() {
  //   setState(() {
  //     completedTasks = noteBox.values
  //         .where((task) => task['status'] == 'Completed')
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue3,
      appBar: AppBar(
        backgroundColor: ColorConstants.blue1,
        title: Text(
          "Tasks Overview",
          style: TextStyle(
              color: ColorConstants.mainwhite,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Image.asset(ImageConstants.claps),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(color: ColorConstants.blue1),
            child: Column(
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
                  style:
                      TextStyle(color: ColorConstants.mainwhite, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),

      //  ValueListenableBuilder(
      //   valueListenable: noteBox.listenable(),
      //   builder: (context, value, child) {
      //     final completedTasks = value.values
      //         .where((task) => task['status'] == 'Completed')
      //         .toList();
      //     print('Completed tasks: $completedTasks');
      //     return Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      //       child: completedTasks.isEmpty
      //           ? Center(
      //               child: Text("No completed tasks yet!",
      //                   style: TextStyle(
      //                       color: ColorConstants.mainwhite, fontSize: 18)))
      //           : ListView.separated(
      //               itemBuilder: (context, index) {
      //                 var task = completedTasks[index];
      //                 return TaskCard(
      //                     isCheck: false,
      //                     isCompleted: true,
      //                     title: task['title'],
      //                     date: task['date'],
      //                     des: task['desc']);
      //               },
      //               separatorBuilder: (context, index) => SizedBox(
      //                     height: 10,
      //                   ),
      //               itemCount: completedTasks.length),
      //     );
      //   },
      // ),
    );
  }
}
