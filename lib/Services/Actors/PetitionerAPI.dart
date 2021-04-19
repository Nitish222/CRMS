import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/CaseServices/petitioner.dart';


class PetitionerAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const PetitionerRoot = 'https://c-r-m-s.000webhostapp.com/petitoner_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_PETITIONER_ACTION = 'ADD_PETITIONER';
  static const UPDATE_PETITIONER_ACTION = 'UPDATE_PETITIONER';
  static const DELETE_PETITIONER_ACTION = 'DELETE_PETITIONER';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final petitionerresponse = await http.post(PetitionerRoot,body: map);
      print('Create Table Response: ${petitionerresponse.body}');
      if(200 == petitionerresponse.statusCode){
        return petitionerresponse.body;
      }
      else{
        return "error creating table";
      }
    }
    catch(e){
      return "error";
    }
  }
  static Future<List<Petitioner>> getPetitioner() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(PetitionerRoot,body:map);
      print('getPetitioner Response: ${response.body}');
      if(200 == response.statusCode){
        List<Petitioner> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Petitioner>();
      }
    }catch(e){
      return List<Petitioner>(); //return empty list on exception or error
    }
  }
  static List<Petitioner> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Petitioner>((json)=>Petitioner.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addPetitioner(String petitioner_first_name, String petitioner_last_name,String father_name, String petitioner_gender,  String petitioner_contact, String petitioner_address) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_PETITIONER_ACTION;
      map['petitioner_first_name'] = petitioner_first_name;
      map['petitioner_last_name'] = petitioner_last_name;
      map['father_name'] = father_name;
      map['petitioner_gender'] = petitioner_gender;
      map['petitioner_contact'] = petitioner_contact;
      map['petitioner_address']= petitioner_address;
      final response = await http.post(PetitionerRoot,body:map);
      print('addPetitioner Response: ${response.body}');
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
  static Future<String> updatePetitioner(String petitioner_id, String petitioner_first_name, String petitioner_last_name,String  petitioner_father_name, String petitioner_gender,  String petitioner_contact, String petitioner_address) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_PETITIONER_ACTION;
      map['petitioner_id'] = petitioner_id;
      map['petitioner_first_name'] = petitioner_first_name;
      map['petitioner_last_name'] = petitioner_last_name;
      map['father_name'] = petitioner_father_name;
      map['petitioner_gender'] = petitioner_gender;
      map['petitioner_contact'] = petitioner_contact;
      map['petitioner_address']= petitioner_address;
      final response = await http.post(PetitionerRoot,body:map);
      print('updatePetitioner Response: ${response.body}');
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
  static Future<String> deletePetitioner(String petitioner_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_PETITIONER_ACTION;
      map['petitioner_id'] = petitioner_id;
      final response = await http.post(PetitionerRoot,body:map);
      print('deletePetitioner Response: ${response.body}');
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

