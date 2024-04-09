import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_managemant_app/models/task.dart';

class TaskFirebaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference tasksRef = FirebaseFirestore.instance.collection('tasks');

  final searchText = ''.obs;
  final tasks = <TaskModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> addTaskFirebase(Map<String, dynamic> taskData, String id) async {
    try {
      await _firestore.collection('tasks').doc(id).set(taskData);
      fetchTasks();
      print('Task added successfully');
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId.toString()).delete();
      fetchTasks();

      // Task deleted successfully
    } catch (e) {
      // Error deleting task
      print('Error deleting task: $e');
    }
  }

  Future<void> updateTaskComplete(String taskId) async {
    try {
      // Fetch the document reference
      DocumentReference docRef =
     _firestore.collection('tasks').doc(taskId);

      // Update the document
      await docRef.update({'isCompleted': 1});
      fetchTasks();
      print('Task marked as complete successfully');
    } catch (e) {
      print('Error marking task as complete: $e');
    }
  }

  void fetchTasks() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();
      tasks.assignAll(querySnapshot.docs.map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  // void fetchTasks() async {
  //   try {
  //     final querySnapshot = await tasksRef.get();
  //     tasks.assignAll(querySnapshot.docs.map((doc) => TaskModel(title: doc['title'], note: doc['note'])).toList());
  //   } catch (e) {
  //     print('Error fetching tasks: $e');
  //   }
  // }

  List<TaskModel> get filteredTasks {
    if (searchText.isEmpty) {
      return tasks;
    } else {
      return tasks.where((task) => task.title!.toLowerCase().contains(searchText.value.toLowerCase())).toList();
    }
  }
  void onSearchTextChanged(String value) {
    searchText.value = value;
  }
}
