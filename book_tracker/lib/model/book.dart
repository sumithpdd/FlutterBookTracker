import 'package:book_tracker/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  //final String? author;
  final String? notes;
  final String? photoUrl;
  final String? categories;
  final String? publishedDate;
  final double? rating;
  final String? description;
  final int? pageCount;
  final Timestamp? startedReading;
  final Timestamp? finishedReading;
  final String? userId;

  Book({
    required this.id,
    required this.title,
    //this.author,
    this.notes,
    this.photoUrl,
    this.categories,
    this.publishedDate,
    this.rating,
    this.description,
    this.pageCount,
    this.startedReading,
    this.finishedReading,
    this.userId,
  });
  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
        id: data["id"],
        title: data["title"],
        //  author: data['author'],
        notes: data['notes'],
        photoUrl: data['photo_url'],
        categories: data['categories'],
        publishedDate: data['published_date'],
        rating: parseDouble(data['rating']),
        description: data['description'],
        pageCount: data['page_count'],
        startedReading: data['started_reading_at'],
        finishedReading: data['finished_reading_at'],
        userId: data['user_id']);
  }
  factory Book.fromDocument(QueryDocumentSnapshot doc) {
    return Book(
        id: doc.id,
        title: (doc.data() as dynamic)['title'],
        // author: (doc.data() as dynamic)['author'],
        notes: (doc.data() as dynamic)['notes'],
        photoUrl: (doc.data() as dynamic)['photo_url'],
        categories: (doc.data() as dynamic)['categories'],
        publishedDate: (doc.data() as dynamic)['published_date'],
        rating: parseDouble((doc.data() as dynamic)['rating']),
        description: (doc.data() as dynamic)['description'],
        pageCount: (doc.data() as dynamic)['page_count'],
        startedReading: (doc.data() as dynamic)['started_reading_at'],
        finishedReading: (doc.data() as dynamic)['finished_reading_at'],
        userId: (doc.data() as dynamic)['user_id']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_id': userId,
      //  'author': author,
      'notes': notes,
      'photo_url': photoUrl,
      'published_date': publishedDate,
      'rating': rating,
      'description': description,
      'page_count': pageCount,
      'started_reading_at': startedReading,
      'finished_reading_at': finishedReading,
      'categories': categories,
    };
  }
}
