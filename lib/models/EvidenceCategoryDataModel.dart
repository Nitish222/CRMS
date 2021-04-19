import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/EvidenceCategory.dart';
import 'package:myapp/Services/EvidenceCategoryServices/EvidenceCatAPI.dart';
import 'package:myapp/Services/EvidenceCategoryServices/Item.dart';
import 'package:myapp/Services/EvidenceCategoryServices/ItemAPI.dart';

class EvidenceDataModel extends StatefulWidget{
  EvidenceDataModel():super();
  final String title = 'Add Evidence';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<EvidenceDataModel>{
  List<EvidenceCategory> _cat;
  List<Item> _item;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  TextEditingController _categoryController;
  TextEditingController _itemController;
  TextEditingController _categoryIdController;
  String categoryId;
  @override
  void initState(){
    super.initState();
    //for users
    _cat = [];
    _item = [];
    _titleProgress = widget.title;
    _categoryController = TextEditingController();
    _itemController = TextEditingController();
    _categoryIdController = TextEditingController();
  }
  _updateCategory(EvidenceCategory category){
    setState(() {
      _isUpdating = true;
    });
    // String des= _CaseDescController.text;
    // String sta = _CaseStatusController.text;
    // print(caseID+" "+des+" "+sta);
    _showProgress('Updating item....');
    EvidenceCatAPI.updateCat(category.category_id, _categoryController.text).then((result){
      if("success" == result){
        _getAllEvidenceCat(); //Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });

  }
  _updateItem(Item items){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating item....');
    ItemAPI.updateCase(items.item_id, _itemController.text).then((result){
      if("success" == result){
        _getAllItem(); //Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });

  }
  SingleChildScrollView _itemdataBody(){
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns:[
            DataColumn(label: Text('item_id')),
            DataColumn(label: Text('Category_id')),
            DataColumn(label: Text('item_name')),
            DataColumn(label: Text('Update')),
            DataColumn(label: Text('Delete')),
            //DataColumn(label: Text('Open')),
          ],
          rows: _item.map((items)=> DataRow(
              cells: [
                DataCell(Text(items.item_id)),
                DataCell(Text(items.category_id)),
                DataCell(Text(items.item_name.toUpperCase())),
                DataCell(ElevatedButton(child: Text('UPDATE'),onPressed: (){ showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                            height: 400.0,
                            width: 360.0,
                            child:  ListView(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child:SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 60,
                                        child: new TextFormField(
                                          controller: _itemController,
                                          decoration: const InputDecoration(
                                              labelText: 'New Item Name',
                                              icon: const Padding(
                                                  padding: const EdgeInsets.only(top: 15.0),
                                                  child: const Icon(Icons.supervised_user_circle))),
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                                      child:SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: 80,
                                          child: ElevatedButton(
                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                              overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                            ),
                                            child: Text('Submit',style: TextStyle(fontSize: 40,color: Colors.black),),
                                            onPressed: (){
                                              _updateItem(items);
                                            },
                                          )
                                      )
                                  ),
                                ]
                            ),
                          )
                      );
                    }); },)),
                DataCell(ElevatedButton(child: Text('DELETE'),onPressed: (){ _deleteItem(items);
                  },)),
                //DataCell(ElevatedButton(child: Text('VIEW CASE'),onPressed: (){ navigateToCaseDetailsDashboard(); },)),
              ]
          )
          ).toList(),
        )
    );
  }
  _getAllEvidenceCat(){
    _showProgress('Loading Evidence...');
    EvidenceCatAPI.getCat().then((category){
      setState(() {
        _cat = category;
        //_setid(_cat.map((category) => category.category_id).toString());
        //print(_cat.map((category) => category.category_id.toString()));
      });
      _showProgress(widget.title);
      print("Length ${category.length}");
    });

  }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
  _deleteCategory(EvidenceCategory category){
    _showProgress('Deleting Category....');
    print("id is:"+category.category_id);
      EvidenceCatAPI.deleteCat(category.category_id).then((result){
      if("success" == result){
        _getAllEvidenceCat(); //Refresh after delete...
      }
    });
  }
  _deleteItem(Item items){
    _showProgress('Deleting Item....');
    //String itemid = items.item_id.toString();
    ItemAPI.deleteItem(items.item_id).then((result){
      if("success" == result){
        _getAllItem(); //Refresh after delete...
      }
    });
  }

  _addCat(){
    _showProgress('Adding Case...');
    EvidenceCatAPI.addCat(_categoryController.text).then((result){
      if("success"==result){
        _getAllEvidenceCat(); //Refresh the list
        _clearValues();
      }
    });
  }
  _getAllItem(){
    _showProgress('Loading Items...');
    ItemAPI.getItem().then((items){
      setState(() {
        _item = items;
      });
      _showProgress(widget.title);
      print("Length ${items.length}");
    });
  }
  _getItems(category){
    _showProgress('Loading Items...');
    ItemAPI.getAItem(category.category_id.toString()).then((items){
      setState(() {
        _item = items;
      });
      _showProgress(widget.title);
      print("Length ${items.length}");
    });
  }

  _addItem(){
     print(_categoryIdController.text);
     print(_itemController.text);
    _showProgress('Adding Item...');
    ItemAPI.addItem(_itemController.text,_categoryIdController.text).then((result){
      if("success"==result){
        _getAllItem(); //Refresh the list
        _clearValues();
      }
    });
  }


  _clearValues(){
    _categoryController.text = '';
    _itemController.text ='';
    _categoryIdController.text = '';
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: DataTable(
            columns:[
              DataColumn(label: Text('category_id')),
              DataColumn(label: Text('category_name')),
              DataColumn(label: Text('Update')),
              DataColumn(label: Text('Delete')),
              DataColumn(label: Text('View')),
            ],

            rows: _cat.map((category)=> DataRow(
                cells: [
                  DataCell(Text(category.category_id)),
                  DataCell(Text(category.category_name.toUpperCase())),
                  DataCell(ElevatedButton(child: Text('UPDATE'),onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            elevation: 16,
                            child: Container(
                              height: 400.0,
                              width: 360.0,
                              child:  ListView(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child:SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: 60,
                                          child: new TextFormField(
                                            controller: _categoryController,
                                            decoration: const InputDecoration(
                                                labelText: 'New Category Name',
                                                icon: const Padding(
                                                    padding: const EdgeInsets.only(top: 15.0),
                                                    child: const Icon(Icons.supervised_user_circle))),
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                                        child:SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            height: 80,
                                            child: ElevatedButton(
                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                              ),
                                              child: Text('Submit',style: TextStyle(fontSize: 40,color: Colors.black),),
                                              onPressed: (){
                                                    _updateCategory(category);
                                              },
                                            )
                                        )
                                    ),
                                  ]
                              ),
                            )
                        );
                      });
                    },
                  )
                  ),
                  DataCell(ElevatedButton(child: Text('DELETE'),onPressed: (){ _deleteCategory(category);},)),
                  DataCell(ElevatedButton(child: Text('VIEW CATEGORY ITEMS'),onPressed: (){
                    _getItems(category);
                    showDialog(
                        context: context,
                        builder: (context)
                        {
                          return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: Container(
                                height: 600.0,
                                width: 600.0,
                                child: Column(
                                    children: <Widget>[
                                      _itemdataBody(),
                                    ]
                                ),
                              )
                          );
                        }
                    );
                    //CategoryItemDataModel()
                     },)),
                ]
            )
            ).toList(),
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_titleProgress),
        actions: <Widget>[
          ElevatedButton(child: Text('Add Category'),onPressed: (){
            showDialog(
                context: context,
                builder: (context)
                {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 400.0,
                        width: 360.0,
                        child: ListView(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _categoryController,
                                      decoration: const InputDecoration(
                                          labelText: 'New Category',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 40.0,
                                      right: 40.0,
                                      top: 20.0,
                                      bottom: 20.0),
                                  child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 80,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Colors.green),
                                          overlayColor: MaterialStateProperty.all<
                                              Color>(Colors.red),
                                        ),
                                        child: Text('Submit', style: TextStyle(
                                            fontSize: 40, color: Colors.black),),
                                        onPressed: () {
                                          _addCat();
                                        },
                                      )
                                  )
                              ),
                            ]
                        ),
                      )
                  );
                }
            );
          }),

          ElevatedButton(child: Text('Add Item'),onPressed: (){
            showDialog(
                context: context,
                builder: (context)
                {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 400.0,
                        width: 360.0,
                        child: ListView(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _itemController,
                                      decoration: const InputDecoration(
                                          labelText: 'New Item',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _categoryIdController,
                                      decoration: const InputDecoration(
                                          labelText: 'Add Category ID Tag',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 40.0,
                                      right: 40.0,
                                      top: 20.0,
                                      bottom: 20.0),
                                  child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 80,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Colors.green),
                                          overlayColor: MaterialStateProperty.all<
                                              Color>(Colors.red),
                                        ),
                                        child: Text('Submit', style: TextStyle(
                                            fontSize: 40, color: Colors.black),),
                                        onPressed: () {
                                          _addItem();
                                        },
                                      )
                                  )
                              ),
                            ]
                        ),
                      )
                  );
                }
            );
          }),

          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _getAllEvidenceCat();
              }
          ),
        ],
      ),
      body:Center(child: _dataBody())
    );
  }

}