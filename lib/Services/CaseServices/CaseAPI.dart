import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Case.dart';

class CaseAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const CaseRoot = 'https://c-r-m-s.000webhostapp.com/case_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_CASE_ACTION = 'ADD_CASE';
  static const UPDATE_CASE_ACTION = 'UPDATE_CASE';
  static const DELETE_CASE_ACTION = 'DELETE_CASE';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final caseresponse = await http.post(CaseRoot,body: map);
      print('Create Table Response: ${caseresponse.body}');
      if(200 == caseresponse.statusCode){
        return caseresponse.body;
      }
      else{
        return "error creating table";
      }
    }
    catch(e){
      return "error";
    }
  }
  static Future<List<Case>> getCase() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(CaseRoot,body:map);
      print('getOfficers Response: ${response.body}');
      if(200 == response.statusCode){
        List<Case> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Case>();
      }
    }catch(e){
      return List<Case>(); //return empty list on exception or error
    }
  }
  static List<Case> parseResponse(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String,dynamic>>();
    return parsed.map<Case>((json)=>Case.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addCase(String caseDescription, String caseStatus, String evidenceId,String statementId,String firId, String officerId) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_CASE_ACTION;
      map['case_description'] = caseDescription;
      map['case_status'] = caseStatus;
      map['statement_id'] = statementId;
      map['evidence_id'] = evidenceId;
      map['fir_id'] = firId;
      map['officer_id']= officerId;
      final response = await http.post(CaseRoot,body:map);
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
  static Future<String> updateCase(String caseId,String caseDescription, String caseStatus) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_CASE_ACTION;
      map['case_id'] = caseId;
      map['case_description'] = caseDescription;
      map['case_status'] = caseStatus;
      final response = await http.post(CaseRoot,body:map);
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
  static Future<String> deleteCase(String caseId) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_CASE_ACTION;
      map['case_id'] = caseId;
      final response = await http.post(CaseRoot,body:map);
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