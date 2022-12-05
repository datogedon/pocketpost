import 'package:flutter/material.dart';
import 'package:pocketpost/pages/edit_message.dart';
import 'package:pocketpost/provider/posts_provider.dart';
import 'package:provider/provider.dart';

import 'pages/send_message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PostsProvider>(
              create: (context) => PostsProvider()),
        ],
        builder: (context, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: const MyHomePage(title: 'PocketBase Demo'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostsProvider>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...context
                .watch<PostsProvider>()
                .posts
                .map((post) => ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.id),
                      leading: Icon(Icons.message),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(child: Icon(Icons.edit, color: Colors.green,), onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => EditMessagePage(post: post)));
                          }),
                          VerticalDivider(),
                          InkWell(child: Icon(Icons.delete, color: Colors.red,), onTap:(){
                            showDialog(context: context, builder: (contextDialog){
                              return AlertDialog(
                                title: Text("Advertencia"),
                                content: Text("¿Estás seguro de eliminar este mensaje?"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(contextDialog);
                                  }, child: Text("Cancelar")),
                                  TextButton(onPressed: (){
                                    context.read<PostsProvider>().deletePostPobketBase(post.id);
                                    Navigator.pop(contextDialog);
                                  }, child: Text("Confirmar"))
                                ],
                              );
                            });
                          }),
                        ],
                      ),
                    ))
                .toList(),
            const SendMessagePage()
          ],
        ),
      ),
    );
  }
}
