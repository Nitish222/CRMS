import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Fir.dart';

class FirAPI{
  static const FirRoot = 'https://c-r-m-s.000webhostapp.com/fir_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_FIR_ACTION = 'ADD_FIR';
  static const UPDATE_FIR_ACTION = 'UPDATE_FIR';
  static const DELETE_FIR_ACTION = 'DELETE_FIR';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final response = await http.post(FirRoot,body: map);
      print('Create Table Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error creating table";
      }
    }
    catch(e){
      return "error";
    }
  }
  static Future<List<Fir>> getFir() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(FirRoot,body:map);
      print('getFir Response: ${response.body}');
      if(200 == response.statusCode){
        List<Fir> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Fir>();
      }
    }catch(e){
      return List<Fir>(); //return empty list on exception or error
    }
  }
  static List<Fir> parseResponse(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String,dynamic>>();
    return parsed.map<Fir>((json)=>Fir.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addFir(String petitionerID, String victimID, String dateFiled,String timeFiled,String incidentDate, String incidentLocation) async{
    try{
      //Fir_ID	Petitioner_ID	Victim_ID	Date_filed	Time_filed	Incident_date	Incident_location
      var map = Map<String, dynamic>();
      map['action'] = ADD_FIR_ACTION;
      map['petitioner_id'] = petitionerID;
      map['victim_id'] = victimID;
      map['date_filed'] = dateFiled;
      map['time_filed'] = timeFiled;
      map['incident_date'] = incidentDate;
      map['incident_location']= incidentLocation;
      final response = await http.post(FirRoot,body:map);
      print('addFir Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error";
      }
    }catch(e){
      return "error"; //return empty list on exception or error
    }
  }

  //Method to update officer
  static Future<String> updateFir(String incidentDate, String incidentLocation) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_FIR_ACTION;
      map['incident_date'] = incidentDate;
      map['incident_location']= incidentLocation;
      final response = await http.post(FirRoot,body:map);
      print('updateCase Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error";
      }
    }catch(e){
      return "error"; //return empty list on exception or error
    }
  }

  //Method to Delete Officer
  static Future<String> deleteFir(String firId) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_FIR_ACTION;
      map['fir_id'] = firId;
      final response = await http.post(FirRoot,body:map);
      print('deleteCase Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }
      else{
        return "error";
      }
    }catch(e){
      return "error"; //return empty list on exception or error
    }
  }
}