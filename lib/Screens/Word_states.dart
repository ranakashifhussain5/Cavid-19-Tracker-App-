import 'package:cavid_19/Models/World_States_Model.dart';
import 'package:cavid_19/Screens/StatesCountries.dart';
import 'package:cavid_19/Services/WorldStates_Services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class worldstate extends StatefulWidget {
  const worldstate({super.key});

  @override
  State<worldstate> createState() => _worldstateState();
}

class _worldstateState extends State<worldstate> with TickerProviderStateMixin {
  late final _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorlist = <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    WorldStateServices stateServices= WorldStateServices();
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker App'),
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),
      body: SafeArea(
          child:
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                    children: [
            SizedBox(height: MediaQuery.of(context).size.height* .01,),
            Text('View All Cases',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),
            SizedBox(height: MediaQuery.of(context).size.height* .02,),
            FutureBuilder(
                future: stateServices.FetchWorldStatesRecord(),
                builder:(context, AsyncSnapshot<WorldStatesModel> snapshot){
               if(!snapshot.hasData)
                 {
                   return Expanded(
                       flex: 1,
                       child:SpinKitFadingCircle(
                         color: Colors.black  ,
                         size: 50,
                         controller: _controller,
                       )
                   );
                 }
               else
                 {
                   return Column(
                     children: [
                       PieChart(
                         dataMap:{
                           "Total":double.parse(snapshot.data!.cases!.toString()),
                           "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                           "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                         },
                         chartValuesOptions: ChartValuesOptions(
                           showChartValuesInPercentage: true,
                         ),
                         chartRadius: MediaQuery.of(context).size.width/2.5,
                         legendOptions: LegendOptions(
                             legendPosition: LegendPosition.left,
                             legendTextStyle: TextStyle(
                             )
                         ),
                         animationDuration: Duration(milliseconds: 1200),
                         chartType: ChartType.ring,
                         colorList: colorlist,
                       ),
                       Card(
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 15),
                           child: Column(
                             children: [
                               ResusableRow(title: 'Cases', value: snapshot.data!.cases.toString()),
                               ResusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                               ResusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                               ResusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                               ResusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              // ResusableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                               ResusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                               ResusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                               //SizedBox(height: MediaQuery.of(context).size.height *.2,)
                             ],
                           ),

                         ),
                       ), SizedBox(height: MediaQuery.of(context).size.height* .01,),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesRecordScreen()));
                         },
                         child: Container(
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.green,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Center(child: Text('Track Country')),
                         ),
                       )
                     ],
                   );
                 }
                }),

                    ],
                  ),
          )),
    );
  }
}

class ResusableRow extends StatelessWidget {
  String title;
  String value;

   ResusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 13,left: 13,top: 13,bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
             // Divider()
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}




