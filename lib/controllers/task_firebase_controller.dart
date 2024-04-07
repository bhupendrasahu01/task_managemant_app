import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskFirebaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTaskFirebase(Map<String, dynamic> taskData, String id) async {
    try {
      await _firestore.collection('tasks').doc(id).set(taskData);
      print('Task added successfully');
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId.toString()).delete();
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

      print('Task marked as complete successfully');
    } catch (e) {
      print('Error marking task as complete: $e');
    }
  }
}
