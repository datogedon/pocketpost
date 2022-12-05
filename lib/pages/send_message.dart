import 'package:flutter/material.dart';
import 'package:pocketpost/provider/posts_provider.dart';
import 'package:provider/provider.dart';

class SendMessagePage extends StatelessWidget {
  const SendMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.withAlpha(60),
                  filled: true
                ),
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  fillColor: Colors.grey.withAlpha(60),
                  filled: true
                ),
              ),
              ElevatedButton(onPressed: (){
                context.read<PostsProvider>().addPostPobketBase(
                  _titleController.text,
                  _contentController.text
                );
                _contentController.clear();
                _titleController.clear();
              }, child: const Text('Send'))
            ],
          ),
    );
  }
}
