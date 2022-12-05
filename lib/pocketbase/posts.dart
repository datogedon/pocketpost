import 'dart:convert';

import 'package:pocketbase/pocketbase.dart';
import 'package:pocketpost/models/post.dart';
import 'package:pocketpost/models/request/post.dart';

PocketBase pb = PocketBase('http://127.0.0.1:8090');

class MyPocketBase {

  static Future getPosts() async {
    return await pb.records.getFullList('posts', batch: 200, sort: '-created');
  }

  static Future addPost(PostRequest post) async {
    return await pb.records.create('posts', body: post.toJson());
  }

  static Future updatePost(PostRequest post, String id) async {
    return await pb.records.update('posts', id, body: post.toJson());
  }

  static Future deletePost(String id) async {
    return await pb.records.delete('posts', id);
  }

  static Future<RealtimeService> realtime() async {
    return pb.realtime;
  }
}
