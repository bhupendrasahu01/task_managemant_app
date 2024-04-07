import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_managemant_app/ui/home_page.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../add_task_bar.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/dashboard_task_list.dart';
import '../widgets/date_time_view.dart';
import '../widgets/search_text_field.dart';
import '../widgets/task_tile.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late Stream<QuerySnapshot> _stream;
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  String _pendingTaskCount = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = FirebaseFirestore.instance.collection("tasks").snapshots();
    setState(() {
      print("home page");
      _taskController.getTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudClr,
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _appBarFirebase(),
            //_appBar(),
            SearchTextField(),
            DateTimeView(),
            Container(
              child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return _addTaskView();
                      } else {
                        return _showTasksFirebase();
                      }
                    } else {
                      return _showTasksFirebase();
                    }
                  }),
            ),
            //_showTasksDashboard(),
            _allTaskView(),
            _onGoingFirebase(),
            // _onGoing(),
          ],
        ),
      ),
    );
  }

  _addTaskView() {
    return GestureDetector(
      onTap: () async {
        await Get.to(AddTaskPage());
        setState(() {
          print("home page");
          //_taskController.getTask();
        });
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: grayClr,
                  blurRadius: 10.0,
                ),
              ]
              // color: _getBGClr(task?.color??0),
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   "images/settings_2.png",
                    //   scale: 20,
                    //   color: greenClr,
                    // ),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10, left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 2, color: Colors.grey.shade300)),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text("No Task Available", style: titleTextStyle),
                        Text("Let's make new one", style: subDashboardTextStyle)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _allTaskView() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Task",
              style: todayTextStyle,
            ),
            Text(
              "See All",
              style: seeAllTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _onGoing() {
    return GestureDetector(
      onTap: () async {
        await Get.to(HomePage());
        setState(() {
          print("home page");
          _taskController.getTask();
        });
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.2,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: grayClr,
                  blurRadius: 10.0,
                ),
              ]
              // color: _getBGClr(task?.color??0),
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  children: [
                    Image.asset(
                      "images/settings_2.png",
                      scale: 20,
                      color: greenClr,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ongoing", style: titleTextStyle),
                        Text(
                            "${_taskController.taskList.length.toString()} Tasks",
                            style: subDashboardTextStyle)
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }

  _onGoingFirebase() {
    return GestureDetector(
        onTap: () async {
          await Get.to(HomePage());
          setState(() {
            print("home page");
            _taskController.getTask();
          });
        },
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.2,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: grayClr,
                          blurRadius: 10.0,
                        ),
                      ]
                      // color: _getBGClr(task?.color??0),
                      ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              "images/settings_2.png",
                              scale: 20,
                              color: greenClr,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ongoing", style: titleTextStyle),
                                Text(
                                    "${snapshot.data!.docs.length.toString()} Tasks",
                                    style: subDashboardTextStyle)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              );
            } else {
              return Text("No data available");
            }
          },
        ));
  }

  _appBarFirebase() {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Jimmy", style: DashboardTextStyle),
                    Text(
                        "You have ${snapshot.data!.docs.length.toString()} task due Today",
                        style: subDashboardTextStyle),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                  padding:
                      EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(width: 2, color: Colors.grey.shade300)),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            );
          } else {
            return Text("no data available");
          }
        });
  }

  _appBar() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Jimmy", style: DashboardTextStyle),
            Text("You have ${_pendingTaskCount} task due Today",
                style: subDashboardTextStyle),
          ],
        ),
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.only(right: 20, top: 20, bottom: 20),
          padding: EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.grey.shade300)),
          child: Icon(
            Icons.notifications_none_rounded,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  _showTasksDashboard() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              TaskModel taskModel = _taskController.taskList[index];
              print(
                  "Thia ia list   ${_taskController.taskList.length.toString()}");

              // print("home page");
              // _taskController.getTask();

              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Get.to(HomePage());
                            // _showBottomSheet(context, taskModel);
                            print("New tapted");
                          },
                          child: MyDashboardTaskList(taskModel),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }

  _showTasksFirebase() {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("tasks").snapshots(),
          builder: (context, snapshort) {
            if (snapshort.connectionState == ConnectionState.active) {
              if (snapshort.hasData) {
                List<TaskModel> tasks =
                    snapshort.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return TaskModel.fromJson(data);
                }).toList();
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshort.data!.docs.length,
                    itemBuilder: (context, index) {
                      TaskModel taskModel = tasks[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    //_showBottomSheet(context, taskModel);
                                    print("Taped");
                                  },
                                  child: MyDashboardTaskList(taskModel),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshort.hasError) {
                return Center(
                  child: Text("${snapshort.hasError.toString()}"),
                );
              } else {
                return Center(
                  child: Text("${snapshort.hasError.toString()}"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _showBottomSheet(BuildContext context, TaskModel taskModel) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: taskModel.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
            ),
            Spacer(),
            taskModel.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    lable: "Task Completed",
                    onTap: () {
                      //    _taskController.markTaskCompleted(taskModel.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context),
            _bottomSheetButton(
                lable: "Delete Task",
                onTap: () {
                  _taskController.delete(taskModel);
                  _taskController.getTask();
                  Get.back();
                },
                clr: Colors.red!,
                context: context),
            SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
                lable: "Close",
                onTap: () {
                  Get.back();
                },
                clr: Colors.grey!,
                context: context,
                isClose: true),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton(
      {required String lable,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: isClose == true ? Colors.grey[300]! : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            lable,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTask();
              }),
        ],
      ),
    );
  }

  _appBarR() {
    return AppBar(
      elevation: 0,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: AssetImage("images/notification_icon.png"),
            backgroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}
