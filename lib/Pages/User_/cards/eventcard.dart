import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class eventcard extends StatefulWidget {
  const eventcard({super.key});

  @override
  State<eventcard> createState() => _eventcardState();
}

class _eventcardState extends State<eventcard> {
  String eventName = "";
  String eventDiscription = "";
  String eventMode = "";
  String eventVanue = "";
  String eventType = "";
  String eventWeblink = "";
  String eventSocialLink = "";
  int eventSeats = 0;
  String eventDate="";
  String eventTime="";


  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('eventDetails')
          .doc('iY3zQfoYFeDXWepsRIbf')
          .get();

      if (doc.exists) {
        setState(() {
          eventName = doc['eventName'];
          eventMode = doc['eventMode'];
          eventDiscription = doc['eventDiscription'];
          eventType = doc['eventType'];
          eventVanue = doc['eventVanue'];
          eventWeblink = doc['eventWebLink'];
          eventSocialLink = doc['eventSocialLink'];
          eventSeats = doc['eventSeats'];
          eventDate=doc["eventDate"];
          eventTime=doc["eventTime"];
        });
      } else {
        setState(() {

        });
      }
    } catch (e) {
      setState(() {
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          fontSize: 22, // Adjust the font size as necessary
                        ),
                      ),
                      Text(
                        eventType,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                          fontSize: 12, // Adjust the font size as necessary
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {

                      },
                      iconSize: 30,
                      tooltip: "Social Media",
                      icon: const Icon(LineAwesome.instagram)),
                  const SizedBox(width: 0),
                  IconButton(
                      onPressed: () {

                      },
                      iconSize: 30,
                      tooltip: "Web Link",
                      icon: const Icon(Bootstrap.link_45deg)),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFF020202)),




              _buildInfoRow(context, 'Date : ',eventDate),
              _buildInfoRow(context, 'Time : ',eventTime),
              _buildInfoRow(context, 'Venue : ',eventVanue),
              _buildInfoRow(context, 'Mode : ',eventMode),


              Row(children: [
                const Text(
                  "Seats Available : ",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    letterSpacing: 0.0,
                    fontSize: 16,
                  ),
                ),

                Text(
                  '$eventSeats',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.0,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ]),

              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    child: const Text(
                      'Enquire Now ',
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Widget _buildInfoRow(BuildContext context, String text,String data) {
    return Row(children: [
      Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          letterSpacing: 0.0,
          fontSize: 16,
        ),
      ),

      Text(
        data,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
          letterSpacing: 0.0,
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    ]);
  }
}
