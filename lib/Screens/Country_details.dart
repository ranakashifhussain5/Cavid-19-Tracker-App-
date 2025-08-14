import 'package:cavid_19/Screens/Word_states.dart';
import 'package:flutter/material.dart';
class CountryDetails extends StatefulWidget {
  String image;
  String name;
  int? totalCases ,totalDeaths , totalRecovered ,critical , active , todayRecovered , test ;
   CountryDetails({required this.image,
     required this.name,
     required this.totalCases,
     required this.todayRecovered,
     required this.active,
     required this.critical,
     required this.test,
     required this.totalDeaths,
     required this.totalRecovered

   });

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *.063),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .05,),
                      ResusableRow(title: 'Total Cases', value:widget.totalCases.toString()),
                      ResusableRow(title: 'Recovered', value:widget.totalRecovered.toString()),
                      ResusableRow(title: 'Deaths', value:widget.totalDeaths.toString()),
                      ResusableRow(title: 'Critical', value:widget.critical.toString()),
                      ResusableRow(title: 'Active', value:widget.active.toString()),
                      //ResusableRow(title: 'Today Recovered', value:widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.image),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

