import 'package:task_manager_app/models/task.dart';

class TaskState {


  final List<Task> tasks;
  final bool isLoading;
  final bool isFetchingMore;
  final bool hasMore;
  final String? error;



TaskState({required this.tasks, required this.isLoading, required this.isFetchingMore, required this.hasMore, required this.error});

factory TaskState.initial(){
return TaskState(tasks: [], isLoading: false, isFetchingMore: false, hasMore: true, error: null);
}

TaskState copyWith({


  List<Task>? tasks,
    bool? isLoading,
    bool? isFetchingMore,
    bool? hasMore,
    String? error,
}){
  return TaskState(
    tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error);
}






}