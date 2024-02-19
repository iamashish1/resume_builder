import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/features/home/home_view.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  Future<List<FirebaseTemplateModel>> getLikedTemplates() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Template')
        .where('likedBy', arrayContains: userId)
        .get();

    List<FirebaseTemplateModel> likedTemplates = [];

    for (var doc in snapshot.docs) {
      var data = doc.data();
      FirebaseTemplateModel template = FirebaseTemplateModel(
        id: data['id'] ?? 0,
        likedBy: List.from(data['likedBy'] ?? []),
        url: data['url'] ?? "",
        docId: doc.id,
      );
      likedTemplates.add(template);
    }

    return likedTemplates;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLikedTemplates(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
             return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, index) {
                return Image(image:NetworkImage(snapshot.data?[index].url??""));
              });
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
         
        });
  }
}
