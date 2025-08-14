import 'dart:async';
import 'dart:math' as math;

import 'package:cavid_19/Screens/Word_states.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
   void dispose()
   {
     super.dispose();
     _controller.dispose();
   }

    void initState(){
      super.initState();
      Timer(Duration(seconds: 5),
          ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> worldstate())),
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: _controller,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Center(
                        child: Image(image: AssetImage('assets/virus.png')),
                      ),
                    ),
                    builder: (BuildContext context,Widget? child){
                      return Transform.rotate(
                          angle: _controller.value * 2.0 * math.pi,
                          child:child,
                      );
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * .08,),
                Align(
                  alignment: Alignment.center,
                    child: Text('COVID-19 \n Tracker App',
                      textAlign:TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 25,
                        ),))
              ]
          )),
    );
  }
}
