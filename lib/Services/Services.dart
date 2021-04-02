import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Officer.dart';

class Services{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const ROOT = 'https://c-r-m-s.000webhostapp.com/officer_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_OFFICER_ACTION = 'ADD_OFFI';
  static const UPDATE_OFFICER_ACTION = 'UPDATE_OFFI';
  static const DELETE_OFFICER_ACTION = 'DELETE_OFFI';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final response = await http.post(ROOT,body: map);
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
  static Future<List<Officer>> getOfficers() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(ROOT,body:map);
      print('getOfficers Response: ${response.body}');
      if(200 == response.statusCode){
        List<Officer> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Officer>();
      }
    }catch(e){
      return List<Officer>(); //return empty list on exception or error
    }
  }
  static List<Officer> parseResponse(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String,dynamic>>();
    return parsed.map<Officer>((json)=>Officer.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addOfficer(String firstName, String lastName, String officerRank) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_OFFICER_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['officer_rank'] = officerRank;
      final response = await http.post(ROOT,body:map);
      print('addOfficer Response: ${response.body}');
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
  static Future<String> updateOfficer(String officer_id,String firstName,String lastName, String officerRank) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_OFFICER_ACTION;
      map['officer_id'] = officer_id;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      map['officer_rank'] = officerRank;
      final response = await http.post(ROOT,body:map);
      print('updateOfficer Response: ${response.body}');
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
  static Future<String> deleteOfficer(String officer_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_OFFICER_ACTION;
      map['officer_id'] = officer_id;
      final response = await http.post(ROOT,body:map);
      print('deleteOfficer Response: ${response.body}');
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