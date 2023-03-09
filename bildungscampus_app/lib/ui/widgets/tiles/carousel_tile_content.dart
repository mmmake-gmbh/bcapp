import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselTileContent<T> extends StatefulWidget {
  final List<T> items;
  final Color contentColor;
  final Function(BuildContext context, T model) onSlideTap;
  final Widget Function(BuildContext context, T model) builder;
  final Function(int newIndex)? onSlideChange;

  const CarouselTileContent({
    Key? key,
    required this.items,
    required this.contentColor,
    required this.onSlideTap,
    required this.builder,
    this.onSlideChange,
  }) : super(key: key);

  @override
  State<CarouselTileContent<T>> createState() => _CarouselTileContentState<T>();
}

class _CarouselTileContentState<T> extends State<CarouselTileContent<T>> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        Expanded(
          child: CarouselSlider.builder(
            carouselController: _controller,
            options: CarouselOptions(
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                aspectRatio: 2.5,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                  widget.onSlideChange?.call(index);
                }),
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int itemIndex, int realIndex) =>
                InkWell(
              child: widget.builder(context, widget.items[itemIndex]),
              onTap: () {
                widget.onSlideTap(context, widget.items[itemIndex]);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.map((data) {
            int index = widget.items.indexOf(data);
            return InkWell(
              child: Container(
                width: 6.0,
                height: 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? widget.contentColor.withOpacity(0.9)
                        : widget.contentColor.withOpacity(0.4)),
              ),
              onTap: () {
                _controller.jumpToPage(index);
              },
            );
          }).toList(),
        ),
      ]),
    );
  }
}
