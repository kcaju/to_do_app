import 'dart:io';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/utils/app_sessions.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/utils/image_constants.dart';
import 'package:to_do_app/view/completed_tasks/completed_task.dart';
import 'package:to_do_app/view/home_screen/widget/task_card.dart';
import 'package:to_do_app/view/login_screen/login_screen.dart';
import 'package:to_do_app/view/task_detailing_screen/task_detailing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> dates = [
    "On Going",
    "Completed",
  ];
  String? dropValue;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  DatePickerController datepick = DatePickerController();
  var noteBox = Hive.box(AppSessions.NOTEBOX);
  List noteKeys = [];
  XFile? selectedImageFile;
  int checkCount = 0;
  bool onChecked = false;
  bool important = false;

  @override
  void initState() {
    noteKeys = noteBox.keys.toList();
    _updateCheckCount();
    setState(() {});
    super.initState();
  }

  void _updateCheckCount() {
    setState(() {
      checkCount = noteBox.values
          .where((task) => task['status'] == 'Completed')
          .toList()
          .length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          height: 50,
          width: 380,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: FloatingActionButton(
            backgroundColor: ColorConstants.blue1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add new task",
                  style:
                      TextStyle(color: ColorConstants.mainwhite, fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.add,
                  color: ColorConstants.mainwhite,
                )
              ],
            ),
            onPressed: () {
              title.clear();
              date.clear();
              description.clear();
              time.clear();
              important = false;
              _customBottomSheet(context);
            },
          ),
        ),
        backgroundColor: ColorConstants.blue3,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.grid_view,
                    color: ColorConstants.mainwhite,
                  ));
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.task_alt_outlined,
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
          actions: [
            Icon(
              Icons.search,
              color: ColorConstants.mainwhite,
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: ColorConstants.lightblue,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Text(
                        "H E L L O",
                        style: TextStyle(
                            color: ColorConstants.mainwhite, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            selectedImageFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {});
                            if (selectedImageFile != null) {
                              print(selectedImageFile!.path);
                            }
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            child: selectedImageFile != null
                                ? Image.file(File(selectedImageFile!.path))
                                : Image.asset(ImageConstants.profile),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: ColorConstants.mainwhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: Text(
                    "Home",
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.share,
                    color: ColorConstants.mainwhite,
                  ),
                  title: Text(
                    "Tell Friends",
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: ColorConstants.mainwhite,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 20),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new_rounded,
                    color: ColorConstants.mainwhite,
                  ),
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear(); // Clears all keys
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  title: Text(
                    "LogOut",
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Divider(
                color: ColorConstants.mainwhite,
              ),
              SizedBox(
                  height: 100,
                  child: DatePicker(
                      onDateChange: (selectedDate) {},
                      monthTextStyle:
                          TextStyle(color: ColorConstants.mainwhite),
                      dateTextStyle: TextStyle(color: ColorConstants.mainwhite),
                      dayTextStyle: TextStyle(color: ColorConstants.mainwhite),
                      selectionColor: ColorConstants.mainblack,
                      initialSelectedDate: DateTime.now(),
                      selectedTextColor: ColorConstants.mainwhite,
                      DateTime.now())),
              Divider(
                color: ColorConstants.mainwhite,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Your Tasks",
                    style: TextStyle(
                        color: ColorConstants.mainwhite, fontSize: 18),
                  ),
                  SizedBox(
                    width: 19,
                  ),
                  Spacer(),
                  Container(
                    color: ColorConstants.blue3,
                    child: DropdownButton(
                      onTap: () {},
                      dropdownColor: ColorConstants.blue1,
                      style: TextStyle(
                          color: ColorConstants.mainwhite, fontSize: 18),
                      hint: Text(
                        "On Going",
                        style: TextStyle(color: ColorConstants.mainwhite),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor: ColorConstants.mainwhite,
                      value: dropValue ?? dates[0],
                      items: List.generate(
                        dates.length,
                        (index) => DropdownMenuItem(
                            value: dates[index],
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu,
                                  color: ColorConstants.mainwhite,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(dates[index])
                              ],
                            )),
                      ),
                      onChanged: (value) {
                        setState(() {
                          dropValue = value!;
                        });
                        if (dropValue == "Completed") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CompletedTask(checkCount: checkCount),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var currentNote = noteBox.get(noteKeys[index]);
                      return Dismissible(
                        resizeDuration: Duration(seconds: 2),
                        key: Key(noteKeys[index].toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          noteBox.delete(noteKeys[index]);
                          noteKeys = noteBox.keys.toList();
                          _updateCheckCount();
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
                        secondaryBackground: Container(
                          color: ColorConstants.mainwhite,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              // child: Icon(
                              //   Icons.delete,
                              //   color: ColorConstants.red,
                              // ),
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailingScreen(
                                      title: currentNote['title'],
                                      des: currentNote['desc'],
                                      date: currentNote['date'],
                                      time: currentNote['time']),
                                ));
                          },
                          child: TaskCard(
                            isCompleted: currentNote['status'] == 'Completed',
                            onEdit: () {
                              title.text = currentNote['title'];
                              description.text = currentNote['desc'];
                              date.text = currentNote['date'];
                              time.text = currentNote['time'] ?? "";
                              important = currentNote['imp'];

                              _customBottomSheet(context,
                                  isEdit: true, itemIndex: index);
                            },
                            onDelete: () {
                              noteBox.delete(noteKeys[index]);
                              noteKeys = noteBox.keys.toList();
                              _updateCheckCount();
                              setState(() {});
                            },
                            onCheckboxChanged: (p0) {
                              setState(() {
                                if (p0!) {
                                  checkCount++;
                                } else {
                                  checkCount--;
                                }
                              });

                              var updatedNote = currentNote;
                              updatedNote['status'] =
                                  p0! ? 'Completed' : 'On Going';
                              noteBox.put(noteKeys[index], updatedNote);
                            },
                            title: currentNote['title'],
                            date: currentNote['date'],
                            des: currentNote['desc'],
                            time: currentNote['time'] ?? "",
                            isImportant: currentNote['imp'],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: noteKeys.length),
              )
            ],
          ),
        ),
      ),
    );
  }

  _customBottomSheet(BuildContext context,
          {bool isEdit = false, int? itemIndex}) =>
      showModalBottomSheet(
        backgroundColor: ColorConstants.blue3,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "New Task",
                    style: TextStyle(
                        color: ColorConstants.mainwhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: ColorConstants.mainwhite,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task Title",
                        style: TextStyle(
                            color: ColorConstants.mainwhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                          hintText: "Add a title..",
                          hintStyle: TextStyle(color: ColorConstants.grey),
                          fillColor: ColorConstants.mainwhite,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            color: ColorConstants.mainwhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: description,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Add a description..",
                          hintStyle: TextStyle(color: ColorConstants.grey),
                          fillColor: ColorConstants.mainwhite,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Important",
                            style: TextStyle(
                                color: ColorConstants.mainwhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => Checkbox(
                              checkColor: ColorConstants.mainblack,
                              fillColor: WidgetStatePropertyAll(
                                  ColorConstants.mainwhite),
                              value: important,
                              onChanged: (value) {
                                setState(() {
                                  important = value!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                            color: ColorConstants.mainwhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: date,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "dd/mm/yy",
                          hintStyle: TextStyle(color: ColorConstants.grey),
                          fillColor: ColorConstants.mainwhite,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: InkWell(
                            onTap: () async {
                              var selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              if (selectedDate != null) {
                                date.text = DateFormat("dd,MMMM,y")
                                    .format(selectedDate);
                              }
                            },
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorConstants.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Time",
                        style: TextStyle(
                            color: ColorConstants.mainwhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: time,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "hh:mm",
                          hintStyle: TextStyle(color: ColorConstants.grey),
                          fillColor: ColorConstants.mainwhite,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: InkWell(
                            onTap: () async {
                              var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (selectedTime != null) {
                                time.text = selectedTime.format(context);
                              }
                            },
                            child: Icon(
                              Icons.timer,
                              color: ColorConstants.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorConstants.mainwhite),
                          ),
                          decoration: BoxDecoration(
                              color: ColorConstants.blue1,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          isEdit
                              ? noteBox.put(noteKeys[itemIndex!], {
                                  "title": title.text,
                                  "date": date.text,
                                  "desc": description.text,
                                  "time": time.text,
                                  "imp": important,
                                })
                              : noteBox.add({
                                  // to add new note to hive storage
                                  "title": title.text,
                                  "date": date.text,
                                  "desc": description.text,
                                  "time": time.text,
                                  "imp": important,
                                });
                          noteKeys = noteBox.keys.toList();
                          // to update the keylist after adding a note
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text(
                            isEdit ? "Update" : "Create",
                            style: TextStyle(
                                color: ColorConstants.mainwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          decoration: BoxDecoration(
                              color: ColorConstants.blue1,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
