// import 'package:flutter/material.dart';
// import 'package:news_app/core/config/color_palette.dart';
// import 'package:news_app/data/data_source/api_manager.dart';
// import 'package:news_app/features/home_view/custom_widgets/category_view_details_widget.dart';
// import 'package:news_app/models/category_model.dart';
//
// import '../../../models/source_model.dart';
//
// class SelectedCategoryView extends StatelessWidget {
//   final CategoryModel categoryModel;
//   Function(String)? getArticleList;
//
//   SelectedCategoryView({
//     super.key,
//     required this.categoryModel,
//     required this.getArticleList,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: ApiManager.fetchSourcesList(categoryModel.id),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text(
//             "failed fetching sources list",
//           );
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: ColorPalette.primaryColor,
//             ),
//           );
//         }
//
//         List<Source> sourcesList = snapshot.data ?? [];
//
//         return CategoryViewDetailsWidget(sourcesList: sourcesList, getArticleList: getArticleList,);
//       },
//     );
//   }
// }
