import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/task_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/viewmodels/task_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel()..loadInitialTask(),
      child:const MyApp())
    );
    
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
title: 'Task Manager',
debugShowCheckedModeBanner: false,
theme: ThemeData(primarySwatch: Colors.blue),
home: const TaskListScreen(),

    );
  }

}