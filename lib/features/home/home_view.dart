import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/ads/show_interstitial_ads.dart';
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

    String templateDocId = template?.docId ?? '';

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

  Future<void> getImageUrls() async {
    try {
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
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } on SocketException catch (_) {
    } catch (_) {
    }
  }

  //FOR LIKES PAGE

  Future<void> getLikedTemplates() async {
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
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = true;

  @override
  void initState() {
    widget.isHome == true ? getImageUrls() : getLikedTemplates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (templates.isEmpty) {
                  return const Center(child: Text('No Templates Found'));
                } else {
                  return ListView.builder(
                    itemCount: templates.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
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
                                  child: CachedNetworkImage(
                                    imageUrl: templates[index].url,
                                    errorWidget: (context, error, stackTrace) =>
                                        const Icon(Icons.image_sharp),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
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
                                          templates[index].likedBy.add(
                                              FirebaseAuth
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
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                child: AnimatedOpacity(
                                  opacity:
                                      selectedImageIndex == index ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blueGrey),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Colors
                                                  .grey)), // Set the color of the outline
                                    ),
                                    onPressed: (selectedImageIndex == index)
                                        ? () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        FormPage(
                                                          id: templates[index]
                                                              .id,
                                                        )))
                                                .then((value) {
                                              showInterstitialAd();
                                            });
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
                }
              }
            },
          ),
        ),
      ],
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
