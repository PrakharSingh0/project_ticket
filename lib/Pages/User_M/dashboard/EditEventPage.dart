import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class EditEventPage extends StatefulWidget {
  final Map<String, dynamic> event; // Event data passed to this page
  final String eventId;
  const EditEventPage({super.key, required this.event, required this.eventId});

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _eventNameController;
  late TextEditingController _eventDescriptionController;
  late TextEditingController _eventDateController;
  late TextEditingController _eventTimeController;
  late TextEditingController _eventVenueController;
  late TextEditingController _eventSeatsController;
  late TextEditingController _eventWebLinkController;
  late TextEditingController _eventSocialLinkController;
  late TextEditingController _bannerImageController;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    _eventNameController = TextEditingController(text: widget.event['eventName']);
    _eventDescriptionController = TextEditingController(text: widget.event['eventDiscription']);
    _eventDateController = TextEditingController(text: widget.event['eventDate']);
    _eventTimeController = TextEditingController(text: widget.event['eventTime']);
    _eventVenueController = TextEditingController(text: widget.event['eventVenue']);
    _eventSeatsController = TextEditingController(text: widget.event['eventSeats'].toString());
    _eventWebLinkController = TextEditingController(text: widget.event['eventWeblink']);
    _eventSocialLinkController = TextEditingController(text: widget.event['eventSocialLink']);
    _bannerImageController = TextEditingController(text: widget.event['bannerImage']);

    // Parse eventDate and eventTime to initialize _selectedDate and _selectedTime
    _selectedDate = DateTime.tryParse(widget.event['eventDate']) ?? DateTime.now(); // Default to current date if invalid
    _selectedTime = TimeOfDay(
      hour: int.tryParse(widget.event['eventTime'].split(':')[0]) ?? 0, // Default to 0 if invalid
      minute: int.tryParse(widget.event['eventTime'].split(':')[1]) ?? 0, // Default to 0 if invalid
    );
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _eventDateController.dispose();
    _eventTimeController.dispose();
    _eventVenueController.dispose();
    _eventSeatsController.dispose();
    _eventWebLinkController.dispose();
    _eventSocialLinkController.dispose();
    _bannerImageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (selected != null && selected != _selectedTime) {
      setState(() {
        _selectedTime = selected;
      });
    }
  }

  Future<void> _updateEvent() async {
    final updatedEvent = {
      'eventName': _eventNameController.text,
      'eventDiscription': _eventDescriptionController.text,
      'eventDate': _selectedDate.toString().split(' ')[0],
      'eventTime': "${_selectedTime.format(context)}",
      'eventVenue': _eventVenueController.text,
      'eventSeats': int.parse(_eventSeatsController.text),
      'eventWeblink': _eventWebLinkController.text,
      'eventSocialLink': _eventSocialLinkController.text,
      'bannerImage': _bannerImageController.text,
    };

    // Call your Firestore update method here
    try {
      // Update the event in Firestore using the eventId
      await FirebaseFirestore.instance
          .collection('eventDetails')
          .doc(widget.eventId) // Get the event document by its ID
          .update(updatedEvent);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event updated successfully")),
      );

      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update event: $e")),
      );
    }
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, int maxLines, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.blueAccent)),
      ),
      validator: validator,
    );
  }

  Widget _buildDateTimeRow(String label, String value, VoidCallback onTap, IconData icon) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 18)),
        const SizedBox(width: 10),
        Text(value, style: const TextStyle(color: Colors.black87, fontSize: 18)),
        IconButton(onPressed: onTap, icon: Icon(icon, color: Colors.blueAccent)),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Event')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  _buildTextField('Event Name', 'Enter event name', _eventNameController, 1, (value) {
                    if (value == null || value.isEmpty) return 'Event name is required';
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildTextField('Event Description', 'Describe the event', _eventDescriptionController, 8, (value) {
                    if (value == null || value.isEmpty) return 'Event description is required';
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildDateTimeRow('Event Date:', "${_selectedDate.day} / ${_selectedDate.month} / ${_selectedDate.year}", _selectDate, Icons.calendar_today),
                  const SizedBox(height: 10),
                  _buildDateTimeRow('Event Time:', "${_selectedTime.format(context)}", _selectTime, Icons.access_time),
                  const SizedBox(height: 20),
                  _buildTextField('Event Venue', 'Enter venue location', _eventVenueController, 1, (value) {
                    if (value == null || value.isEmpty) return 'Event venue is required';
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildTextField('Available Seats', 'Enter number of seats', _eventSeatsController, 1, (value) {
                    if (value == null || value.isEmpty) return 'Number of seats is required';
                    if (int.tryParse(value) == null) return 'Please enter a valid number';
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildTextField('Event Web link', 'Enter event website', _eventWebLinkController, 1, (value) {
                    if (value == null || value.isEmpty) return 'Event web link is required';
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildTextField('Social Link', 'Enter social media link', _eventSocialLinkController, 1, (value) {
                    if (value == null || value.isEmpty) return 'Social media link is required';
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _buildTextField('Event Banner', 'Enter banner image link', _bannerImageController, 1, (value) {
                    if (value == null || value.isEmpty) return 'Banner image link is required';
                    return null;
                  }),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _updateEvent();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Update Event', style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
