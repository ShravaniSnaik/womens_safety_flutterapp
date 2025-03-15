import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/PrimaryButton.dart';
import 'package:flutter_demo/components/custom_textfield.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/constants.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController locationC = TextEditingController();
  final TextEditingController viewsC = TextEditingController();
  bool isSaving = false;
  double ratings = 1.0; // Default rating

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10.0),
          title: Text("Review your place"),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter location',
                    controller: locationC,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: viewsC,
                    hintText: 'Enter your review',
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 15),
                RatingBar.builder(
                  initialRating: ratings,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  unratedColor: Colors.grey.shade300,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) =>
                          const Icon(Icons.star, color: kColorDarkRed),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratings = rating;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            PrimaryButton(
              title: "SAVE",
              onPressed: () {
                saveReview();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveReview() async {
    if (locationC.text.isEmpty || viewsC.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter all fields');
      return;
    }

    setState(() {
      isSaving = true;
    });

    await FirebaseFirestore.instance
        .collection('reviews')
        .add({
          'location': locationC.text,
          'views': viewsC.text,
          'ratings': ratings,
        })
        .then((value) {
          setState(() {
            isSaving = false;
            locationC.clear();
            viewsC.clear();
            ratings = 1.0; // Reset rating
          });
          Fluttertoast.showToast(msg: 'Review uploaded successfully');
        })
        .catchError((error) {
          setState(() {
            isSaving = false;
          });
          Fluttertoast.showToast(msg: 'Error uploading review');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isSaving
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Recent Reviews",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream:
                            FirebaseFirestore.instance
                                .collection('reviews')
                                .snapshots(),
                        builder: (
                          context,
                          AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(child: Text("No reviews yet."));
                          }

                          return ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Location: ${data['location']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Comments: ${data['views']}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        RatingBar.builder(
                                          initialRating:
                                              (data['ratings'] as num?)
                                                  ?.toDouble() ??
                                              1.0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          ignoreGestures: true,
                                          unratedColor: Colors.grey.shade300,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                          itemBuilder:
                                              (context, _) => const Icon(
                                                Icons.star,
                                                color: kColorDarkRed,
                                              ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          showAlert(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
