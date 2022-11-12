import 'package:flutter/material.dart';
import 'package:garage_core/widgets/loading_container.dart';
import 'package:sizer/sizer.dart';

class LoadingList extends StatelessWidget {
  final ScrollPhysics scrollPhysics;
  final int numberOfItems;
  const LoadingList({
    Key? key,
    this.numberOfItems = 5,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: scrollPhysics,
      children: List<Widget>.generate(numberOfItems, (index) => const LoadingListItem()),
    );
  }
}

class LoadingListItem extends StatelessWidget {
  const LoadingListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(children: [
        SizedBox(
          width: 3.w,
        ),
        const LoadingContainer(
          width: 38,
          height: 38,
        ),
        SizedBox(
          width: 5.w,
        ),
        const LoadingContainer(
          height: 10,
          width: 80,
        ),
        SizedBox(
          width: 2.w,
        ),
        const LoadingContainer(
          height: 10,
          width: 30,
        ),
        SizedBox(
          width: 2.w,
        ),
        const LoadingContainer(
          height: 10,
          width: 60,
        )
      ]),
    );
  }
}
