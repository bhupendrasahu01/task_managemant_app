class TaskModel {
  String? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

 TaskModel({
   this.id,
   this.title,
   this.note,
   this.isCompleted,
   this.date,
   this.startTime,
   this.endTime,
   this.color,
   this.remind,
   this.repeat,
 });

 // Convert TaskModel to a Map (JSON-like format)
 Map<String, dynamic> toJson() {
  final Map<String,dynamic> data = new Map<String,dynamic>();
  data['id']= this.id;
  data['title']= this.title;
  data['note']= this.note;
  data['isCompleted']= this.isCompleted;
  data['date']= this.date;
  data['startTime']= this.startTime;
  data['endTime']= this.endTime;
  data['color']= this.color;
  data['remind']= this.remind;
  data['repeat']= this.repeat;
  return data;

 }



  TaskModel.fromJson(Map<String, dynamic> json) {
   id= json['id'];
   title =json['title'];
   note= json['note'];
   isCompleted= json['isCompleted'];
   date= json['date'];
   startTime=json['startTime'];
   endTime= json['endTime'];
   color= json['color'];
   remind= json['remind'];
   repeat= json['repeat'];
 }
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      isCompleted: map['isCompleted'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      color: map['color'],
      remind: map['remind'],
      repeat: map['repeat'],
    );
  }
}

