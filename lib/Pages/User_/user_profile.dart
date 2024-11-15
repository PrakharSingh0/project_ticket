import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../service/firebaseAuthService.dart';

class userProfile extends StatelessWidget {
  const userProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Widget text(data) {
      return Text(
        data,
        style: const TextStyle(fontSize: 16),
      );
    }

    final User? user = Auth().currentUser;

    final String? name = Auth().currentUser?.displayName;

    final String? email = Auth().currentUser?.email;
    return
       Padding(
         padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
         child: Align(
           alignment: Alignment.topCenter,
           child: FractionallySizedBox(
            widthFactor:.9,
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: .4)),
              child:Padding(
                padding: const EdgeInsets.all(20),
                child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("Name : $name"),
                  const Divider(),
                  text("Email : $email"),
                  const Divider(),
                  text("Contact Info : $email"),
                  const Divider(),
                  text("Email : $email"),
                  const Divider(),
                  text("Email : $email"),
                  const Divider(),
                ],
              ),
            ),
                 ),
               ),
         ),
       );
  }
}
