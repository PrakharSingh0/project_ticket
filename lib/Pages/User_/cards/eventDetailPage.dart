import 'package:flutter/material.dart';

class eventDetailPage extends StatelessWidget {
  final Map<String, String> event;
  const eventDetailPage({super.key, required this.event});

  Widget hSpacer(double size){
    return SizedBox(height: size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            leading: const BackButton(
              style: ButtonStyle(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.white,
                )),
        body: Stack(
          children: [
            Stack(
              children:[ Container (
              height: 350,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/back.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                Positioned(
                  bottom: 60,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      event["Event"] ?? 'Event Name Not Available',
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),Positioned(
                  bottom: 40,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      event["Event Type"] ?? 'Event Type Not Available',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal,color: Colors.white),
                    ),
                  ),
                ),
            ],),


            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(

                    // height: 350,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            
                            children: [
                              hSpacer(20),
                              Text(
                                "Event Date: ${event["date"] ?? 'Content not Loaded'}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              hSpacer(10),
                              Text(
                                "Event Time: ${event["Time"] ?? 'Content not Loaded'}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              hSpacer(10),
                          
                              Text(
                                "Event Venue: ${event["Venue"] ?? 'Content not Loaded'}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              hSpacer(20),
                          
                              Text(
                                event["description"] ?? """ Welcome to the website. If you're here, you're likely looking to find random words. Random Word Generator is the perfect tool to help you do this. While this tool isn't a word creator, it is a word generator that will generate random words for a variety of activities or uses. Even better, it allows you to adjust the parameters of the random words to best fit your needs.
                                                        
                                                        The first option the tool allows you to adjust is the number of random words to be generated. You can choose as many or as few as you'd like. You also have the option of choosing words that only begin with a certain letter, only end with a certain letter or only begin and end with certain letters. If you leave these blank, the randomized words that appear will be from the complete list.
                                                        
                                                        Another option you have is choosing the number of syllables of the words or the word length of the randomized words. There are also ways to further refine these by choosing the "less than" or "greater than" options for both syllables and word length. Again, if you leave the space blank, the complete list of randomized words will be used.
                                                        
                                                        You have the option of choosing the types of words you want to be displayed using the "Word Type" dropdown. The default is "All" which is a curated list of thousands of the more common English words. You can also opt to only display nouns, verbs, or adjectives from this curated list. If you want to choose from all the words out there, you can choose "Extended" which is a list that includes over half a million different English words.
                                                        
                                                        If you're interested in random words in languages other than English, you can choose the "Non English" word type. Doing so will give you the option to generate words in ten different languages other than English. This includes Spanish words, Hindi words, Arabic words, German words, Russian words, Chinese words, Japanese words, Korean words. Latin words, or Italian words. You simply need to choose the language and then words from that language will randomly appear with each refresh of the page.
                                                        
                                                        Once you have input all of your specifications, all you have to do is to press the Generate Random Words button, and a list of random words will appear. Below are some of the common ways people use this tool.""",
                                style: const TextStyle(fontSize: 16),
                              ),
                              // Optional: Add more event action buttons or information
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.orangeAccent,
                                  ),
                                  child: const Text("Apply Now"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),);
  }
}





















// Column(
// // mainAxisAlignment: MainAxisAlignment.start,
// // crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Stack(children: <Widget>[
// Container(
// height: 350,
// decoration: const BoxDecoration(
// // boxShadow: [
// //   BoxShadow(
// //     color: Colors.grey.withOpacity(1),
// //     spreadRadius: 5,
// //     blurRadius: 7,
// //     offset: const Offset(0, 5), // changes position of shadow
// //   ),
// // ],
// borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),

// image: DecorationImage(
// image: AssetImage('assets/back.jpg'),
// fit: BoxFit.cover,
// ),
// ),),
//
// Expanded(
// child: ClipRect(
// child: ListView(
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 16, top: 16, bottom: 5),
// child: Text(
// event["Event"] ?? 'Event Name Not Available',
// style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.only(left: 16),
// child: Text(
// event["Event Type"] ?? 'Event Type Not Available',
// style:
// const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
// ),
// ),
// // Event date
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: Text(
// "Event Date: ${event["date"] ?? 'Content not Loaded'}",
// style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: Text(
// "Event Time: ${event["Time"] ?? 'Content not Loaded'}",
// style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: Text(
// "Event Venue: ${event["Venue"] ?? 'Content not Loaded'}",
// style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: Text(
// event["description"] ?? 'Content not Loaded',
// style: const TextStyle(fontSize: 16),
// ),
// ),
// // Optional: Add more event action buttons or information
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: SizedBox(
// width: 200,
// child: ElevatedButton(
// onPressed: () {},
// style: ElevatedButton.styleFrom(
// foregroundColor: Colors.white,
// backgroundColor: Colors.orangeAccent,
// ),
// child: const Text("Apply Now"),
// ),
// ),
// ),
//
// ],
// ),
// ),
// )
// ]),
//
//
// ],
