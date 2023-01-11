import 'package:flutter/material.dart';

import '../screens/bookdetails.dart';

class BookCard extends StatelessWidget {
  BookCard({super.key, this.img, this.bookName, this.authorName, this.data});
  String? img;
  String? bookName;
  String? authorName;
  var data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(
                      data: data,
                    )),
          )),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 140,
              padding: const EdgeInsets.all(4.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              child: Image.network(
                img!,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              this.bookName!.length > 14
                  ? this.bookName!.substring(0, 14)
                  : this.bookName!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              this.authorName!.length > 14
                  ? this.authorName!.substring(0, 14)
                  : this.authorName!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
