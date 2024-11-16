import 'package:flutter/material.dart';

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
            child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      const Column(
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event Name',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                              fontSize:
                                  16, // Adjust the font size as necessary
                            ),
                          ),
                          Text(
                            'Event type',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          tooltip: "Social Media",
                          icon: const Icon(Icons.facebook)),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {},
                          iconSize: 30,
                          tooltip: "Social Media",
                          icon:
                              const Icon(Icons.account_balance_wallet_rounded)),
                    ],
                  ),
                  const Divider(thickness: 1, color: Color(0xFF020202)),
                  _buildInfoRow(context, 'Date :'),
                  _buildInfoRow(context, 'Venue'),
                  _buildInfoRow(context, 'Seat Available:'),
                  _buildInfoRow(context, 'Price :'),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildButton(context, 'Online'),
                      const SizedBox(width: 20),
                      _buildButton(context, 'Online'),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF09B467),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          'Join Now',
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }

  Widget _buildInfoRow(BuildContext context, String text) {
    return Align(
      alignment: const AlignmentDirectional(-1, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            letterSpacing: 0.0,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return Container(
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
