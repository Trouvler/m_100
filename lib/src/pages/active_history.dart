import 'package:flutter/material.dart';
import 'package:m_100/src/components/post_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _postList(){
    return Column(
      children: List.generate(10, (index) => const PostWidget()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),body: SingleChildScrollView(child: _postList(),),
    );
  }
}
