import 'package:beyond_vision/provider/date_provider.dart';
import 'package:beyond_vision/ui/record/widgets/record_bar_graph.dart';
import 'package:beyond_vision/ui/record/widgets/record_circle_graph.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class GraphSlider extends StatefulWidget {
  final DateProvider provider;
  const GraphSlider({super.key, required this.provider});

  @override
  State<GraphSlider> createState() => _GraphSliderState();
}

class _GraphSliderState extends State<GraphSlider> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    DateProvider dateProvider = Provider.of<DateProvider>(context);

    return Stack(children: [
      CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1,
            initialPage: dateProvider.currentIdx,
            onPageChanged: (index, reason) {
              dateProvider.getCurrentIdx(index);
              setState(() {
                dateProvider.currentIdx = index;
              });
            }),
        items: [
          SizedBox(height: 260, child: RecordCircle(provider: widget.provider)),
          SizedBox(height: 250, child: RecordBar(provider: widget.provider))
        ],
      ),
      dateProvider.currentIdx == 1
          ? Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.previousPage();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white),
                ),
              ))
          : Container(),
      dateProvider.currentIdx == 0
          ? Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.nextPage();
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white),
                ),
              ))
          : Container()
    ]);
  }
}
