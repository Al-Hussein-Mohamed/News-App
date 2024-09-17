import 'package:flutter/material.dart';
import 'package:news_app/core/config/color_palette.dart';
import 'package:news_app/models/source_model.dart';
import 'package:shimmer/shimmer.dart';

class TabItemWidget extends StatefulWidget {
  final Source source;
  final bool isSelected;

  const TabItemWidget({
    super.key,
    required this.source,
    required this.isSelected,
  });

  @override
  State<TabItemWidget> createState() => _TabItemWidgetState();
}

class _TabItemWidgetState extends State<TabItemWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simulate data loading or content readiness
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return _isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? ColorPalette.primaryColor
                    : Colors.black,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: widget.isSelected
                        ? ColorPalette.primaryColor
                        : Colors.white),
              ),
              child: Text(
                widget.source.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color:
                  widget.isSelected ? ColorPalette.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: widget.isSelected
                      ? ColorPalette.primaryColor
                      : Colors.white),
            ),
            child: Text(
              widget.source.name,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          );
  }
}
