import 'package:cuidapet/app/module/schedule/schedule_view_model.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
final ScheduleViewModel schedule;

  const SchedulePage({super.key, required this.schedule});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule PAge'),),
    );
  }
}