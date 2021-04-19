import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/EvidenceCategoryServices/Statement.dart';


class StatementAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const StatementRoot = 'https://c-r-m-s.000webhostapp.com/statement_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_STATEMENT_ACTION = 'ADD_STATEMENT';
  static const UPDATE_STATEMENT_ACTION = 'UPDATE_STATEMENT';
  static const DELETE_STATEMENT_ACTION = 'DELETE_STATEMENT';

  static get statments => null;

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final response = await http.post(StatementRoot,body: map);
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
  static Future<List<Statement>> getStatement() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(StatementRoot,body:map);
      print('getStatement Response: ${response.body}');
      if(200 == response.statusCode){
        List<Statement> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Statement>();
      }
    }catch(e){
      return List<Statement>(); //return empty list on exception or error
    }
  }
  static List<Statement> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
    return parsed.map<Statement>((json)=>Statement.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addStatement(String statements) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_STATEMENT_ACTION;
      map['statements'] = statements;
      final response = await http.post(StatementRoot,body:map);
      print('addStatement Response: ${response.body}');
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
  static Future<String> updateStatement(String statement_id, String statements) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_STATEMENT_ACTION;
      map['statement_id'] = statement_id;
      map['statements'] = statements;
      final response = await http.post(StatementRoot,body:map);
      print('updateStatement Response: ${response.body}');
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
  static Future<String> deleteStatement(String statement_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_STATEMENT_ACTION;
      map['statement_id'] = statement_id;
      final response = await http.post(StatementRoot,body:map);
      print('deleteStatement Response: ${response.body}');
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

