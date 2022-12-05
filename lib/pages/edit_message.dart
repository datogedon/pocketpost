import 'package:flutter/material.dart';
import 'package:pocketpost/models/post.dart';
import 'package:pocketpost/provider/posts_provider.dart';
import 'package:provider/provider.dart';

class EditMessagePage extends StatefulWidget {
  Post post;
  EditMessagePage({Key? key, required this.post}) : super(key: key);

  @override
  State<EditMessagePage> createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.post.title;
    _contentController.text = widget.post.content;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Message"),
      ),
      body: Center(
        child: Padding(
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
                context.read<PostsProvider>().updatePostPobketBase(
                    _titleController.text,
                    _contentController.text,
                  widget.post.id
                );
                Navigator.pop(context);
              }, child: const Text('Send'))
            ],
          ),
        ),
      ),
    );
  }
}
