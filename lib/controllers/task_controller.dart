import 'package:get/get.dart';
import 'package:task_managemant_app/db/db_helper.dart';
import 'package:task_managemant_app/models/task.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  var taskList=<TaskModel>[].obs;

  Future<int> addTask({TaskModel? taskModel}) async {
    return await DBHelper.insert(taskModel);
  }

  void getTask() async{
    List<Map<String, dynamic>> tasks = await DBHelper.query();
   // taskList.assignAll(tasks.map((data) => new TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel taskModel){
   var val=  DBHelper.delete(taskModel);
   getTask();
   print(val);
  }

  void markTaskCompleted(int id) async{
    await  DBHelper.update(id);
    getTask();
  }

}