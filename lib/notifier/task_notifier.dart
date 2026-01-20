import 'package:flutter_riverpod/legacy.dart';
import 'package:task_manager_app/services/task_service.dart';
import 'package:task_manager_app/state/task_state.dart';

class TaskNotifier  extends StateNotifier<TaskState>

{

  final TaskService _api;

  int _page = 1;
  final int _limit = 10;
  TaskNotifier(this._api) : super(TaskState.initial()){
  loadInitialTasks();
  }


  Future<void> loadInitialTasks() async
  {
    state = state.copyWith(isLoading: true);
try{
  _page = 1;
  final tasks = await _api.fetchTasks(page: _page, limit: _limit);
  state = state.copyWith(tasks: tasks, isLoading: false, hasMore: tasks.length == _limit , error: null);
}
catch(e)
{
   state = state.copyWith(error: e.toString());
}
state = state.copyWith(isLoading: false);

  }



   Future<void> loadMoreTasks() async {

    if(state.isFetchingMore || !state.hasMore) return;

    state = state.copyWith(isFetchingMore:  true);

    try{
      _page++;
      final tasks = await _api.fetchTasks(page: _page, limit: _limit);
      state = state.copyWith(
        tasks: [...state.tasks, ...tasks],
         hasMore: tasks.length == _limit);
    }
    catch(e){
      state = state.copyWith(error: e.toString());
    }

   }

   Future<void> toggleTask(int index) async
   {
    final task = state.tasks[index];
    task.isCompleted = !task.isCompleted;
     state = state.copyWith(tasks: [...state.tasks]);
   }

   Future<void> deleteTask(int index) async{
    final removedItem = state.tasks[index];
    state = state.copyWith(tasks: [...state.tasks]..removeAt(index));

try{
await _api.deleteTask(removedItem.id);

}
catch(e){
  state = state.copyWith(error: e.toString());
  state = state.copyWith(tasks: [...state.tasks]..insert(index, removedItem));
}
   }


}