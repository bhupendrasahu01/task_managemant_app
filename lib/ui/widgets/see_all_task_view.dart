import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_managemant_app/ui/widgets/search_text_field.dart';
import 'package:task_managemant_app/ui/widgets/task_tile.dart';

import '../../controllers/task_controller.dart';
import '../../controllers/task_firebase_controller.dart';
import '../../models/task.dart';
import '../add_task_bar.dart';
import '../theme.dart';

class SeeAllTasks extends StatefulWidget {
  @override
  State<SeeAllTasks> createState() => _SeeAllTasksState();
}

class _SeeAllTasksState extends State<SeeAllTasks> {
  late Stream<QuerySnapshot> _stream;
  DateTime _selectedDate = DateTime.now();
  final _taskFirebaseController = Get.put(TaskFirebaseController());
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = FirebaseFirestore.instance.collection("tasks").snapshots();
    setState(() {
      print("home page");
      // _taskController.getTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _taskControllerFirebaseO = Get.put(TaskFirebaseController());
    return Scaffold(
      backgroundColor: backgroudClr,
      //appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.only(top: 65),
        child: Column(
          children: [
            _appBarHomeFirebase(),
            _addTaskBar(),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: SearchTextField(onChange: _taskFirebaseController.onSearchTextChanged,)),
            _showFilterTask()
           // _showTasksFirebase()
          ],
        ),
      ),
    );
  }

  _appBarHomeFirebase() {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  //  _taskController.getTask();
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: 0, top: 20, bottom: 20, left: 20),
                  padding:
                      EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(width: 2, color: Colors.grey.shade300)),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    // color: Colors.green,
                  ),
                ),
              ),
              Text("All Tasks", style: DashboardTextStyle),
              GestureDetector(
                onTap: () async {
                  await Get.to(AddTaskPage());
                  //_taskController.getTask();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                  padding:
                      EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(width: 2, color: Colors.grey.shade300)),
                  child: Icon(
                    Icons.add,
                    color: greenClr,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Text("No data available");
        }
      },
    );
  }
_showFilterTask(){

    return Expanded(child: Obx((){
      if(_taskFirebaseController.tasks.isEmpty){
        return Center(child: Text("No Task"),);
      }else{
        return ListView.builder(
            itemCount: _taskFirebaseController.filteredTasks.length,
            itemBuilder: (context, index) {
              final tasks= _taskFirebaseController.filteredTasks[index];
              //TaskModel taskModel = tasks[index];
            //  print("This ixs task date${taskModel.date}");
              print(
                  "Thia ia lisddddddddddddddt ${DateFormat.yMd().format(_selectedDate)}");

                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, tasks);

                              print("Taped");
                            },
                            child: TaskTile(tasks),
                          )
                        ],
                      ),
                    ),
                  ),
                );

            });
      }
    }));
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
                    itemCount: snapshort.data!.docs.length,
                    itemBuilder: (context, index) {
                      TaskModel taskModel = tasks[index];
                      print("This ixs task date${taskModel.date}");
                      print(
                          "Thia ia lisddddddddddddddt ${DateFormat.yMd().format(_selectedDate)}");
                      if (snapshort.hasData) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showBottomSheet(context, taskModel);
                                      print("Taped");
                                    },
                                    child: TaskTile(taskModel),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
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
                // Text(
                //   DateFormat.yMMMd().format(DateTime.now()),
                //   style: subHeadingStyle,
                // ),
                // Text(
                //   "Today",
                //   style: headingStyle,
                // )
                // MyButton(
                //     label: "+ Add Task",
                //     onTap: () async {
                //       await Get.to(AddTaskPage());
                //       _taskController.getTask();
                //     }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_showBottomSheet(BuildContext context, TaskModel taskModel) async {
  final TaskFirebaseController _taskControllerFirebase =
      Get.put(TaskFirebaseController());
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
                    _taskControllerFirebase.updateTaskComplete(taskModel.id!);
                    // _taskController.markTaskCompleted(taskModel.id!);
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context),
          _bottomSheetButton(
              lable: "Delete Task",
              onTap: () {
                print("taskModel.id!");
                print(taskModel.id!);
                _taskControllerFirebase.deleteTask(taskModel.id!);
                // _taskControllerFirebase._deleteTask(taskModel.id!);
                //   _taskController.delete(taskModel);
                // _taskController.getTask();
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
