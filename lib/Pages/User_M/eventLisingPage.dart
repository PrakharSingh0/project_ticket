import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_M/cards/customDropDownMenu.dart';
import 'package:project_ticket/Pages/User_M/cards/timePicker.dart';

import 'cards/datePicker.dart';

class eventListingPage extends StatefulWidget {
  const eventListingPage({super.key});

  @override
  State<eventListingPage> createState() => _eventListingPageState();
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
  String dropdownValue = "Online";

  Widget _buildInfoField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        // border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }


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
          // _buildInfoField("Event Mode", _eventMode),
          // const SizedBox(
          //   height: 15,
          // ),
          _buildInfoField("Event Seats Availability", _eventSeatsAvailibility),

          customDropdownMenu(
              defaultValue: dropdownValue,
              listData: eventModeType,
              onChanged: (String newValue) {}),
          customDropdownMenu(
              defaultValue: "dogi",
              listData: ["dogi", "caf", "Wef"],
              onChanged: (String newValue) {}),

          const timePicker(),
          const datePickerCard(),

          SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Host Your Event")))
        ]),
      ),
    );
  }
}
