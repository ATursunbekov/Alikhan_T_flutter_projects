import 'dart:convert';

class Task {
  final String name;
  bool isDone;
  bool checkCoins;

  Task({required this.name, this.isDone = false, this.checkCoins = true});

  void toggleDone() {
    isDone = !isDone;
  }
  void getCoin() {
    checkCoins = false;
  }

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      name: jsonData['name'],
      isDone: jsonData['isDone'],
      checkCoins: jsonData['checkCoins'],
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
    'name': task.name,
    'isDone': task.isDone,
    'checkCoins': task.checkCoins,
  };

  static String encode(List<Task> task) => json.encode(
    task
        .map<Map<String, dynamic>>((task) => Task.toMap(task))
        .toList(),
  );

  static List<Task> decode(String task) =>
      (json.decode(task) as List<dynamic>)
          .map<Task>((item) => Task.fromJson(item))
          .toList();
}