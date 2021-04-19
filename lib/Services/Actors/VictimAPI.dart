import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/CaseServices/victim.dart';

class VictimAPI{
  static const VictimRoot = 'https://c-r-m-s.000webhostapp.com/victim_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_VICTIM_ACTION = 'ADD_VICTIM';
  static const UPDATE_VICTIM_ACTION = 'UPDATE_VICTIM';
  static const DELETE_VICTIM_ACTION = 'DELETE_VICTIM';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final victimresponse = await http.post(VictimRoot,body: map);
      print('Create Table Response: ${victimresponse.body}');
      if(200 == victimresponse.statusCode){
        return victimresponse.body;
      }
      else{
        return "error creating table";
      }
    }
    catch(e){
      return "error";
    }
  }
  static Future<List<Victim>> getVictim() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(VictimRoot,body:map);
      print('getVictim Response: ${response.body}');
      if(200 == response.statusCode){
        List<Victim> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Victim>();
      }
    }catch(e){
      return List<Victim>(); //return empty list on exception or error
    }
  }
  static List<Victim> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Victim>((json)=>Victim.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addVictim(String first_name, String last_name, String contact, String gender, String injuries, String victim_address) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_VICTIM_ACTION;
      map['first_name'] = first_name;
      map['last_name'] = last_name;
      map['contact'] = contact;
      map['gender'] = gender;
      map['injuries'] = injuries;
      map['victim_address']= victim_address;
      final response = await http.post(VictimRoot,body:map);
      print('addVictim Response: ${response.body}');
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
  static Future<String> updateVictim(String first_name, String last_name, String contact, String gender, String injuries, String victim_address) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_VICTIM_ACTION;
      map['first_name'] = first_name;
      map['last_name'] = last_name;
      map['contact'] = contact;
      map['gender'] = gender;
      map['injuries'] = injuries;
      map['victim_address']= victim_address;
      final response = await http.post(VictimRoot,body:map);
      print('updateVictim Response: ${response.body}');
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
  static Future<String> deleteVictim(String victim_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_VICTIM_ACTION;
      map['victim_id'] = victim_id;
      final response = await http.post(VictimRoot,body:map);
      print('deleteVictim Response: ${response.body}');
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

