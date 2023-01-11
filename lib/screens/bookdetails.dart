import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/bookcard.dart';

class BookDetails extends StatefulWidget {
  BookDetails({super.key, this.data});
  var data;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool flag = true;
  String text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque lobortis nunc quis mollis fringilla. Aliquam eleifend venenatis mi, sit amet ultrices diam fermentum vel. Pellentesque vehicula ante a lorem tempor vestibulum. Sed fringilla, sapien vel vestibulum porttitor, velit est luctus ante, ut aliquam quam magna ut enim. Donec aliquam ligula sit amet erat ultrices fermentum. Vestibulum viverra est sit amet ipsum fermentum, eu rhoncus nibh euismod. Etiam ornare nisl sed justo pharetra, sit amet commodo arcu faucibus. Suspendisse potenti. Vestibulum facilisis ipsum at diam commodo semper";
  final String url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTANWGbuqGoD90H-cSb07u75M98rNCiFpBihA&usqp=CAU';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.network(
                widget.data["image"],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data["name"],
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.bookmark_border,
                    size: 32,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    itemSize: 20.0,
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Text(
                    widget.data["rating"].toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "By",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data["authorName"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.reviews_outlined), // icon
                      Text("Reviews"), // text
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.book_rounded), // icon
                      Text("Read"), // text
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.music_note_outlined), // icon
                      Text("Listen"), // text
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            const Text(
              "PROLOGUE",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            text.length > 200
                ? Column(
                    children: [
                      flag
                          ? Text(
                              widget.data["about"]
                                      .toString()
                                      .substring(0, 200) +
                                  "...",
                              textAlign: TextAlign.justify,
                              style: TextStyle())
                          : Text(
                              text,
                              textAlign: TextAlign.justify,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (() => setState(() {
                                    flag = !flag;
                                  })),
                              child: flag
                                  ? const Text(
                                      "more...",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  : const Text(
                                      "less...",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Text(text),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Similar Books",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.28,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('books')
                          .where("type", isEqualTo: widget.data["type"])
                          .snapshots(),
                      builder: (context, snapshot) {
                        var data = snapshot.data!.docs;
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (!snapshot.hasData) {
                          print('test phrase');
                          return const Text("data.....");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, index) {
                              return BookCard(
                                img: data[index]["image"],
                                bookName: data[index]["name"],
                                authorName: data[index]["authorName"],
                                data: data[index],
                              );
                            });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
