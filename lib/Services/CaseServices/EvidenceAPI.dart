import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Evidence.dart';

class EvidenceAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const EvidenceRoot = 'https://c-r-m-s.000webhostapp.com/evidence_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_EVIDENCE_ACTION = 'ADD_EVIDENCE';
  static const UPDATE_EVIDENCE_ACTION = 'UPDATE_EVIDENCE';
  static const DELETE_EVIDENCE_ACTION = 'DELETE_EVIDENCE';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final evidenceresponse = await http.post(EvidenceRoot,body: map);
      print('Create Table Response: ${evidenceresponse.body}');
      if(200 == evidenceresponse.statusCode){
        return evidenceresponse.body;
      }
      else{
        return "error creating table";
      }
    }
    catch(e){
      return "error";
    }
  }
  static Future<List<Evidence>> getEvidence() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(EvidenceRoot,body:map);
      print('getEvidence Response: ${response.body}');
      if(200 == response.statusCode){
        List<Evidence> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Evidence>();
      }
    }catch(e){
      return List<Evidence>(); //return empty list on exception or error
    }
  }
  static List<Evidence> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Evidence>((json)=>Evidence.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addEvidence(String category_id, String item_description, String item_quantity) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_EVIDENCE_ACTION;
      map['category_id'] = category_id;
      map['item_description'] = item_description;
      map['item_quantity'] = item_quantity;
      final response = await http.post(EvidenceRoot,body:map);
      print('addEvidence Response: ${response.body}');
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
  static Future<String> updateEvidence(String evidence_id, String category_id, String item_description, String item_quantity) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_EVIDENCE_ACTION;
      map['evidence_id'] = evidence_id;
      map['category_id'] = category_id;
      map['item_description'] = item_description;
      map['item_quantity'] = item_quantity;
      final response = await http.post(EvidenceRoot,body:map);
      print('updateEvidence Response: ${response.body}');
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
  static Future<String> deleteEvidence(String evidenceId) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_EVIDENCE_ACTION;
      map['evidence_id'] = evidenceId;
      final response = await http.post(EvidenceRoot,body:map);
      print('deleteEvidence Response: ${response.body}');
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

