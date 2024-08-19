import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_do_app/utils/app_sessions.dart';
import 'package:to_do_app/utils/color_constants.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.date,
    required this.des,
    this.onDelete,
    this.onEdit,
    this.isCompleted = false,
    this.onCheckboxChanged,
    required this.time,
    this.isImportant = false,
  });
  final String title, date, des, time;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final bool isCompleted;
  final bool isImportant;

  final void Function(bool?)? onCheckboxChanged;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  var noteBox = Hive.box(AppSessions.NOTEBOX);
  List noteKeys = [];
  bool onChecked = false;
  @override
  void initState() {
    super.initState();
    onChecked = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.title),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.onDelete?.call();
        setState(() {});
      },
      background: Container(
        color: ColorConstants.mainwhite,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete,
              color: ColorConstants.red,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.blue1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: ColorConstants.mainblack,
                  fillColor: WidgetStatePropertyAll(ColorConstants.mainwhite),
                  value: onChecked,
                  onChanged: (value) {
                    setState(() {
                      onChecked = value!;
                    });
                    widget.onCheckboxChanged?.call(value);
                  },
                ),
                widget.isImportant
                    ? Icon(
                        Icons.star,
                        color: ColorConstants.amber,
                      )
                    : Text(""),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: ColorConstants.mainwhite),
                ),
                Spacer(),
                TextButton(
                    onPressed: widget.onEdit,
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: ColorConstants.mainwhite, fontSize: 16),
                    )),
                IconButton(
                  onPressed: widget.onDelete,
                  icon: Icon(
                    Icons.delete,
                    color: ColorConstants.mainwhite,
                  ),
                ),
              ],
            ),
            Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              widget.des,
              style: TextStyle(color: ColorConstants.mainwhite),
            ),
            Divider(
              color: ColorConstants.mainwhite,
            ),
            Row(
              children: [
                Text(
                  widget.date,
                  style:
                      TextStyle(color: ColorConstants.mainwhite, fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.time,
                  style:
                      TextStyle(color: ColorConstants.mainwhite, fontSize: 18),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    //share text
                    Share.share(
                        '${widget.title} \n ${widget.des} \n ${widget.date} \n ${widget.time}');
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
    );
  }
}
