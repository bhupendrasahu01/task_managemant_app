import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class DateTimeView extends StatelessWidget {
  const DateTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20,bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today",
              style: todayTextStyle,
            ),
            Row(
              children: [
                Icon(Icons.calendar_month_outlined,color: Colors.grey,),
                _addTaskBar(),
                // Text(
                //   "Explor cat",
                //   style: dateTimeTextStyle,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: dateTimeTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
