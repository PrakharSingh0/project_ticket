import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/dashboard.dart';

class  welcome_page extends StatelessWidget {
  const welcome_page({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splashScreen.jpeg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 24, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0, 0.55),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Crowd Wave',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontFamily: 'PT Sans',
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 2.0,
                                ),
                              ]),
                        ),
                      ),
                      Text(
                        'Experience the energy of live events like never before',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontFamily: 'Inter Tight',
                        ),
                      ),
                    ]),
                  ),
                ),
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: SizedBox(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(

                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const dasboard()));
                          },

                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  ),
                              textStyle: const TextStyle(color: Colors.white)),

                          child: const Text(
                            'Getting Started',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: const BorderSide(color: Colors.white)),
                            textStyle: const TextStyle(color: Colors.white)),

                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
