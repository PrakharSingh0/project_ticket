import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/cards/eventcard.dart';

import 'cards/eventCatalogCard.dart';
import 'cards/trendingEventCard.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final Widget _spacer = const SizedBox(
    width: 10,
  );

  final Widget _hspacer = const SizedBox(
    height: 15,
  );

  Text _textHeading(data) {
    return Text(
      data,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Trending Event")),
                    _spacer,
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Upcoming Event")),
                    _spacer,
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Past Event")),
                    _spacer,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: _textHeading("Trending Event")),
            ),
            Container(
              height: 300,
              child: const CarouselView(itemExtent: 300, shrinkExtent: 250,padding: EdgeInsets.all(10),itemSnapping: true, children: [
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                              testcard(),
                            ]),
            ),
            SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const testcard(),
                      _spacer,
                      const testcard(),
                      _spacer,
                      const testcard(),
                    ])),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: _textHeading("Event Catalog")),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const eventCatalog(),
                    _spacer,
                    const eventCatalog(),
                    _spacer,
                    const eventCatalog(),
                    _spacer,
                    const eventCatalog(),
                    _spacer,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: _textHeading("Explore")),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Column(
                children: [
                  const eventcard(),
                  _hspacer,
                  const eventcard(),
                  _hspacer,
                  const eventcard()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
