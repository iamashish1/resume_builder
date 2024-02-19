import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/features/resume/pages/form_page.dart';

class HomeView extends StatefulWidget {
  final bool isHome;
  const HomeView({super.key, required this.isHome});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? selectedImageIndex;
  List<FirebaseTemplateModel> templates = [];

  Future<void> toggleLike(FirebaseTemplateModel? template) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print("${userId} MUJI");

    String templateDocId = template?.docId ?? '';
    print("${templateDocId} MUJI2");

    if (template?.likedBy.contains(userId) ?? false) {
      // User has already liked, so remove like
      await FirebaseFirestore.instance
          .collection('Template')
          .doc(templateDocId)
          .update({
        'likedBy': FieldValue.arrayRemove([userId]),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Removed From Favourite')));
      }
    } else {
      // User has not liked, so add like
      await FirebaseFirestore.instance
          .collection('Template')
          .doc(templateDocId)
          .update({
        'likedBy': FieldValue.arrayUnion([userId]),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Added To Favourite')));
      }
    }
  }

  Future<List<FirebaseTemplateModel>> getImageUrls() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Template')
        .orderBy('id')
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      FirebaseTemplateModel template = FirebaseTemplateModel(
        id: data['id'] ?? 0,
        likedBy: List.from(data['likedBy'] ?? []),
        url: data['url'] ?? "",
        docId: doc.id,
      );
      templates.add(template);
    }

    return templates;
  }
    @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset templates list when the view changes
    if (widget.isHome != oldWidget.isHome) {
      templates.clear();
    }
  }


  //FOR LIKES PAGE

  Future<List<FirebaseTemplateModel>> getLikedTemplates() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Template')
        .where('likedBy', arrayContains: userId)
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      FirebaseTemplateModel template = FirebaseTemplateModel(
        id: data['id'] ?? 0,
        likedBy: List.from(data['likedBy'] ?? []),
        url: data['url'] ?? "",
        docId: doc.id,
      );
      templates.add(template);
    }

    return templates;
  }

  //

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseTemplateModel>>(
      future: widget.isHome == true ? getImageUrls() : getLikedTemplates(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: templates.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedImageIndex =
                          selectedImageIndex == index ? null : index;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: selectedImageIndex == index ? 3 : 1,
                            color: selectedImageIndex == index
                                ? Colors.blueGrey
                                : Colors.grey,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            templates[index].url,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.7),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            padding: const EdgeInsets.all(3),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  // Toggle like
                                  await toggleLike((templates[index]));

                                  // Update the like status in the templates list
                                  setState(() {
                                    if (templates[index].likedBy.contains(
                                        FirebaseAuth
                                            .instance.currentUser?.uid)) {
                                      templates[index].likedBy.remove(
                                          FirebaseAuth
                                              .instance.currentUser?.uid);
                                    } else {
                                      templates[index].likedBy.add(FirebaseAuth
                                          .instance.currentUser?.uid);
                                    }
                                  });
                                },
                                icon: Icon(
                                  (templates[index].likedBy.contains(
                                          FirebaseAuth
                                              .instance.currentUser?.uid))
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: AppColors.primaryRed,
                                )),
                          )),
                      Positioned(
                        bottom: 10,
                        child: AnimatedOpacity(
                          opacity: selectedImageIndex == index ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: Colors
                                      .grey)), // Set the color of the outline
                            ),
                            onPressed: (selectedImageIndex == index)
                                ? () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FormPage()));
                                  }
                                : null,
                            child: const Text(
                              'Select Template',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class FirebaseTemplateModel {
  String url;
  int id;
  List likedBy;
  String docId;

  FirebaseTemplateModel(
      {required this.id,
      required this.likedBy,
      required this.url,
      required this.docId});
}
