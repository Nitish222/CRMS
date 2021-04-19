import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/CaseServices/Accused.dart';


class AccusedAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const AccusedRoot = 'https://c-r-m-s.000webhostapp.com/accused_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_ACCUSED_ACTION = 'ADD_ACCUSED';
  static const UPDATE_ACCUSED_ACTION = 'UPDATE_ACCUSED';
  static const DELETE_ACCUSED_ACTION = 'DELETE_ACCUSED';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final accusedresponse = await http.post(AccusedRoot,body: map);
      print('Create Table Response: ${accusedresponse.body}');
      if(200 == accusedresponse.statusCode){
        return accusedresponse.body;
      }
      else{
        return "error creating table";
      }
    }
    catch(e){
      return "error";
    }
  }
  static Future<List<Accused>> getAccused() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(AccusedRoot,body:map);
      print('getOfficers Response: ${response.body}');
      if(200 == response.statusCode){
        List<Accused> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Accused>();
      }
    }catch(e){
      return List<Accused>(); //return empty list on exception or error
    }
  }
  static List<Accused> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Accused>((json)=>Accused.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addAccused(String first_name, String last_name, String contact, String gender, String criminal_records, String accused_address, String statement_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_ACCUSED_ACTION;
      map['first_name'] = first_name;
      map['last_name'] = last_name;
      map['contact'] = contact;
      map['gender'] = gender;
      map['criminal_records'] = criminal_records;
      map['accused_address']= accused_address;
      map['statement_id'] = statement_id;
      final response = await http.post(AccusedRoot,body:map);
      print('addAccused Response: ${response.body}');
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
  static Future<String> updateAccused(String accused_id, String accusedDescription, String accusedStatus, String evidenceId, String firId,String officerId) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_ACCUSED_ACTION;
      map['accused_id'] = accused_id;
      map['accused_description'] = accusedDescription;
      map['accused_status'] = accusedStatus;
      map['evidence_id'] = evidenceId;
      map['fir_id'] = firId;
      map['officer_id']= officerId;
      final response = await http.post(AccusedRoot,body:map);
      print('updateAccused Response: ${response.body}');
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
  static Future<String> deleteAccused(String accused_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_ACCUSED_ACTION;
      map['accused_id'] = accused_id;
      final response = await http.post(AccusedRoot,body:map);
      print('deleteAccused Response: ${response.body}');
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

