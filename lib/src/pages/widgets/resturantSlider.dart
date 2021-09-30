import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../SendHttpCalls/Models/HomePage/resturantSliderModel.dart';

class ResturantSliderWidget extends StatelessWidget {
  final List<ResturantSliderModel> items;
  ResturantSliderWidget(this.items);
  @override
  Widget build(BuildContext context) {
    return items.length == 0
        ? Container()
        : CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              height: 180,
              viewportFraction: 1.0,
            ),
            items: items.map((sliderModel) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return ProductDetailsPage(sliderModel.data.id);
                      //     },
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 140,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.15),
                              blurRadius: 10,
                              offset: Offset(0, 4)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: sliderModel.image,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
  }
}
