import 'package:flutter/material.dart';

class DynamicListPage extends StatelessWidget {
  final List<dynamic> items;

  DynamicListPage({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return ListTile(
                  title: Text(item.toString()),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => chatroompers(enrolls: items),
              //   ),
              // );
            },
            child: Text('Continue To Chat'),
          ),
        ],
      ),
    );
  }
}
