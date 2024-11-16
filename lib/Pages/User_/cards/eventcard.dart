import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class eventcard extends StatelessWidget {
  const eventcard({super.key});

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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Name',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                          fontSize: 16, // Adjust the font size as necessary
                        ),
                      ),
                      Text(
                        'Event Type',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                          fontSize: 12, // Adjust the font size as necessary
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      tooltip: "Social Media",
                      icon: const Icon(LineAwesome.instagram)),
                  const SizedBox(width: 0),
                  IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      tooltip: "Social Media",
                      icon: const Icon(Bootstrap.link_45deg)),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFF020202)),
              _buildInfoRow(context, 'Date :'),
              _buildInfoRow(context, 'Time :'),
              _buildInfoRow(context, 'Venue'),
              _buildInfoRow(context, 'Mode:'),
              _buildInfoRow(context, 'Seat Available:'),
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

  Widget _buildInfoRow(BuildContext context, String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        letterSpacing: 0.0,
        fontSize: 16,
      ),
    );
  }
}
