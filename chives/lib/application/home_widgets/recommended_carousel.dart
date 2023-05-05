import 'package:flutter/material.dart';
import 'package:chives/constants.dart';

class RecommendedCard extends StatefulWidget {
  const RecommendedCard({super.key});

  @override
  State<RecommendedCard> createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommendedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('carousel  soon'),
    );
  }
}

class RecommendedCarousel extends StatefulWidget {
  const RecommendedCarousel({super.key});

  @override
  State<RecommendedCarousel> createState() => _RecommendedCarouselState();
}

class _RecommendedCarouselState extends State<RecommendedCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RecommendedCard(),
    );
  }
}
