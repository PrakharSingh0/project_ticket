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

  List<String> eventType = [
    "Cultural",
    "Workshop",
    "Guest Lecture",
    "Seminar",
    "Hackathon",
    "Expo",
    "Conferences",
    "Tournament",
  ];

  Widget _buildInfoField(String label, String hintText, int height,
      TextEditingController controller) {
    return SizedBox(
      child: TextField(
        minLines: 1,
        maxLines: height,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
      ),
    );
  }

  Widget hSpace(){
    return const SizedBox(height: 10,);
}
Widget wSpace(){
    return const SizedBox(width: 10,);
}

  Widget _text(String text){
    return Text(text,style: TextStyle(fontSize: 16),);
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
        child: SingleChildScrollView(
          child: Column(children: [

            _buildInfoField("Event Name", "Enter Event Name", 1, _eventName),
            hSpace(),
            _buildInfoField("Event Description", "Tell us About Your Event", 10,
                _eventDescription),
            hSpace(),
            Row(
              children: [
                _text("Event Type :"),
                wSpace(),
                customDropdownMenu(
                    defaultValue: "Cultural",
                    listData: eventType,
                    onChanged: (String newValue) {}),
              ],
            ),

            Row(
              children: [
                _text("Event Mode :"),
                wSpace(),
                customDropdownMenu(
                    defaultValue: dropdownValue,
                    listData: eventModeType,
                    onChanged: (String newValue) {}),
              ],
            ),

            Row(
              children: [
                _text("Event Date :"),
                wSpace(),
                _text("20 / 11 / 2024"),
                datePickerCard()
              ],
            ),
             Row(
              children: [
                _text("Event Time :"),
                wSpace(),
                _text("4 :40 PM"),
                timePicker()
              ],
            ),
            hSpace(),

            _buildInfoField(
                "Event Vanue", "Specify Event Vanue Location", 1, _eventVanue),

            hSpace(),

            _buildInfoField("Event Seats Availability", "Any Seats Limitation",
                1, _eventSeatsAvailibility),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     customDropdownMenu(
            //         defaultValue: dropdownValue,
            //         listData: eventModeType,
            //         onChanged: (String newValue) {}),
            //     customDropdownMenu(
            //         defaultValue: "Cultural",
            //         listData: eventType,
            //         onChanged: (String newValue) {}),
            //   ],
            // ),

            // const timePicker(),
            // const datePickerCard(),

            SizedBox(height: 100,),

            SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Host Your Event",
                      style: TextStyle(fontSize: 16),
                    )))
          ]),
        ),
      ),
    );
  }
}
