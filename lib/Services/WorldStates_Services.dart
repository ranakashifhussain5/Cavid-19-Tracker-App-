import 'dart:convert';

import 'package:cavid_19/Models/World_States_Model.dart';
import 'package:cavid_19/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;

class WorldStateServices{
   Future<WorldStatesModel> FetchWorldStatesRecord () async{
     final respose= await http.get(Uri.parse(AppUrl.worldstateapi));

     if(respose.statusCode==200)
       {
         var data= jsonDecode(respose.body);
         return WorldStatesModel.fromJson(data);
       }
     else
       {
         throw Exception('Error in Api Fetching');
       }

   }
   Future<List<dynamic>> CountriesRecord () async{
     var data;
     final respose= await http.get(Uri.parse(AppUrl.countriselist));

     if(respose.statusCode==200)
     {
        data= jsonDecode(respose.body);
       return data;
     }
     else
     {
       throw Exception('Error in Api Fetching');
     }

   }
}