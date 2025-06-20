import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ktebxana/theme/theme_provider.dart';
import 'package:ktebxana/screens/ReadBookScreen.dart';
import 'package:ktebxana/screens/BookRatingScreen.dart';

class BooksDetail extends StatefulWidget {
  final String bookImage;
  final String bookTitle;
  final String bookCategory;
  final String bookDescription;
  final Function
      onFavoriteChanged; // Callback function to notify when favorite changes

  static List<Map<String, String>> favoriteBooks =
      []; // Static list to store favorite books

  const BooksDetail({
    super.key,
    required this.bookImage,
    required this.bookTitle,
    required this.bookCategory,
    required this.bookDescription,
    required this.onFavoriteChanged,
  });

  @override
  _BooksDetailState createState() => _BooksDetailState();
}

class _BooksDetailState extends State<BooksDetail> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Check if the book is in the favorites list
    isFavorite = BooksDetail.favoriteBooks
        .any((book) => book['title'] == widget.bookTitle);
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        // Remove from favorites
        BooksDetail.favoriteBooks
            .removeWhere((book) => book['title'] == widget.bookTitle);
      } else {
        // Add to favorites
        BooksDetail.favoriteBooks.add({
          'image': widget.bookImage,
          'title': widget.bookTitle,
          'category': widget.bookCategory,
          'description': widget.bookDescription,
        });
      }
      isFavorite = !isFavorite; // Toggle favorite state
    });

    widget.onFavoriteChanged(); // Callback to notify about changes
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookTitle),
        elevation: 0,
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFF5C6BC0),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Book cover image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.bookImage,
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Book Title
              Text(
                widget.bookTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Book Category
              Text(
                widget.bookCategory,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Book Description
              Text(
                widget.bookDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Action Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Read Button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadBookScreen(
                                bookTitle: widget.bookTitle,
                                bookCategory: widget.bookCategory,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF5C6BC0), // Subtle blue
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "خوێندنەوە",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  // Rate Button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookRatingScreen(
                                bookTitle: widget.bookTitle,
                                bookCategory: widget.bookCategory,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF7986CB), // Slightly lighter blue
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "نمرە",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  // Favorite Icon
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? const Color(0xFFEF5350)
                          : (isDarkMode ? Colors.white70 : Colors.grey[600]),
                      size: 30,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Download Button (Optional - example of another button style)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Download functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Colors.grey[700]
                          : Colors.grey[300], // Muted color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: Text(
                      "داگرتن",
                      style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
