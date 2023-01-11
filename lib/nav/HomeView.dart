import 'dart:ui';

import 'package:book_store/service/service.dart';
import 'package:book_store/utils/bookcard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String urll =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU0ABkrXF_pDdjxd6mpUCLhibeKlihKsBuJlsMRnvvA1ZpYrFh58PZa7fAQAxsVToi2TI&usqp=CAU';
  final String url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTANWGbuqGoD90H-cSb07u75M98rNCiFpBihA&usqp=CAU';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Service _service = Service();

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(width: 1, color: Colors.grey)),
            width: width * 0.8,
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type a book name or author",
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _service.carousalBookStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 240,
                        pageSnapping: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index, realIndex) {
                        var data = snapshot.data!.docs;
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              data[index]["image"],
                              height: 120.0,
                              width: 140.0,
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Top",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "more->",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.28,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _service.topBookStream,
                    builder: (context, snapshot) {
                      var data = snapshot.data!.docs;
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (!snapshot.hasData) {
                        print('test phrase');
                        return const Text("data.....");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Recommended",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "more->",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.28,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _service.recBookStream,
                    builder: (context, snapshot) {
                      var data = snapshot.data!.docs;
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (!snapshot.hasData) {
                        print('test phrase');
                        return const Text("data.....");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
          )
        ],
      ),
    );
  }
}
