import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/viewmodels/task_view_model.dart';

class TaskListScreen extends StatelessWidget{
  const TaskListScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    

    final TextEditingController controller = TextEditingController();

   final vm = context.watch<TaskViewModel>();

   return Scaffold(
    appBar: AppBar(title: const Text('My Tasks')),
    floatingActionButton: FloatingActionButton(onPressed: (){

showDialog(context: context, builder: (context){

return AlertDialog(
title: Text('Would you like to add new task?'),
content:TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Enter task title',
        ),
      ), 
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('Ok')),
        ElevatedButton(
          onPressed: () {
            final title = controller.text.trim();
            if (title.isNotEmpty) {
              context.read<TaskViewModel>().createTask(title);
            }
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
         
      ],
);

});
      vm.createTask("New Task");
    },
    child: const Icon(Icons.add),
    
    ),
    body: Builder(builder: (_)
    {
      if(vm.isLoading)
      {
        return Center(child: CircularProgressIndicator());
      }
      if(vm.error != null)
      {
        return Center(child: Text(vm.error!));
      }

return NotificationListener<ScrollNotification>(
  onNotification: (scrollInfo){
    if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            vm.loadMoreTasks();
          }
          return false;
  },
  child: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(itemCount: vm.tasks.length,
  itemBuilder: (context, index){

    final task = vm.tasks[index];
    return Dismissible(
       background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
      vm.deleteTask(task.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Deleted")));
      },
      key: Key(vm.tasks[index].title),
      child: CheckboxListTile(
        title: Text(task.title),
        value: task.isCompleted, onChanged: (_) => vm.toggleTask(index)),
    );

  },
  
  ));
    }),

   );
  }

}

