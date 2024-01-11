// import 'package:androidstudio_flutter/meta/views/home/profile.view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'constants.view.dart';
// import 'messages.dart';
//
// class Chatroompers extends StatefulWidget {
//   final int booking_id;
//   const Chatroompers({Key? key, required this.booking_id}) ;
//
//   //
//   // static Route<void> route() {
//   //   return MaterialPageRoute(
//   //     builder: (context) => const Chatroompers(booking_id: booking_id),
//   //   );
//   // }
//
//   @override
//   State<Chatroompers> createState() => _ChatroompersState();
// }
//
// class _ChatroompersState extends State<Chatroompers> {
//
//   late final Stream<List<Message>> _messagesStream;
//   final Map<String, Profile> _profileCache = {};
//
//
//   @override
//   void initState() {
//     final myUserId = supabase.auth.currentUser!.id;
//     _messagesStream = supabase
//         .from('messages')
//         .stream(primaryKey: ['id'])
//         .order('created_at')
//         .map((maps) => maps
//         .map((map) => Message.fromMap(map: map, myUserId: myUserId))
//         .toList());
//     print("--------messeage stream-------------");
//     print(_messagesStream);
//
//     super.initState();
//
//
//     Future<void> _loadProfileCache(String profileId) async {
//       if (_profileCache[profileId] != null) {
//         return;
//       }
//       final data =
//       await supabase.from('profiles').select().eq('id', profileId).single();
//       final profile = Profile.fromMap(data);
//       setState(() {
//         _profileCache[profileId] = profile;
//       });
//     }
//
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('chat'),),
//       body: StreamBuilder<List<Message>>(
//     stream: _messagesStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final messages = snapshot.data!;
//           print("============messages==============");
//           print(messages[0].id);
//           return Column(
//             children: [
//               Expanded(
//                 child: messages.isEmpty
//                     ? const Center(
//                   child: Text('Start your conversation now :)'),
//                 )
//                     : ListView.builder(
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//
//                     /// I know it's not good to include code that is not related
//                     /// to rendering the widget inside build method, but for
//                     /// creating an app quick and dirty, it's fine 😂
//                     ///
//                     ///
//                     ///
//                     ///
//                     _loadProfileCache(message.profileId);
//
//                     return _ChatBubble(
//                       message: message,
//                       profile: _profileCache[message.profileId],
//                     );
//                   },
//                 ),
//               ),
//               const _MessageBar(),
//             ],
//           );
//         } else {
//           return preloader;
//         }
//       },
//     ),
//     );
//   }
// }
