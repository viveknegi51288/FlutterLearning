import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/screens/task_list_screen.dart';

void main() {
  runApp(
    
      const ProviderScope(
      child: MyApp(),
    ),
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