import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketpost/models/post.dart';
import 'package:pocketpost/models/request/post.dart';
import 'package:pocketpost/pocketbase/posts.dart';

class PostsProvider with ChangeNotifier{

  PostsProvider(){
    realtime();
  }

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }
  void updatePost(Post post){
    _posts[_posts.indexWhere((element) => element.id == post.id)] = post;
    notifyListeners();
  }

  void deletePost(Post post){
    _posts.removeWhere((element) => element.id == post.id);
    notifyListeners();
  }


  getPosts() async {
    List<RecordModel> result = await MyPocketBase.getPosts();
    result.map((post) {
      post.data['id'] = post.id;
      Post _post = Post.fromJson(post.data);
      addPost(_post);
    }).toList();
    notifyListeners();
  }

  Future<void> addPostPobketBase(String title, String content) async {
    PostRequest post = PostRequest(title: title, content: content);
    await MyPocketBase.addPost(post);
  }

  Future<void> updatePostPobketBase(String title, String content, String id) async {
    PostRequest post = PostRequest(title: title, content: content);
    await MyPocketBase.updatePost(post, id);
  }

  Future<void> deletePostPobketBase(String id) async {
    await MyPocketBase.deletePost(id);
  }

  Future<void> realtime() async {
    RealtimeService response = await MyPocketBase.realtime();
    response.subscribe('posts', (SubscriptionEvent event) {
      switch (event.action){
        case 'create':
          event.record!.data['id'] = event.record!.id;
          addPost(Post.fromJson(event.record!.data));
          break;
        case 'update':
          event.record!.data['id'] = event.record!.id;
          updatePost(Post.fromJson(event.record!.data));
          break;
        case 'delete':
          event.record!.data['id'] = event.record!.id;
          deletePost(Post.fromJson(event.record!.data));
          break;
      }
    });
  }
}