//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/Services/Officer.dart';
//
// class OfficerDataModel extends StatefulWidget{
//
// }
//
// SingleChildScrollView _dataBody(){
//   return SingleChildScrollView(
//     scrollDirection: Axis.vertical,
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns:[
//           DataColumn(label: Text('Officer_ID')),
//           DataColumn(label: Text('First Name')),
//           DataColumn(label: Text('Last Name'))
//         ],
//         rows: _officer.map((officer)=> DataRow(
//             cells: [
//               DataCell(Text(officer.officerID)),
//               DataCell(Text(officer.firstName.toUpperCase())),
//               DataCell(Text(officer.lastName.toUpperCase())),
//             ]
//         )
//         ).toList(),
//       ),
//     ),
//   );
// }