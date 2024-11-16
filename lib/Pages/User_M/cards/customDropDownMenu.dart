import 'package:flutter/material.dart';

class customDropdownMenu extends StatefulWidget {
  final String defaultValue;
  final List<String> listData;
  final ValueChanged<String> onChanged;

  const customDropdownMenu({
    Key? key,
    required this.defaultValue,
    required this.listData,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<customDropdownMenu> createState() => _customDropdownMenuState();
}

class _customDropdownMenuState extends State<customDropdownMenu> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedValue,
      items: widget.listData.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue!;
        });
        widget.onChanged(newValue!); // Call the callback function
      },
    );
  }
}