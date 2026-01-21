import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/providers/task_provider.dart';

class TaskListScreen extends ConsumerWidget{
  const TaskListScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskProvider);
    final notifier = ref.read(taskProvider.notifier);
  if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

return Scaffold(
  appBar: AppBar(title: Text('River pod example')),
  body: NotificationListener<ScrollNotification>(
    onNotification: (scroll){
if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
            notifier.loadMoreTasks();
          }
          return false;
    },
    child: ListView.builder(
itemCount: state.tasks.length +(state.isFetchingMore ? 1: 0),
itemBuilder: (context,index){
if (index == state.tasks.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final task = state.tasks[index];
            return Dismissible(
              key: Key(task.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => notifier.deleteTask(index),
              child: CheckboxListTile(
                title: Text(task.title),
                value: task.isCompleted,
                onChanged: (_) => notifier.toggleTask(index),
              )

    );
  }
  ),
));
}

  }

