// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';
// import '../../../core/notifier/database.notifier.dart';
//
// class listview extends StatefulWidget {
//   const listview({Key? key}) : super(key: key);
//
//   @override
//   State<listview> createState() => _listviewState();
// }
//
// class _listviewState extends State<listview> {
//
//   @override
//   Widget build(BuildContext context) {
//     // final DatabaseNotifier databaseNotifier=Provider.of<DatabaseNotifier>(context,listen: false);
//     final DatabaseNotifier databaseNotifier=Provider.of<DatabaseNotifier>(context,listen: false);
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "HomePage",
//           style: TextStyle(color: Colors.orange),
//         ),
//         titleSpacing: 00.0,
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         toolbarHeight: 60.2,
//         toolbarOpacity: 0.8,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25)),
//         ),
//         elevation: 10,
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               // FirebaseAuth.instance.signOut();
//             },
//             color: Colors.orange,
//             iconSize: 30,
//             icon: const Icon(
//               Icons.back_hand_outlined,
//             ),
//           )
//         ],
//       ),
//       body:
//
//
//
//         ListView(
//         padding: const EdgeInsets.all(8),
//         children: <Widget>[
//           Container(
//             height: 50,
//             color: Colors.amber[600],
//             child:  Center(child: Text(x[0]['name'])),
//           ),
//           Container(
//             height: 50,
//             color: Colors.amber[500],
//             child: const Center(child: Text('Entry B')),
//           ),
//           Container(
//             height: 50,
//             color: Colors.amber[100],
//             child: const Center(child: Text('Entry C')),
//           ),
//         ],
//       ),
//     );
//   }
// }
