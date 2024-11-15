import 'package:flutter/material.dart';

class timePicker extends StatefulWidget {
  const timePicker({super.key});

  @override
  State<timePicker> createState() => _timePickerState();
}

class _timePickerState extends State<timePicker> {

  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 5,
            icon: const Icon(
              Icons.alarm,
              size: 30,
            ),
            onPressed: () {
              selectTime(context);
            },
          ),
        ],
      ), // Column
    );
  }
}
