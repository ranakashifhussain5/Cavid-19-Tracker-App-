import 'package:cavid_19/Screens/Country_details.dart';
import 'package:cavid_19/Services/WorldStates_Services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountriesRecordScreen extends StatefulWidget {
  const CountriesRecordScreen({super.key});

  @override
  State<CountriesRecordScreen> createState() => _CountriesRecordScreenState();
}
TextEditingController searchcontroller=TextEditingController();
class _CountriesRecordScreenState extends State<CountriesRecordScreen> {
  @override
  Widget build(BuildContext context) {
    WorldStateServices stateServices = WorldStateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: TextFormField(
              onChanged: (value)
              {
                setState(() {

                });
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hint: Text('Search with Country Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(future: stateServices.CountriesRecord(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData)
                      {
                        return ListView.builder(
                            itemCount: 8,
                            itemBuilder: (context,index){
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                              child:Column(
                              children: [
                              ListTile(
                              title:Container(height: 10,width: 90 ,color: Colors.white,),

                              leading:Container(height: 50,width: 50 ,color: Colors.white,),
                              subtitle: Container(height: 10,width: 20 ,color: Colors.white,),
                              )
                              ],
                              )
                              );
                            });
                      }
                    else
                      {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){
                              String name= snapshot.data![index]['country'];
                              if(searchcontroller.text.isEmpty)
                                {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetails(
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          name: snapshot.data![index]['country'],
                                          totalCases:snapshot.data![index]['cases'],
                                          todayRecovered:snapshot.data![index]['todayRecoverd'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          test: snapshot.data![index]['tests'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecovered:snapshot.data![index]['recovered'])));
                                    },
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title:Text(snapshot.data![index]['country']),

                                          leading:Image(
                                              height:50,
                                              width:50,
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                          subtitle: Text('Total Cases '+snapshot.data![index]['cases'].toString()),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase()))
                                {
                                  return InkWell(
                                    onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetails(
                                image: snapshot.data![index]['countryInfo']['flag'],
                                name: snapshot.data![index]['country'],
                                totalCases:snapshot.data![index]['cases'],
                                todayRecovered:snapshot.data![index]['todayRecoverd'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                test: snapshot.data![index]['tests'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                totalRecovered:snapshot.data![index]['recovered'])));
                                },
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title:Text(snapshot.data![index]['country']),

                                          leading:Image(
                                              height:50,
                                              width:50,
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                          subtitle: Text('Total Cases '+snapshot.data![index]['cases'].toString()),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              else
                                {
                                  return Container();

                                }

                        });
                      }
                }),
          )
        ],
      )),

    );
  }
}
