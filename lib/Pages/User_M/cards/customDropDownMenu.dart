import 'package:flutter/material.dart';

class customDropdownMenu extends StatefulWidget {
  final String defaultValue;
  final List<String> listData;
  final ValueChanged<String> onChanged;

  const customDropdownMenu({
    super.key,
    required this.defaultValue,
    required this.listData,
    required this.onChanged,
  });

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
      menuMaxHeight: 300,
      // menuWidth: 150,
      autofocus: true,
      value: _selectedValue,
      items: widget.listData.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child:  Text(textAlign: TextAlign.center,
                value,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal,),
              ),
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
