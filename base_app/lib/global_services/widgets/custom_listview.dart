import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomListView extends StatelessWidget {
  const CustomListView(
      {Key? key,
      required ScrollController scrollController,
      required this.height,
      required this.itemCount,
      required this.selectedItem,
      required this.itemBuilder})
      : _scrollController = scrollController,
        super(key: key);

  final Widget Function(BuildContext, int) itemBuilder;

  /// This field is the pages count since each item will take the whole page width
  final int itemCount;
  final double height;
  final ScrollController _scrollController;
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + 3.5.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: height,
              width: 100.w,
              child: ListView.builder(
                  itemCount: itemCount,
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemBuilder: itemBuilder),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: itemCount,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: index == selectedItem ? 10 : 18,
                  height: 10,
                  decoration: BoxDecoration(
                      color: index == selectedItem ? Colors.black : lightGrey,
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
