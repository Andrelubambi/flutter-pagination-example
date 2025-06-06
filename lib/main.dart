import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PaginatedListScreen());
  }
}

class PaginatedListScreen extends StatefulWidget {
  const PaginatedListScreen({super.key});

  @override
  State<PaginatedListScreen> createState() => _PaginatedListScreenState();
}

class _PaginatedListScreenState extends State<PaginatedListScreen> {
  final int itemsPerPage = 10;
  final List<String> allItems = List.generate(
    100,
    (index) => 'Item ${index + 1}',
  );
  int currentPage = 1;

  List<String> get currentItems {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return allItems.sublist(startIndex, endIndex.clamp(0, allItems.length));
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (allItems.length / itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(title: const Text("Lista Paginada")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentItems.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(currentItems[index]));
              },
            ),
          ),
          Pagination(
            numOfPages: totalPages,
            selectedPage: currentPage,
            pagesVisible: 3,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            previousIcon: const Icon(Icons.arrow_back_ios, size: 14),
            nextIcon: const Icon(Icons.arrow_forward_ios, size: 14),
            activeTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            activeBtnStyle: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            inactiveBtnStyle: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            inactiveTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
