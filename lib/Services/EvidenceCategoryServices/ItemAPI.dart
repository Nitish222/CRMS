import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Services/EvidenceCategoryServices/Item.dart';


class ItemAPI{
  //static const ROOT = 'http://localhost/CRMSDB/officer_actions.php';
  static const ItemRoot = 'https://c-r-m-s.000webhostapp.com/CategoryItemId_actions.php';
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const GET_ALL_ACTION = 'GET_ALL';
  static const ADD_ITEM_ACTION = 'ADD_CATEGORYITEM';
  static const UPDATE_ITEM_ACTION = 'UPDATE_CATEGORYITEM';
  static const DELETE_ITEM_ACTION = 'DELETE_CATEGORYITEM';
  static const GET_A_ITEM_ACTION = 'GET_ITEM';

  //Method to create table
  static Future<String> createTable() async{
    try{
      //add parameters to pass request
      var map = Map<String,dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      final response = await http.post(ItemRoot,body: map);
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
  static Future<List<Item>> getAItem(String categoryId) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_A_ITEM_ACTION;
      map['category_id'] = categoryId;
      final response = await http.post(ItemRoot,body:map);
      print('getItem Response: ${response.body}');
      if(200 == response.statusCode){
        List<Item> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Item>();
      }
    }catch(e){
      return List<Item>(); //return empty list on exception or error
    }
  }
  static Future<List<Item>> getItem() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = GET_ALL_ACTION;
      final response = await http.post(ItemRoot,body:map);
      print('getItem Response: ${response.body}');
      if(200 == response.statusCode){
        List<Item> list = parseResponse(response.body);
        return list;
      }
      else{
        return List<Item>();
      }
    }catch(e){
      return List<Item>(); //return empty list on exception or error
    }
  }
  static List<Item> parseResponse(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String,dynamic>>();
    return parsed.map<Item>((json)=>Item.fromJson(json)).toList();
  }

  //Method to add officer
  static Future<String> addItem(String itemName,String CategoryId) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = ADD_ITEM_ACTION;
      map['category_id']  = CategoryId;
      map['item_name'] = itemName;

      final response = await http.post(ItemRoot,body:map);
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
  static Future<String> updateCase(String itemId, String itemName) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_ITEM_ACTION;
      map['item_id'] = itemId;
      map['item_name'] = itemName;

      final response = await http.post(ItemRoot,body:map);
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
  static Future<String> deleteItem(String itemId) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = DELETE_ITEM_ACTION;
      map['item_id'] = itemId;
      final response = await http.post(ItemRoot,body:map);
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