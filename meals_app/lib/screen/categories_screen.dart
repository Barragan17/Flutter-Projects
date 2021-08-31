import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widget/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      children: DUMMY_CATEGORIES
          .map((catData) =>
              CategoryItem(catData.id, catData.title, catData.color))
          .toList(),
      // use sliver to create a scrollable grid screen
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        // use childAspectRation to set how the item should be sized regarding their height and width relation
        childAspectRatio: 3 / 2,
        // use cross and main axis spacing to create a spacing between each items
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
