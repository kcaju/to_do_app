import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_do_app/utils/color_constants.dart';

class TaskDetailingScreen extends StatelessWidget {
  const TaskDetailingScreen(
      {super.key,
      required this.title,
      required this.des,
      required this.date,
      required this.time});
  final String title, des, date, time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue3,
      appBar: AppBar(
        backgroundColor: ColorConstants.blue3,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorConstants.mainwhite,
            )),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.library_books,
              color: ColorConstants.mainwhite,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "To-do",
              style: TextStyle(color: ColorConstants.mainwhite, fontSize: 25),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: ColorConstants.blue1,
            borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: ColorConstants.mainwhite),
              ),
              Text(
                des,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorConstants.mainwhite),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: ColorConstants.mainwhite,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      //share text
                      Share.share('${title} \n ${des} \n ${date} \n ${time}');
                    },
                    icon: Icon(
                      Icons.share,
                      color: ColorConstants.mainwhite,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
