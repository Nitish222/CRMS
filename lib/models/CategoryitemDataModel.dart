// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CategoryitemidDataModel extends StatefulWidget{
//   CategoryitemidDataModel():super();
//   final String title = 'Add ItemCategory';
//   @override
//   _DataModel_State createState()=>_DataModel_State();
//
// }
//
// //Category_item_ID	Category_id	Item_name
//
//
//
// class _DataModel_State extends State<CategoryitemidDataModel>{
//   List<> _case;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool _isUpdating;
//   String _titleProgress;
//   @override
//   void initState(){
//     super.initState();
//     //for users
//     _case = [];
//     _titleProgress = widget.title;
//   }
//   _getAllCategoryitemid(){
//     _showProgress('Loading ItemCategory...');
//     CategoryitemidAPI.getCategoryitemid().then((categoryitemids){
//       setState(() {
//         _categoryitemid = categoryitemids;
//       });
//       _showProgress(widget.title);
//       print("Length ${categoryitemids.length}");
//     });
//   }
//   _showProgress(String message){
//     setState(() {
//       _titleProgress = message;
//     });
//   }
//
//   SingleChildScrollView _dataBody(){
//     return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Align(
//           alignment: Align.,
//           child: DataTable(
//             columns:[
//               DataColumn(label: Text('category_item_id')),
//               DataColumn(label: Text('category_id')),
//               DataColumn(label: Text('item_name')),
//             ],
//             rows: _categoryitemid.map((categoryitemids)=> DataRow(
//                 cells: [
//                   DataCell(Text(categoryitemids.category_item_id)),
//                   DataCell(Text(categoryitemids.category_id.toUpperCase())),
//                   DataCell(Text(categoryitemids.item_name.toUpperCase())),
//                 ]
//             )
//             ).toList(),
//           ),
//         )
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(_titleProgress),
//         actions: <Widget>[
//           IconButton(icon: Icon(Icons.refresh),
//               onPressed: (){
//                 _getAllCategoryitemid();
//               }
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _dataBody(),
//         ],
//       ),
//     );
//   }
//
// }