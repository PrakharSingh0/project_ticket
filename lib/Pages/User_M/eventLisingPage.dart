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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _eventDescription = TextEditingController();
  final TextEditingController _eventVanue = TextEditingController();
  final TextEditingController _eventSeatsAvailibility = TextEditingController();
  final TextEditingController _eventWebPage = TextEditingController();
  final TextEditingController _eventSocialPage = TextEditingController();
  final TextEditingController _bannerImage = TextEditingController();

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
      TextEditingController controller, String? Function(String?)? validator) {
    return TextFormField(
      minLines: 1,
      maxLines: height,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      validator: validator,
    );
  }

  DateTime presentYear = DateTime(DateTime.now().year);
  DateTime date = DateTime.now();
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
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
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
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
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
      bannerImage: _bannerImage.text.trim(),
      eventSeats: int.parse(_eventSeatsAvailibility.text.trim()),
    );

    await db.collection("eventDetails").add(event.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("List Your Event", style: TextStyle(color: Colors.black87)),
        backgroundColor:Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                hSpace(),
                _buildInfoField(
                  "Event Name",
                  "Enter Event Name",
                  1,
                  _eventName,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Event Name is required";
                    }
                    return null;
                  },
                ),
                hSpace(),
                _buildInfoField(
                  "Event Description",
                  "Tell us About Your Event",
                  10,
                  _eventDescription,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Event Description is required";
                    }
                    return null;
                  },
                ),
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
                    const Text("Event Date :",style: TextStyle(color:Colors.grey,fontSize: 18,)),
                    wSpace(),
                    Text("${date.day} / ${date.month} / ${date.year}",style: const TextStyle(color:Colors.black87,fontSize: 18,)),
                    IconButton(
                      onPressed: datePicker,
                      icon: const Icon(Clarity.date_solid, color: Colors.blueAccent),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Event Time :",style: TextStyle(color:Colors.grey,fontSize: 18,)),
                    wSpace(),
                    Text(
                        "${_time.hourOfPeriod.toString().padLeft(2, '0')} : ${_time.minute.toString().padLeft(2, '0')} ${_time.period == DayPeriod.am ? 'AM' : 'PM'}",style: const TextStyle(color:Colors.black87,fontSize: 18,)),
                    IconButton(
                      onPressed: selectTime,
                      icon: const Icon(OctIcons.clock, color: Colors.blueAccent),
                    ),
                  ],
                ),
                hSpace(),
                _buildInfoField(
                  "Event Venue",
                  "Specify Event Venue Location",
                  1,
                  _eventVanue,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Event Venue is required";
                    }
                    return null;
                  },
                ),
                hSpace(),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  minLines: 1,
                  maxLines: 1,
                  controller: _eventSeatsAvailibility,
                  decoration: InputDecoration(
                    labelText: "Seats",
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                    hintText: "Seats Available",
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Seats availability is required";
                    }
                    if (int.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    return null;
                  },
                ),
                hSpace(),
                _buildInfoField(
                  "Event Web link",
                  "Event's Website ",
                  1,
                  _eventWebPage,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Event Web link is required";
                    }
                    return null;
                  },
                ),
                hSpace(),
                _buildInfoField(
                  "Social Link",
                  "Event Social Page ",
                  1,
                  _eventSocialPage,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Social link is required";
                    }
                    return null;
                  },
                ),
                hSpace(),
                _buildInfoField(
                  "Event Banner",
                  "Link to Your Event Banner ",
                  1,
                  _bannerImage,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Event Banner is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                                            builder: (context) =>
                                            const mHomePage()),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Event Hosted successfully')),
                                      );
                                    });
                                  },
                                  child: const Text('Host'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Host Your Event",
                        style: TextStyle(color:Colors.white,fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                hSpace()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

