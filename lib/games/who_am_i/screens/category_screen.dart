import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final List<String> selectedCategories;

  const CategoryScreen({
    super.key,
    required this.selectedCategories,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<String> selectedCategories;

  final List<String> categories = [
    'Animals',
    'Objects',
  ];

  @override
  void initState() {
    super.initState();

    selectedCategories =
        List<String>.from(widget.selectedCategories);
  }

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  void done() {
    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select at least one category.'),
        ),
      );
      return;
    }

    Navigator.pop(context, selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Choose Categories',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'What kind of identities should appear?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  final isSelected =
                      selectedCategories.contains(category);

                  return GestureDetector(
                    onTap: () => toggleCategory(category),
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context)
                                .colorScheme
                                .primaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .surface,
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            category == 'Animals'
                                ? Icons.pets_rounded
                                : Icons.inventory_2_rounded,
                            size: 30,
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Icon(
                            isSelected
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: done,
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}