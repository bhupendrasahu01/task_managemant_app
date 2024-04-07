import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowTaskFirebase extends StatefulWidget {
  const ShowTaskFirebase({super.key});

  @override
  State<ShowTaskFirebase> createState() => _ShowTaskFirebaseState();
}

class _ShowTaskFirebaseState extends State<ShowTaskFirebase> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:FirebaseFirestore.instance.collection("tasks").snapshots() ,
        builder: (context,snapshort){
          if(snapshort.connectionState==ConnectionState.active){
            if(snapshort.hasData){
              return ListView.builder(itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${index+1}"),
                  ),
                );
              });
            }else if(snapshort.hasError){
              return Center(child: Text("${snapshort.hasError.toString()}"),);
            }else{
              return Center(child: Text("${snapshort.hasError.toString()}"),);
            }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }
}
