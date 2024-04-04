import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_managemant_app/models/task.dart';

import '../theme.dart';

class MyDashboardTaskList extends StatelessWidget {
  final TaskModel? task;

  MyDashboardTaskList(this.task);

  @override
  Widget build(BuildContext context) {
    String inputDateString = "${task!.date}";
    DateTime inputDate = DateFormat('M/d/yyyy').parse(inputDateString);
    String formattedDate = DateFormat('d MMM yyyy').format(inputDate);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.6,
        margin: EdgeInsets.only(bottom: 0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 5),
          //  width: SizeConfig.screenWidth * 0.78,
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
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.star,
                        color: _getBGClr(task?.color ?? 0),
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: ),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: Text(task?.repeat ?? "",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )),
                      ),
                    ],
                  ),
                  Text(
                    task?.title ?? "",
                    style: GoogleFonts.lato(textStyle: titleTextStyle),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[500]),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey[500],
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${task!.startTime} - ${task!.endTime}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    task?.note ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 15,
                        //color: Colors.grey[100]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: task!.isCompleted == 1 ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
