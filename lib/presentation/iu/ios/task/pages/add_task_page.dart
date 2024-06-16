import 'package:flutter/cupertino.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(''),
      ),
      child: Container(),
    );
  }
}