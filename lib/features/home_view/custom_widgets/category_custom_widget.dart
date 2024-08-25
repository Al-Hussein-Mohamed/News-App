import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

class CategoryCustomWidget extends StatelessWidget {
  int index;
  CategoryModel categoryModel;
  void Function(CategoryModel)? categoryOnClicked;

  CategoryCustomWidget({
    super.key,
    required this.index,
    required this.categoryModel,
    required this.categoryOnClicked,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: () => categoryOnClicked!(categoryModel),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        decoration: BoxDecoration(
          color: categoryModel.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomLeft: index.isEven
                ? const Radius.circular(25)
                : const Radius.circular(0),
            bottomRight: index.isOdd
                ? const Radius.circular(25)
                : const Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Center(
                    child: Image.asset(
                  categoryModel.imagePath,
                ))),
            Expanded(
              child: Center(
                child: Text(
                  categoryModel.title,
                  style: theme.textTheme.titleLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
