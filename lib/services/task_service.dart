
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import '../models/task.dart';
import 'package:http/http.dart' as http;

class TaskService {


final String baseURl = "https://jsonplaceholder.typicode.com/todos";

Future<List<Task>> fetchTasks({required int page,int limit = 10}) async
{
 final url = Uri.parse('$baseURl?_page=$page&limit=$limit');

final response = await http.get(url);

if(response.statusCode == 200)
{
  final List data = jsonDecode(response.body);
  return data.map((e) => Task.fromJson(e)).toList();
}
else{
  throw Exception("Failded to load tasks");
}

}


Future<Task> addTask(String title) async {

final response = await http.post(Uri.parse(baseURl), headers: {'ContentType': 'Application/json'},
body: jsonEncode( {'title':title, 'completed':  false}),
);

if(response.statusCode == 201)
{
   final data = jsonDecode(response.body);
    return Task(
      id: data['id'],        // from response
      title: title,          // from input
      isCompleted: false,    // known value
    );
}
else{
  throw Exception("Failed to add task");
}

}

Future<void> deleteTask(int id) async {
  final url = Uri.parse('$baseURl/$id');
  final response = await http.delete(url);
 if (response.statusCode != 200) {
    throw Exception("Failed to delete task");
  }
}







}