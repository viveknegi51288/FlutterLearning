import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/task_service.dart';

class TaskViewModel extends ChangeNotifier{

final TaskService _taskService = TaskService();
List<Task> _tasks=[];

bool _isLoading = false;
int _page = 1;
  final int _limit = 10;
  bool hasMore = true;
String? _error;
  bool isFetchingMore = false;


List<Task> get tasks => _tasks;
bool get isLoading => _isLoading;
String? get error => _error;

Future<void> loadInitialTask() async
{
    _isLoading = true;
    notifyListeners();
    try{
_page = 1;
final result = await _taskService.fetchTasks(page: _page, limit: _limit);
_tasks = result;
hasMore = result.length == _limit;

    }
    catch(e)
    {
_error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
}

Future<void> loadMoreTasks() async
{
  if(isFetchingMore || !hasMore) return;

  isFetchingMore = true;
  notifyListeners();

  try{
    _page ++;
    final result = await _taskService.fetchTasks(page: _page, limit: _limit);
    _tasks.addAll(result);
    hasMore = result.length == _limit;


  }
  catch(e)
  {
 _error = e.toString();
  }

  isFetchingMore = false;
  notifyListeners();

}





// Future<void> loadTasks() async {
//   _isLoading = true;
//   notifyListeners();

//   try{
//  _tasks = await _taskService.fetchTasks();
//  _error = null;

//   }
//   catch(e)
//   {
//  _error ="Failed to load tasks";
//   }
//   _isLoading = false;
//   notifyListeners();
// }

void toggleTask(int index){
  _tasks[index].isCompleted = !_tasks[index].isCompleted;
  notifyListeners();
}


Future<void> createTask(String title) async
{
  try{
 final newTask = await _taskService.addTask(title);
 _tasks.insert(0, newTask);
 notifyListeners();
  }
  catch(ex)
  {
    _error = "Failed to create task";
    notifyListeners();
  }
}


Future<void> deleteTask(int id) async{
  try{
    await _taskService.deleteTask(id);
    _tasks.removeWhere((task)=> task.id == id);
    notifyListeners();
  }
  catch (e) {
    _error = "Failed to delete task";
    notifyListeners();
  }
} 


}