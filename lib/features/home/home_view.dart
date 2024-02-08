import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resume_builder/core/theme/app_colors.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/features/resume/pages/form_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? selectedImageIndex;

  Future<List<String>> getImageUrls() async {
    List<String> imageUrls = [];

    var listResult = await FirebaseStorage.instance.ref().listAll();

    for (var item in listResult.items) {
      var downloadUrl = await item.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getImageUrls(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
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
                          child: Image.network(snapshot.data?[index] ?? ""),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: AnimatedOpacity(
                          opacity: selectedImageIndex == index ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(Colors.blueGrey) ,
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
