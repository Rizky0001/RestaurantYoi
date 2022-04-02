import 'package:flutter/material.dart';

class ChipsFilter extends StatefulWidget {
  final List<Filter> filters;
  late final int selected;
  final Function() onTap;

  String get selectedItem {
    return selected.toString();
  }

  ChipsFilter({
    Key? key,
    required this.filters,
    required this.selected,
    required this.onTap,
  });

  @override
  _ChipsFilterState createState() => _ChipsFilterState();
}

class _ChipsFilterState extends State<ChipsFilter> {
  var selectedIndex;

  @override
  void initState() {
    // When [widget.selected] is defined, check the value and set it as
    // [selectedIndex]
    if (widget.selected >= 0 && widget.selected < widget.filters.length) {
      this.selectedIndex = widget.selected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: this.chipBuilder,
      itemCount: widget.filters.length,
      scrollDirection: Axis.horizontal,
    );
  }

  // Build a chip
  Widget chipBuilder(context, currentIndex) {
    Filter filter = widget.filters[currentIndex];
    bool isActive = this.selectedIndex == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = currentIndex;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21),
        margin: EdgeInsets.only(right: 11),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFFF4747) : Color(0xFFFFEDED),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              filter.label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.white : Color(0xFFFF4747),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Filter {
  final String label;

  const Filter({required this.label});
}
