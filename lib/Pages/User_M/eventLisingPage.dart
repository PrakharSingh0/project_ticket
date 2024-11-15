import 'package:flutter/material.dart';

class eventListingPage extends StatefulWidget {
  const eventListingPage({super.key});

  @override
  State<eventListingPage> createState() => _eventListingPageState();
}

Widget _buildInfoField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      // border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    ),
  );
}

class _eventListingPageState extends State<eventListingPage> {
  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _eventType = TextEditingController();
  final TextEditingController _eventDescription = TextEditingController();
  final TextEditingController _eventDate = TextEditingController();
  final TextEditingController _eventVanue = TextEditingController();
  final TextEditingController _eventMode = TextEditingController();
  final TextEditingController _eventSeatsAvailibility = TextEditingController();

  List<String> eventModeType = ["Online", "Offline"];
  String dropDownEventType = "Online";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("List Your Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          _buildInfoField("Event Name", _eventName),
          const SizedBox(
            height: 15,
          ),
          _buildInfoField("Event Type", _eventType),
          const SizedBox(
            height: 15,
          ),
          _buildInfoField("Event Description", _eventDescription),
          const SizedBox(
            height: 15,
          ),
          _buildInfoField("Event Date", _eventDate),
          const SizedBox(
            height: 15,
          ),
          _buildInfoField("Event Vanue", _eventVanue),
          const SizedBox(
            height: 15,
          ),
          _buildInfoField("Event Mode", _eventMode),
          const SizedBox(
            height: 15,
          ),
          _buildInfoField("Event Seats Availability", _eventSeatsAvailibility),
          DropdownButton(
            // Initial Value
            value: dropDownEventType,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: eventModeType.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropDownEventType = newValue!;
              });
            },
          ),
        ]),
      ),
    );
  }
}
