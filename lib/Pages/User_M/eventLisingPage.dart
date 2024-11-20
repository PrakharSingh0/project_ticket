import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_ticket/Pages/User_M/mHomePage.dart';

import '../../models/eventDetailsModel.dart';

class eventListingPage extends StatefulWidget {
  const eventListingPage({super.key});

  @override
  State<eventListingPage> createState() => _eventListingPageState();
}

class _eventListingPageState extends State<eventListingPage> {
  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _eventDescription = TextEditingController();
  final TextEditingController _eventVanue = TextEditingController();
  final TextEditingController _eventSeatsAvailibility = TextEditingController();
  final TextEditingController _eventWebPage = TextEditingController();
  final TextEditingController _eventSocialPage = TextEditingController();

  List<String> eventModeType = ["Online", "Offline"];
  String dropdownValue = "Online";
  String eventModeNewValue = "Online";
  String eventTypeNewValue = "Cultural";

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

  DateTime presentYear = DateTime(DateTime.now().year);

  DateTime date = DateTime(2024, 11, 27);
  Future<void> datePicker() async {
    DateTime? selectDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: presentYear,
        lastDate: presentYear.add(const Duration(days: 365 * 2)));
    if (selectDate == null) return;
    setState(() => date = selectDate);
  }

  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  Future<void> selectTime() async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
    });
  }

  Widget hSpace() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget wSpace() {
    return const SizedBox(
      width: 10,
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String defaultValue,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return Row(
      children: [
        _text("$label :"),
        wSpace(),
        DropdownButton<String>(
          value: defaultValue,
          onChanged: (value) {
            onChanged(value!);
          },
          items: items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ))
              .toList(),
        ),
      ],
    );
  }

  Future<void> writeFireStore() async {
    final db = FirebaseFirestore.instance;

    final event = eventDetailsModel(
      eventName: _eventName.text.trim(),
      eventDiscription: _eventDescription.text.trim(),
      eventTime:
      "${_time.hourOfPeriod.toString().padLeft(2, '0')} : ${_time.minute.toString().padLeft(2, '0')} ${_time.period == DayPeriod.am ? 'AM' : 'PM'}",
      eventDate: '${date.day} / ${date.month} / ${date.year}',
      eventVenue: _eventVanue.text.trim(),
      eventMode: eventModeNewValue,
      eventType: eventTypeNewValue,
      eventWeblink: _eventWebPage.text.trim(),
      eventSocialLink: _eventSocialPage.text.trim(),
      eventSeats: int.parse(_eventSeatsAvailibility.text.trim()),
    );

    await db.collection("eventDetails").add(event.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("List Your Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInfoField("Event Name", "Enter Event Name", 1, _eventName),
              hSpace(),
              _buildInfoField(
                  "Event Description", "Tell us About Your Event", 10, _eventDescription),
              hSpace(),
              _buildDropdown(
                label: "Event Type",
                defaultValue: eventTypeNewValue,
                items: eventType,
                onChanged: (value) {
                  setState(() {
                    eventTypeNewValue = value;
                  });
                },
              ),
              hSpace(),
              _buildDropdown(
                label: "Event Mode",
                defaultValue: eventModeNewValue,
                items: eventModeType,
                onChanged: (value) {
                  setState(() {
                    eventModeNewValue = value;
                  });
                },
              ),
              hSpace(),
              Row(
                children: [
                  _text("Event Date :"),
                  wSpace(),
                  _text("${date.day} / ${date.month} / ${date.year}"),
                  IconButton(
                    onPressed: datePicker,
                    icon: const Icon(Clarity.date_solid),
                  ),
                ],
              ),
              Row(
                children: [
                  _text("Event Time :"),
                  wSpace(),
                  _text(
                      "${_time.hourOfPeriod.toString().padLeft(2, '0')} : ${_time.minute.toString().padLeft(2, '0')} ${_time.period == DayPeriod.am ? 'AM' : 'PM'}"),
                  IconButton(
                    onPressed: selectTime,
                    icon: const Icon(OctIcons.clock),
                  ),
                ],
              ),
              hSpace(),
              _buildInfoField(
                  "Event Venue", "Specify Event Venue Location", 1, _eventVanue),
              hSpace(),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                minLines: 1,
                maxLines: 1,
                controller: _eventSeatsAvailibility,
                decoration: const InputDecoration(
                  labelText: "Seats Available",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  hintText: "Any Seats Limitation",
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              ),
              hSpace(),
              _buildInfoField(
                  "Event Web link", "Event's Website ", 1, _eventWebPage),
              hSpace(),
              _buildInfoField(
                  "Social Link", "Event Social Page ", 1, _eventSocialPage),
              const SizedBox(height: 100),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Event Hosting"),
                        content: const Text(
                            "Are you sure you want to host this event? Provided information is valid and checked."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              writeFireStore().whenComplete(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const mHomePage()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Event Hosted successfully')),
                                );
                              });
                            },
                            child: const Text('Host'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Host Your Event",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
