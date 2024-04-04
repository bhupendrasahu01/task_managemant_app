import 'package:flutter/material.dart';

import '../theme.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    color: grayClr,
                    blurRadius: 20.0,
                  ),
                ]),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 26,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Search",
                      labelStyle: subDashboardTextStyle,
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: greenClr,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child:   Image.asset("images/settings.png",scale: 20,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
