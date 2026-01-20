import 'package:flutter_riverpod/legacy.dart';
import 'package:task_manager_app/notifier/task_notifier.dart';
import 'package:task_manager_app/services/task_service.dart';
import 'package:task_manager_app/state/task_state.dart';

final taskProvider = StateNotifierProvider<TaskNotifier,TaskState>((ref)
{
return TaskNotifier(TaskService());
});