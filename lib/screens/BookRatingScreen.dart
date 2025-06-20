import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ktebxana/theme/theme_provider.dart';

class BookRatingScreen extends StatefulWidget {
  final String bookTitle;
  final String bookCategory;

  const BookRatingScreen({
    super.key,
    required this.bookTitle,
    required this.bookCategory,
  });

  @override
  _BookRatingScreenState createState() => _BookRatingScreenState();
}

class _BookRatingScreenState extends State<BookRatingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Set initial username from Firebase Auth if available
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _usernameController.text = user.email?.split('@')[0] ?? '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تکایە نمرە بدە'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تکایە ناوی بەکارهێنەر بنووسە'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('book_ratings').add({
          'userId': user.uid,
          'username': _usernameController.text,
          'bookTitle': widget.bookTitle,
          'bookCategory': widget.bookCategory,
          'rating': _rating,
          'commentText': _commentController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('نمرەت بە سەرکەوتوویی تۆمارکرا'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('هەڵەیەک ڕوویدا، تکایە دووبارە هەوڵ بدەوە'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text('نمرە و ڕەخنە'),
        elevation: 0,
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFF5C6BC0),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.bookTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: TextEditingController(
                    text: widget.bookTitle), // Read-only book title field
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'ناوی کتێب',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87),
              ),
              const SizedBox(height: 16),
              // Username TextField
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'ناوی بەکارهێنەر',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled:
                        false, // No fill color here as it's in the container
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                  ),
                  style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'نمرە',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(10, (index) {
                  final ratingNumber = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = ratingNumber.toDouble();
                      });
                    },
                    child: Icon(
                      index < _rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: index < _rating
                          ? const Color(0xFFFFC107)
                          : (isDarkMode
                              ? Colors.white38
                              : Colors.grey[400]), // Subtle yellow/grey
                      size: 35,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Comment TextField
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _commentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'کۆمێنت',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled:
                        false, // No fill color here as it's in the container
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    alignLabelWithHint: true,
                  ),
                  style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C6BC0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'ناردنی نمرە',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
