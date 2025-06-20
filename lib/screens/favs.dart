import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ktebxana/theme/theme_provider.dart';
import 'package:ktebxana/screens/BooksDetail.dart';

class FavsPage extends StatefulWidget {
  const FavsPage({super.key});

  @override
  _FavsPageState createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFF5C6BC0),
        title: const Text(
          'دڵخوازەکان',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BooksDetail.favoriteBooks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 80,
                      color: isDarkMode ? Colors.white24 : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'هێشتا هیچ کتێبێکت هەڵنەبژێردووە',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'کتێبە دڵخوازەکانت لێرەدا پیشان دەدرێن',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white54 : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: BooksDetail.favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = BooksDetail.favoriteBooks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BooksDetail(
                              bookImage: book['image']!,
                              bookTitle: book['title']!,
                              bookCategory: book['category']!,
                              bookDescription: book['description']!,
                              onFavoriteChanged: () {
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                book['image']!,
                                height: 80,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book['title']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    book['category']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Color(0xFF5C6BC0),
                              ),
                              onPressed: () {
                                setState(() {
                                  BooksDetail.favoriteBooks.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
