import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:ktebxana/screens/BooksDetail.dart';
import 'package:ktebxana/theme/theme_provider.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});

  final String name;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of authors with their images and books
  final List<Map<String, dynamic>> authors = [
    {
      'name': 'بەختیار عەلی',
      'image':
          'data:image/jpeg;base64,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',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/7390378-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390379-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٢',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390380-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٣',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٨٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390381-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٤',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390382-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٥',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
      ],
    },
    {
      'name': 'شێرکۆ بێکەس',
      'image':
          'data:image/jpeg;base64,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',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/7390384-L.jpg',
          'title': 'گەڕانەوە بۆ کۆیە',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390385-L.jpg',
          'title': 'گەڕانەوە بۆ کۆیە ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٨٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390386-L.jpg',
          'title': 'گەڕانەوە بۆ کۆیە ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390387-L.jpg',
          'title': 'گەڕانەوە بۆ کۆیە ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390388-L.jpg',
          'title': 'گەڕانەوە بۆ کۆیە ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
      ],
    },
    {
      'name': 'لەتیف ھەڵمەت',
      'image':
          'data:image/jpeg;base64,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',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/7390390-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390391-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٢',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390392-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٣',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٨٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390393-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٤',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7390394-L.jpg',
          'title': 'ئەو کتێبە کە بە ناوی من ناوی لێنرا ٥',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
      ],
    },
    {
      'name': 'عەبدوڵا پەشێو',
      'image': 'https://covers.openlibrary.org/b/id/10570662-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/10570662-L.jpg',
          'title': 'دیوانی پەشێو',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٥٠٠',
          'price': '٢٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10570663-L.jpg',
          'title': 'دیوانی پەشێو ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٥٢٠',
          'price': '٢٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10570664-L.jpg',
          'title': 'دیوانی پەشێو ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٨٠',
          'price': '٢٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10570665-L.jpg',
          'title': 'دیوانی پەشێو ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٥٠٠',
          'price': '٢٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10570666-L.jpg',
          'title': 'دیوانی پەشێو ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٥٢٠',
          'price': '٢٦ دۆلار',
        },
      ],
    },
    {
      'name': 'سەلام ناوخۆش',
      'image': 'https://covers.openlibrary.org/b/id/8262071-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8262071-L.jpg',
          'title': 'جۆلەکەی بەخت',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8262072-L.jpg',
          'title': 'جۆلەکەی بەخت ٢',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8262073-L.jpg',
          'title': 'جۆلەکەی بەخت ٣',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8262074-L.jpg',
          'title': 'جۆلەکەی بەخت ٤',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8262075-L.jpg',
          'title': 'جۆلەکەی بەخت ٥',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
      ],
    },
    {
      'name': 'مەلا محەممەد کەریم',
      'image': 'https://covers.openlibrary.org/b/id/9184710-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/9184710-L.jpg',
          'title': 'یادداشتەکان',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9184711-L.jpg',
          'title': 'یادداشتەکان ٢',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9184712-L.jpg',
          'title': 'یادداشتەکان ٣',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٣٨٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9184713-L.jpg',
          'title': 'یادداشتەکان ٤',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9184714-L.jpg',
          'title': 'یادداشتەکان ٥',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
      ],
    },
    {
      'name': 'عەبدوڵا گۆران',
      'image': 'https://covers.openlibrary.org/b/id/8728007-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8728007-L.jpg',
          'title': 'دیوانی گۆران',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٥٠',
          'price': '٢٢ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8728008-L.jpg',
          'title': 'دیوانی گۆران ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٧٠',
          'price': '٢٣ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8728009-L.jpg',
          'title': 'دیوانی گۆران ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٣٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8728010-L.jpg',
          'title': 'دیوانی گۆران ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٥٠',
          'price': '٢٢ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8728011-L.jpg',
          'title': 'دیوانی گۆران ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٤٧٠',
          'price': '٢٣ دۆلار',
        },
      ],
    },
    {
      'name': 'پیرەمێرد',
      'image': 'https://covers.openlibrary.org/b/id/7710814-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/7710814-L.jpg',
          'title': 'دیوانی پیرەمێرد',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7710815-L.jpg',
          'title': 'دیوانی پیرەمێرد ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7710816-L.jpg',
          'title': 'دیوانی پیرەمێرد ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7710817-L.jpg',
          'title': 'دیوانی پیرەمێرد ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7710818-L.jpg',
          'title': 'دیوانی پیرەمێرد ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
      ],
    },
    {
      'name': 'عەبدوڵا سەعید',
      'image': 'https://covers.openlibrary.org/b/id/8276264-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8276264-L.jpg',
          'title': 'مێژووی کورد',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٠٠',
          'price': '٢٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8276265-L.jpg',
          'title': 'مێژووی کورد ٢',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٢٠',
          'price': '٢٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8276266-L.jpg',
          'title': 'مێژووی کورد ٣',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٤٨٠',
          'price': '٢٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8276267-L.jpg',
          'title': 'مێژووی کورد ٤',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٠٠',
          'price': '٢٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8276268-L.jpg',
          'title': 'مێژووی کورد ٥',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٢٠',
          'price': '٢٦ دۆلار',
        },
      ],
    },
    {
      'name': 'قانع',
      'image': 'https://covers.openlibrary.org/b/id/8681942-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8681942-L.jpg',
          'title': 'دیوانی قانع',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8681943-L.jpg',
          'title': 'دیوانی قانع ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٧٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8681944-L.jpg',
          'title': 'دیوانی قانع ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٣٠',
          'price': '١٧ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8681945-L.jpg',
          'title': 'دیوانی قانع ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8681946-L.jpg',
          'title': 'دیوانی قانع ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٧٠',
          'price': '١٩ دۆلار',
        },
      ],
    },
    {
      'name': 'فایەق بێکەس',
      'image': 'https://covers.openlibrary.org/b/id/9401856-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/9401856-L.jpg',
          'title': 'دیوانی فایەق بێکەس',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9401857-L.jpg',
          'title': 'دیوانی فایەق بێکەس ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9401858-L.jpg',
          'title': 'دیوانی فایەق بێکەس ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٦٠',
          'price': '١٣ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9401859-L.jpg',
          'title': 'دیوانی فایەق بێکەس ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9401860-L.jpg',
          'title': 'دیوانی فایەق بێکەس ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
      ],
    },
    {
      'name': 'محەمەد موکری',
      'image': 'https://covers.openlibrary.org/b/id/7967199-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/7967199-L.jpg',
          'title': 'فەرھەنگی موکریانی',
          'category': 'Dictionary',
          'genre': 'فەرھەنگ',
          'pages': '٦٠٠',
          'price': '٣٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7967200-L.jpg',
          'title': 'فەرھەنگی موکریانی ٢',
          'category': 'Dictionary',
          'genre': 'فەرھەنگ',
          'pages': '٦٢٠',
          'price': '٣١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7967201-L.jpg',
          'title': 'فەرھەنگی موکریانی ٣',
          'category': 'Dictionary',
          'genre': 'فەرھەنگ',
          'pages': '٥٨٠',
          'price': '٢٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7967202-L.jpg',
          'title': 'فەرھەنگی موکریانی ٤',
          'category': 'Dictionary',
          'genre': 'فەرھەنگ',
          'pages': '٦٠٠',
          'price': '٣٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/7967203-L.jpg',
          'title': 'فەرھەنگی موکریانی ٥',
          'category': 'Dictionary',
          'genre': 'فەرھەنگ',
          'pages': '٦٢٠',
          'price': '٣١ دۆلار',
        },
      ],
    },
    {
      'name': 'عەلادین سوجادی',
      'image': 'https://covers.openlibrary.org/b/id/8611846-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8611846-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٧٠٠',
          'price': '٣٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8611847-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٢',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٧٢٠',
          'price': '٣٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8611848-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٣',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٦٨٠',
          'price': '٣٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8611849-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٤',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٧٠٠',
          'price': '٣٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8611850-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٥',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٧٢٠',
          'price': '٣٦ دۆلار',
        },
      ],
    },
    {
      'name': 'کەمال مەزھەر',
      'image': 'https://covers.openlibrary.org/b/id/12421687-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/12421687-L.jpg',
          'title': 'مێژووی بزاڤی ڕزگاریخوازی کورد',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٥٠',
          'price': '٢٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/12421688-L.jpg',
          'title': 'مێژووی بزاڤی ڕزگاریخوازی کورد ٢',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٧٠',
          'price': '٢٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/12421689-L.jpg',
          'title': 'مێژووی بزاڤی ڕزگاریخوازی کورد ٣',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٣٠',
          'price': '٢٧ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/12421690-L.jpg',
          'title': 'مێژووی بزاڤی ڕزگاریخوازی کورد ٤',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٥٠',
          'price': '٢٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/12421691-L.jpg',
          'title': 'مێژووی بزاڤی ڕزگاریخوازی کورد ٥',
          'category': 'History',
          'genre': 'مێژوو',
          'pages': '٥٧٠',
          'price': '٢٩ دۆلار',
        },
      ],
    },
    {
      'name': 'مارف خەزنەدار',
      'image': 'https://covers.openlibrary.org/b/id/8853031-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8853031-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٦٥٠',
          'price': '٣٣ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8853032-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٢',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٦٧٠',
          'price': '٣٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8853033-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٣',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٦٣٠',
          'price': '٣٢ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8853034-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٤',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٦٥٠',
          'price': '٣٣ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8853035-L.jpg',
          'title': 'مێژووی ئەدەبی کوردی ٥',
          'category': 'Literature',
          'genre': 'ئەدەبیات',
          'pages': '٦٧٠',
          'price': '٣٤ دۆلار',
        },
      ],
    },
    {
      'name': 'جەمال غەمبار',
      'image': 'https://covers.openlibrary.org/b/id/9890810-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/9890810-L.jpg',
          'title': 'ژیان بە قەدەر مەرگ دژوارە',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9890811-L.jpg',
          'title': 'ژیان بە قەدەر مەرگ دژوارە ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9890812-L.jpg',
          'title': 'ژیان بە قەدەر مەرگ دژوارە ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9890813-L.jpg',
          'title': 'ژیان بە قەدەر مەرگ دژوارە ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9890814-L.jpg',
          'title': 'ژیان بە قەدەر مەرگ دژوارە ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
      ],
    },
    {
      'name': 'کەریم دەشتی',
      'image': 'https://covers.openlibrary.org/b/id/8456789-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8456789-L.jpg',
          'title': 'نیشتمانێکی بچووک',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8456790-L.jpg',
          'title': 'نیشتمانێکی بچووک ٢',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٧٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8456791-L.jpg',
          'title': 'نیشتمانێکی بچووک ٣',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٣٠',
          'price': '١٧ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8456792-L.jpg',
          'title': 'نیشتمانێکی بچووک ٤',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8456793-L.jpg',
          'title': 'نیشتمانێکی بچووک ٥',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٧٠',
          'price': '١٩ دۆلار',
        },
      ],
    },
    {
      'name': 'شێرزاد حەسەن',
      'image': 'https://covers.openlibrary.org/b/id/9578123-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/9578123-L.jpg',
          'title': 'حەسەنی خەیاڵ',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9578124-L.jpg',
          'title': 'حەسەنی خەیاڵ ٢',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9578125-L.jpg',
          'title': 'حەسەنی خەیاڵ ٣',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٨٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9578126-L.jpg',
          'title': 'حەسەنی خەیاڵ ٤',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9578127-L.jpg',
          'title': 'حەسەنی خەیاڵ ٥',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
      ],
    },
    {
      'name': 'عەلی عەبدوڵا',
      'image': 'https://covers.openlibrary.org/b/id/8765432-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/8765432-L.jpg',
          'title': 'پەروانە',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٥٠',
          'price': '١٢ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8765433-L.jpg',
          'title': 'پەروانە ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٧٠',
          'price': '١٣ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8765434-L.jpg',
          'title': 'پەروانە ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٣٠',
          'price': '١١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8765435-L.jpg',
          'title': 'پەروانە ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٥٠',
          'price': '١٢ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/8765436-L.jpg',
          'title': 'پەروانە ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٧٠',
          'price': '١٣ دۆلار',
        },
      ],
    },
    {
      'name': 'ئەحمەد ھەردی',
      'image': 'https://covers.openlibrary.org/b/id/9123456-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/9123456-L.jpg',
          'title': 'ھەردەم بە تۆوە زیندووم',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9123457-L.jpg',
          'title': 'ھەردەم بە تۆوە زیندووم ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9123458-L.jpg',
          'title': 'ھەردەم بە تۆوە زیندووم ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9123459-L.jpg',
          'title': 'ھەردەم بە تۆوە زیندووم ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9123460-L.jpg',
          'title': 'ھەردەم بە تۆوە زیندووم ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
      ],
    },
    {
      'name': 'ڕەفیق سابیر',
      'image': 'https://covers.openlibrary.org/b/id/9876543-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/9876543-L.jpg',
          'title': 'دیوانی ڕەفیق سابیر',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9876544-L.jpg',
          'title': 'دیوانی ڕەفیق سابیر ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٧٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9876545-L.jpg',
          'title': 'دیوانی ڕەفیق سابیر ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٣٠',
          'price': '١٧ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9876546-L.jpg',
          'title': 'دیوانی ڕەفیق سابیر ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٥٠',
          'price': '١٨ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/9876547-L.jpg',
          'title': 'دیوانی ڕەفیق سابیر ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٧٠',
          'price': '١٩ دۆلار',
        },
      ],
    },
    {
      'name': 'لەتیف فاتیح فەرەج',
      'image': 'https://covers.openlibrary.org/b/id/10987654-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/10987654-L.jpg',
          'title': 'سروودی وەرین',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10987655-L.jpg',
          'title': 'سروودی وەرین ٢',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10987656-L.jpg',
          'title': 'سروودی وەرین ٣',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٦٠',
          'price': '١٣ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10987657-L.jpg',
          'title': 'سروودی وەرین ٤',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/10987658-L.jpg',
          'title': 'سروودی وەرین ٥',
          'category': 'Poetry',
          'genre': 'شێعر',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
      ],
    },
    {
      'name': 'حەمە سەعید ئیبراھیم',
      'image': 'https://covers.openlibrary.org/b/id/11223344-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/11223344-L.jpg',
          'title': 'یادەوەری',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/11223345-L.jpg',
          'title': 'یادەوەری ٢',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/11223346-L.jpg',
          'title': 'یادەوەری ٣',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٣٨٠',
          'price': '١٩ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/11223347-L.jpg',
          'title': 'یادەوەری ٤',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٠٠',
          'price': '٢٠ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/11223348-L.jpg',
          'title': 'یادەوەری ٥',
          'category': 'Memoir',
          'genre': 'ژیاننامە',
          'pages': '٤٢٠',
          'price': '٢١ دۆلار',
        },
      ],
    },
    {
      'name': 'فاروق ڕەفیق',
      'image': 'https://covers.openlibrary.org/b/id/13456789-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/13456789-L.jpg',
          'title': 'فەلسەفەی ئازادی',
          'category': 'Philosophy',
          'genre': 'فەلسەفە',
          'pages': '٥٠٠',
          'price': '٢٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/13456790-L.jpg',
          'title': 'فەلسەفەی ئازادی ٢',
          'category': 'Philosophy',
          'genre': 'فەلسەفە',
          'pages': '٥٢٠',
          'price': '٢٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/13456791-L.jpg',
          'title': 'فەلسەفەی ئازادی ٣',
          'category': 'Philosophy',
          'genre': 'فەلسەفە',
          'pages': '٤٨٠',
          'price': '٢٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/13456792-L.jpg',
          'title': 'فەلسەفەی ئازادی ٤',
          'category': 'Philosophy',
          'genre': 'فەلسەفە',
          'pages': '٥٠٠',
          'price': '٢٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/13456793-L.jpg',
          'title': 'فەلسەفەی ئازادی ٥',
          'category': 'Philosophy',
          'genre': 'فەلسەفە',
          'pages': '٥٢٠',
          'price': '٢٦ دۆلار',
        },
      ],
    },
    {
      'name': 'بێجان سەمەر',
      'image': 'https://covers.openlibrary.org/b/id/14567890-L.jpg',
      'books': [
        {
          'image': 'https://covers.openlibrary.org/b/id/14567890-L.jpg',
          'title': 'وشە ونبووەکان',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/14567891-L.jpg',
          'title': 'وشە ونبووەکان ٢',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/14567892-L.jpg',
          'title': 'وشە ونبووەکان ٣',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٢٨٠',
          'price': '١٤ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/14567893-L.jpg',
          'title': 'وشە ونبووەکان ٤',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٠٠',
          'price': '١٥ دۆلار',
        },
        {
          'image': 'https://covers.openlibrary.org/b/id/14567894-L.jpg',
          'title': 'وشە ونبووەکان ٥',
          'category': 'Novel',
          'genre': 'ڕۆمان',
          'pages': '٣٢٠',
          'price': '١٦ دۆلار',
        },
      ],
    },
  ];

  // List of books
  final List<Map<String, String>> books = [
    // ڕۆمان (Novel) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      'title': '١٩٨٤',
      'category': 'Dystopian',
      'author': 'جۆرج ئۆرۆێڵ',
      'genre': 'ڕۆمان',
      'pages': '٣٢٨',
      'price': '١٥ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390301-L.jpg',
      'title': 'گەڕانەوە بۆ کۆیە',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390302-L.jpg',
      'title': 'دەریای نیشتمان',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390303-L.jpg',
      'title': 'کۆیە لە بەرزاییەکان',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390304-L.jpg',
      'title': 'گەشتەکەی ژیان',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390305-L.jpg',
      'title': 'خەونەکانی کۆیە',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390306-L.jpg',
      'title': 'ئاوەڵی ژیان',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390307-L.jpg',
      'title': 'گەشتەکەی خەون',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390308-L.jpg',
      'title': 'دەریای خەونەکان',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390309-L.jpg',
      'title': 'کۆیە لە خەونەکان',
      'category': 'Novel',
      'author': 'نووسەر نەزانراو',
      'genre': 'ڕۆمان',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },

    // خەیاڵی (Fiction) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7272572-L.jpg',
      'title': 'دایناسوڕەکان',
      'category': 'Science Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390310-L.jpg',
      'title': 'گەشتەکەی خەیاڵی',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390311-L.jpg',
      'title': 'دەریای خەیاڵی',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390312-L.jpg',
      'title': 'کۆیە لە خەیاڵی',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390313-L.jpg',
      'title': 'خەونەکانی خەیاڵی',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390314-L.jpg',
      'title': 'ئاوەڵی خەیاڵی',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390315-L.jpg',
      'title': 'گەشتەکەی خەیاڵی نوێ',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390316-L.jpg',
      'title': 'دەریای خەیاڵی نوێ',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390317-L.jpg',
      'title': 'کۆیە لە خەیاڵی نوێ',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390318-L.jpg',
      'title': 'خەونەکانی خەیاڵی نوێ',
      'category': 'Fiction',
      'author': 'نووسەر نەزانراو',
      'genre': 'خەیاڵی',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },

    // زانستی (Science) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7390319-L.jpg',
      'title': 'گەشتەکەی زانستی',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390320-L.jpg',
      'title': 'دەریای زانستی',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390321-L.jpg',
      'title': 'کۆیە لە زانستی',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390322-L.jpg',
      'title': 'خەونەکانی زانستی',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390323-L.jpg',
      'title': 'ئاوەڵی زانستی',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390324-L.jpg',
      'title': 'گەشتەکەی زانستی نوێ',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390325-L.jpg',
      'title': 'دەریای زانستی نوێ',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390326-L.jpg',
      'title': 'کۆیە لە زانستی نوێ',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390327-L.jpg',
      'title': 'خەونەکانی زانستی نوێ',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390328-L.jpg',
      'title': 'ئاوەڵی زانستی نوێ',
      'category': 'Science',
      'author': 'نووسەر نەزانراو',
      'genre': 'زانستی',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },

    // مێژوو (History) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7371936-L.jpg',
      'title': 'شەترەنج',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٢٥٠',
      'price': '١٢ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390329-L.jpg',
      'title': 'گەشتەکەی مێژوویی',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390330-L.jpg',
      'title': 'دەریای مێژوویی',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390331-L.jpg',
      'title': 'کۆیە لە مێژوویی',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390332-L.jpg',
      'title': 'خەونەکانی مێژوویی',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390333-L.jpg',
      'title': 'ئاوەڵی مێژوویی',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390334-L.jpg',
      'title': 'گەشتەکەی مێژوویی نوێ',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390335-L.jpg',
      'title': 'دەریای مێژوویی نوێ',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390336-L.jpg',
      'title': 'کۆیە لە مێژوویی نوێ',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390337-L.jpg',
      'title': 'خەونەکانی مێژوویی نوێ',
      'category': 'History',
      'author': 'نووسەر نەزانراو',
      'genre': 'مێژوو',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },

    // فەلسەفە (Philosophy) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7237106-L.jpg',
      'title': 'فەلسەفە',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٥٠٠',
      'price': '٢٥ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390338-L.jpg',
      'title': 'گەشتەکەی فەلسەفی',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390339-L.jpg',
      'title': 'دەریای فەلسەفی',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390340-L.jpg',
      'title': 'کۆیە لە فەلسەفی',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390341-L.jpg',
      'title': 'خەونەکانی فەلسەفی',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390342-L.jpg',
      'title': 'ئاوەڵی فەلسەفی',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390343-L.jpg',
      'title': 'گەشتەکەی فەلسەفی نوێ',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390344-L.jpg',
      'title': 'دەریای فەلسەفی نوێ',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390345-L.jpg',
      'title': 'کۆیە لە فەلسەفی نوێ',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390346-L.jpg',
      'title': 'خەونەکانی فەلسەفی نوێ',
      'category': 'Philosophy',
      'author': 'نووسەر نەزانراو',
      'genre': 'فەلسەفە',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },

    // ئەدەبیات (Literature) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7390347-L.jpg',
      'title': 'گەشتەکەی ئەدەبی',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390348-L.jpg',
      'title': 'دەریای ئەدەبی',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390349-L.jpg',
      'title': 'کۆیە لە ئەدەبی',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390350-L.jpg',
      'title': 'خەونەکانی ئەدەبی',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390351-L.jpg',
      'title': 'ئاوەڵی ئەدەبی',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390352-L.jpg',
      'title': 'گەشتەکەی ئەدەبی نوێ',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390353-L.jpg',
      'title': 'دەریای ئەدەبی نوێ',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390354-L.jpg',
      'title': 'کۆیە لە ئەدەبی نوێ',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390355-L.jpg',
      'title': 'خەونەکانی ئەدەبی نوێ',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390356-L.jpg',
      'title': 'ئاوەڵی ئەدەبی نوێ',
      'category': 'Literature',
      'author': 'نووسەر نەزانراو',
      'genre': 'ئەدەبیات',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },

    // وەرزش (Sports) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7390357-L.jpg',
      'title': 'گەشتەکەی وەرزشی',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390358-L.jpg',
      'title': 'دەریای وەرزشی',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390359-L.jpg',
      'title': 'کۆیە لە وەرزشی',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390360-L.jpg',
      'title': 'خەونەکانی وەرزشی',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390361-L.jpg',
      'title': 'ئاوەڵی وەرزشی',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390362-L.jpg',
      'title': 'گەشتەکەی وەرزشی نوێ',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390363-L.jpg',
      'title': 'دەریای وەرزشی نوێ',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390364-L.jpg',
      'title': 'کۆیە لە وەرزشی نوێ',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390365-L.jpg',
      'title': 'خەونەکانی وەرزشی نوێ',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390366-L.jpg',
      'title': 'ئاوەڵی وەرزشی نوێ',
      'category': 'Sports',
      'author': 'نووسەر نەزانراو',
      'genre': 'وەرزش',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },

    // ھونەر (Art) Category
    {
      'image': 'https://covers.openlibrary.org/b/id/7390367-L.jpg',
      'title': 'گەشتەکەی ھونەری',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390368-L.jpg',
      'title': 'دەریای ھونەری',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390369-L.jpg',
      'title': 'کۆیە لە ھونەری',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390370-L.jpg',
      'title': 'خەونەکانی ھونەری',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390371-L.jpg',
      'title': 'ئاوەڵی ھونەری',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390372-L.jpg',
      'title': 'گەشتەکەی ھونەری نوێ',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390373-L.jpg',
      'title': 'دەریای ھونەری نوێ',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٤٢٠',
      'price': '٢١ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390374-L.jpg',
      'title': 'کۆیە لە ھونەری نوێ',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٣٥٠',
      'price': '١٨ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390375-L.jpg',
      'title': 'خەونەکانی ھونەری نوێ',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٤٠٠',
      'price': '٢٠ دۆلار',
    },
    {
      'image': 'https://covers.openlibrary.org/b/id/7390376-L.jpg',
      'title': 'ئاوەڵی ھونەری نوێ',
      'category': 'Art',
      'author': 'نووسەر نەزانراو',
      'genre': 'ھونەر',
      'pages': '٣٨٠',
      'price': '١٩ دۆلار',
    }
  ];

  // List of categories for bottom navigation
  final List<String> categories = [
    'هەمووی',
    'ڕۆمان',
    'خەیاڵی',
    'زانستی',
    'مێژوو',
    'فەلسەفە',
    'ئەدەبیات',
    'وەرزش',
    'ھونەر',
  ];

  // Variable to hold filtered books
  late List<Map<String, String>> filteredBooks;
  late TextEditingController _controller;
  bool isSearching = false;
  int _selectedIndex = 0;
  bool showAuthors = false;

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
    _controller = TextEditingController();
  }

  // Function to filter books based on category
  void _filterByCategory(int index) {
    setState(() {
      _selectedIndex = index;
      showAuthors = false;
      if (index == 0) {
        filteredBooks = books;
      } else {
        filteredBooks = books.where((book) {
          return book['genre'] == categories[index];
        }).toList();
      }
    });
  }

  // Function to toggle authors view
  void _toggleAuthorsView() {
    setState(() {
      showAuthors = !showAuthors;
      if (showAuthors) {
        _selectedIndex = -1; // Deselect all categories
      } else {
        _selectedIndex = 0; // Show all books
        filteredBooks = books;
      }
    });
  }

  // Function to show author's books
  void _showAuthorBooks(int authorIndex) {
    setState(() {
      filteredBooks = authors[authorIndex]['books'].cast<Map<String, String>>();
      showAuthors = false;
    });
  }

  // Function to filter books based on search query
  void filterBooks(String query) {
    final filtered = books.where((book) {
      return book['title']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredBooks = filtered;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Extracting book images for the carousel
    final bookImages = books.map((book) => book['image'] as String).toList();

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFF5C6BC0),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
            });
            if (!isSearching) {
              _controller.clear();
              filterBooks('');
            }
          },
        ),
        title: isSearching
            ? TextField(
                controller: _controller,
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'گەڕان بؤ',
                  hintStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  filterBooks(query);
                },
              )
            : const Center(
                child: Text(
                  'سەرەکی',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: showAuthors ? Colors.white : Colors.white70,
            ),
            onPressed: _toggleAuthorsView,
          ),
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                filterBooks('');
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel with enhanced design
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF5C6BC0),
                    const Color(0xFF7986CB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                ),
                items: bookImages.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // Section title with enhanced design
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF5C6BC0),
                    const Color(0xFF7986CB),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                showAuthors ? 'نووسەران' : 'کتێبەکان',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // GridView with enhanced design
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: showAuthors
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: authors.length,
                      itemBuilder: (context, index) {
                        final author = authors[index];
                        return GestureDetector(
                          onTap: () => _showAuthorBooks(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? Colors.grey[800] : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Image.network(
                                      author['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF5C6BC0),
                                        const Color(0xFF7986CB),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        author['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '${author['books'].length} کتێب',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BooksDetail(
                                  bookImage:
                                      book['image'] ?? 'default_image_url_here',
                                  bookTitle: book['title'] ?? 'Unknown Title',
                                  bookCategory:
                                      book['category'] ?? 'Unknown Category',
                                  bookDescription: book['description'] ??
                                      'No description available',
                                  onFavoriteChanged: () {
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? Colors.grey[800] : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Image.network(
                                      book['image'] ?? 'default_image_url_here',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF5C6BC0),
                                        const Color(0xFF7986CB),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        book['title'] ?? 'Unknown Title',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          book['price'] ?? 'نەزانراو',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF4F5BD5),
              const Color(0xFF962FBF),
              const Color(0xFFD62976),
              const Color(0xFFFFB900),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Colors.white.withOpacity(0.18)
                            : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: _selectedIndex == index
                            ? [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                        border: Border.all(
                          color: _selectedIndex == index
                              ? Colors.white.withOpacity(0.7)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => _filterByCategory(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          child: Row(
                            children: [
                              _buildCategoryIcon(index),
                              const SizedBox(width: 8),
                              Text(
                                categories[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(int index) {
    // You can customize icons for each category here
    switch (categories[index]) {
      case 'ڕۆمان':
        return Icon(Icons.menu_book, color: Colors.white, size: 22);
      case 'خەیاڵی':
        return Icon(Icons.auto_awesome, color: Colors.white, size: 22);
      case 'زانستی':
        return Icon(Icons.science, color: Colors.white, size: 22);
      case 'مێژوو':
        return Icon(Icons.history_edu, color: Colors.white, size: 22);
      case 'فەلسەفە':
        return Icon(Icons.psychology, color: Colors.white, size: 22);
      case 'ئەدەبیات':
        return Icon(Icons.edit, color: Colors.white, size: 22);
      case 'وەرزش':
        return Icon(Icons.sports_soccer, color: Colors.white, size: 22);
      case 'ھونەر':
        return Icon(Icons.palette, color: Colors.white, size: 22);
      case 'هەمووی':
      default:
        return Icon(Icons.category, color: Colors.white, size: 22);
    }
  }
}
