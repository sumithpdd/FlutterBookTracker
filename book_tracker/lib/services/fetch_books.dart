import 'dart:convert';

import 'package:book_tracker/model/book.dart';
import 'package:http/http.dart' as http;

Future<List<Book>> fetchBooks(String query) async {
  List<Book> books = [];
  http.Response response = await http
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    final Iterable list = body['items'];
    for (var item in list) {
      String title = item['volumeInfo']['title'];
      String isbn13 = item['volumeInfo']['industryIdentifiers'] == null
          ? "N/A"
          : item['volumeInfo']['industryIdentifiers'][0]['identifier'];
      String author = item['volumeInfo']['authors'] == null
          ? "N/A"
          : item['volumeInfo']['authors'][0];
      String thumbNail = (item['volumeInfo']['imageLinks'] == null)
          ? ""
          : item['volumeInfo']['imageLinks']['thumbnail'];
      String publishedDate = item['volumeInfo']['publishedDate'] ?? "N/A";
      String description = item['volumeInfo']['description'] ?? "N/A";
      int pageCount = item['volumeInfo']['pageCount'] ?? 0;
      String categories = item['volumeInfo']['categories'] == null
          ? "N/A"
          : item['volumeInfo']['categories'][0];

      Book searchedBook = Book(
          title: title,
          isbn13: isbn13,
          bookauthor: author,
          photoUrl: thumbNail,
          description: description,
          publishedDate: publishedDate,
          pageCount: pageCount,
          categories: categories,
          id: '');

      books.add(searchedBook);

      // print('${item['volumeInfo']['title']}');
    }
  } else {
    throw ('error ${response.reasonPhrase}');
  }
  return books;
}
