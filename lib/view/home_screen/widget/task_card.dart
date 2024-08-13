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
    this.isCheck = false,
    this.isCompleted = false,
    this.listIndex,
    this.onCheckboxChanged,
  });
  final String title, date, des;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final bool isCheck, isCompleted;
  final int? listIndex;
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
                widget.isCheck
                    ? Checkbox(
                        checkColor: ColorConstants.mainblack,
                        fillColor:
                            WidgetStatePropertyAll(ColorConstants.mainwhite),
                        value: onChecked,
                        onChanged: (value) {
                          setState(() {
                            onChecked = value!;
                          });
                          widget.onCheckboxChanged?.call(value);
                        },
                        //  (value) {
                        //   // print(
                        //   //     'TaskCard: title=${widget.title}, date=${widget.date}, desc=${widget.des}');
                        //   setState(() {
                        //     onChecked = value!;
                        //   });
                        //   if (noteKeys.isNotEmpty && widget.listIndex != null) {
                        //     var currentNote =
                        //         noteBox.get(noteKeys[widget.listIndex!]);
                        //     currentNote['status'] =
                        //         onChecked ? 'Completed' : 'On Going';
                        //     noteBox.put(
                        //         noteKeys[widget.listIndex!], currentNote);
                        //     setState(() {});
                        //   }
                        // },
                      )
                    : Icon(
                        Icons.task,
                        color: ColorConstants.mainwhite,
                      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date,
                  style:
                      TextStyle(color: ColorConstants.mainwhite, fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    //share text
                    Share.share(
                        '${widget.title} \n ${widget.des} \n ${widget.date}');
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
