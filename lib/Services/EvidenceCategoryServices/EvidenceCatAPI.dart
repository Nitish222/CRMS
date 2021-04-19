import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/CaseServices/EvidenceCategory.dart';

class EvidenceCatAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const EvidenceCatRoot = 'https://c-r-m-s.000webhostapp.com/EvidenceCategory_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_CAT_ACTION = 'ADD_EVIDENCECATEGORY';
  static const UPDATE_CAT_ACTION = 'UPDATE_EVIDENCECATEGORY';
  static const DELETE_CAT_ACTION = 'DELETE_EVIDENCECATEGORY';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final response = await http.post(EvidenceCatRoot,body: map);
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
  static Future<List<EvidenceCategory>> getCat() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(EvidenceCatRoot,body:map);
      print('getOfficers Response: ${response.body}');
      if(200 == response.statusCode){
        List<EvidenceCategory> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<EvidenceCategory>();
      }
    }catch(e){
      return List<EvidenceCategory>(); //return empty list on exception or error
    }
  }
  static List<EvidenceCategory> parseResponse(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String,dynamic>>();
    return parsed.map<EvidenceCategory>((json)=>EvidenceCategory.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addCat(String catName) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_CAT_ACTION;
      map['category_name'] = catName;

      final response = await http.post(EvidenceCatRoot,body:map);
      print('addCase Response: ${response.body}');
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
  static Future<String> updateCat(String catId,String catName) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_CAT_ACTION;
      map['category_id'] = catId;
      map['category_name'] = catName;

      final response = await http.post(EvidenceCatRoot,body:map);
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

  //Method to Delete Case
  static Future<String> deleteCat(String categoryId) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_CAT_ACTION;
      map['category_id'] = categoryId;
      final response = await http.post(EvidenceCatRoot,body:map);
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