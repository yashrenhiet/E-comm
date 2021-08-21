import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySelector extends StatelessWidget {
  AppState get _appState => Get.find<AppState>();

  Set<String> get _categories => _appState.categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Obx(() {
              var _currentCategory = _categories.elementAt(index);
              var isSelected =
                  _currentCategory == _appState.selectedCategory.value;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    debugPrint("called");
                    if (!isSelected) {
                      _appState.selectedCategory.value = _currentCategory;
                    } else {
                      _appState.selectedCategory.value = "";
                    }
                  },
                  child: Chip(
                    label: Text(
                      _currentCategory,
                      style: isSelected
                          ? TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)
                          : TextStyle(),
                    ),
                    backgroundColor:
                        isSelected ? Colors.teal : Colors.grey.shade300,
                  ),
                ),
              );
            });
          },
          itemCount: _categories.length,
        ),
      ),
    );
  }
}
