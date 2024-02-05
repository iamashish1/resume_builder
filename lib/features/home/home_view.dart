import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resume_builder/core/theme/custom_theme.dart';
import 'package:resume_builder/features/resume/form_page.dart';

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
                            width: selectedImageIndex == index ? 4 : 1,
                            color: selectedImageIndex == index
                                ? Colors.black
                                : Theme.of(context).dividerColor,
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
                          child: ElevatedButton(
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
