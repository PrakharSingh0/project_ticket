import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_ticket/Pages/User_M/cards/customDropDownMenu.dart';


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
  final TextEditingController _socialLink = TextEditingController();
  final TextEditingController _eventWebPage = TextEditingController();

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

  DateTime presentYear =DateTime(DateTime.now().year);

  DateTime date =DateTime(2024,11,27);
  Future<void> datePicker() async {
    DateTime? selectDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: presentYear,
        lastDate: presentYear.add(const Duration(days: 365 * 2))
    );
    if(selectDate == null) return;
    setState(() =>date=selectDate);
  }


  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  Future<Null> selectTime() async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
    });
  }

  Widget hSpace(){
    return const SizedBox(height: 10,);
}
Widget wSpace(){
    return const SizedBox(width: 10,);
}

  Widget _text(String text){
    return Text(text,style: const TextStyle(fontSize: 16),);
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
          child: Padding(
            padding: EdgeInsets.all(10),
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
                  _text("${date.day} / ${date.month} / ${date.year}"),
                  IconButton(onPressed: () {datePicker();  }, icon: const Icon(Clarity.date_solid),)
                ],
              ),
               Row(
                children: [
                  _text("Event Time :"),
                  wSpace(),
                  _text("${_time.hourOfPeriod.toString().padLeft(2, '0')} : ${_time.minute.toString().padLeft(2, '0')} ${_time.period == DayPeriod.am ? 'AM' : 'PM'}"),
                  IconButton(onPressed: () {selectTime();  }, icon: const Icon(OctIcons.clock),)
                ],
              ),
              hSpace(),
            
              _buildInfoField(
                  "Event Vanue", "Specify Event Vanue Location", 1, _eventVanue),
            
              hSpace(),
            
              _buildInfoField("Event Seats Availability", "Any Seats Limitation",
                  1, _eventSeatsAvailibility),
            
              hSpace(),
            
              _buildInfoField("Event Web link", "Event's Website ",
                  1, _eventWebPage),
            
              hSpace(),
            
              _buildInfoField("Social Link", "Event Social Page ",
                  1, _socialLink),
            
              const SizedBox(height: 100,),
            
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
      ),
    );
  }
}
