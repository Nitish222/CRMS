import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/User.dart';
import 'User.dart';

class Authenticate{
  //static const AUTH = 'http://localhost/CRMSDB/User_actions.php';
  static const AUTH = 'https://c-r-m-s.000webhostapp.com/User_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const LOGIN = 'LOGIN';
  static const REG = 'REG';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final response = await http.post(AUTH,body: map);
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
  static Future<String> login(String id, String password) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = LOGIN;
      map['id']= id;
      map['pass'] = password;
      final response = await http.post(AUTH,body:map);
      print('Login Response: ${response.body}');
      //print("response"+jsonDecode(response.body.toString()));
      if(200 == response.statusCode){
        if(jsonDecode(response.body)=="no user") {
          return "Create Account!!";
        }
        else{
          if(jsonDecode(response.body)=="true"){
              return "success";
          }
          else{
              return "incorrect password";
          }
        }
      }
      else{
        return "error";
      }
    }catch(e){
      return "error"; //return empty list on exception or error
    }
  }
  static List<User> parseResponse(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String,dynamic>>();
    return parsed.map<User>((json)=>User.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> register(String password, String rank) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = REG;
      map['user_password'] = password;
      map['user_rank'] = rank;
      final response = await http.post(AUTH,body:map);
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
}