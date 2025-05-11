// Testimony model class
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class Testimony {
  final String name;
  final String testimony;
  final String imageUrl;

  Testimony({
    required this.name,
    required this.testimony,
    required this.imageUrl,
  });
}

// Sample testimonies data
final List<Testimony> allTestimonies = [
  Testimony(
    name: "Sarah Johnson",
    testimony:
        "This product completely transformed my daily routine. I can't imagine going back to my old way of doing things. The efficiency and ease of use are unmatched.",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvi7HpQ-_PMSMOFrj1hwjp6LDcI-jm3Ro0Xw&s",
  ),
  Testimony(
    name: "Michael Chen",
    testimony:
        "As a professional in this field, I can confidently say this is one of the best solutions I've encountered. The attention to detail is remarkable.",
    imageUrl:
        "https://media.istockphoto.com/id/1196391449/photo/portrait-of-african-woman.jpg?s=612x612&w=0&k=20&c=b-hwtJGyg5Y-hwG-9id9D3hb71TmaqyDlfU-Ps3GA2s=",
  ),
  Testimony(
    name: "Emma Davis",
    testimony:
        "What impressed me most was the customer support. They went above and beyond to ensure I had the best experience possible.",
    imageUrl:
        "https://plus.unsplash.com/premium_photo-1688740375397-34605b6abe48?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGVvcGxlJTIwZmFjZXxlbnwwfHwwfHx8MA%3D%3D",
  ),
  Testimony(
    name: "James Wilson",
    testimony:
        "I was skeptical at first, but after using it for a month, I'm completely convinced. The results speak for themselves.",
    imageUrl:
        "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ),
  Testimony(
    name: "Lisa Martinez",
    testimony:
        "The quality and value for money are exceptional. I've already recommended it to all my colleagues and friends.",
    imageUrl:
        "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg",
  ),
];

// Testimonial Carousel Widget
class TestimonialCarousel extends StatefulWidget {
  const TestimonialCarousel({super.key});

  @override
  State<TestimonialCarousel> createState() => _TestimonialCarouselState();
}

class _TestimonialCarouselState extends State<TestimonialCarousel> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: allTestimonies.map((testimony) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circular Image
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(testimony.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Testimony Text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          testimony.testimony,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      // Name
                      Text(
                        testimony.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _carouselController.previousPage();
                },
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: appColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ))),
              ),
            )),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _carouselController.nextPage();
                },
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: appColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ))),
              ),
            ))
      ],
    );
  }
}
