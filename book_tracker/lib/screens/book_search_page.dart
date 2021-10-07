import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/services/fetch_books.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:book_tracker/widgets/searched_book_detail_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({Key? key}) : super(key: key);

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  late TextEditingController _searchTextController;

  List<Book> listOfBooks = [];
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Search'),
        backgroundColor: Colors.redAccent,
      ),
      body: Material(
        elevation: 0.0,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      child: TextField(
                    onSubmitted: (value) {
                      _search();
                    },
                    controller: _searchTextController,
                    decoration: buildInputDecoration(
                        label: 'Search', hintText: 'Flutter Development'),
                  )),
                ),
                const SizedBox(
                  height: 12,
                ),
                (listOfBooks != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: 300,
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: createBookCards(listOfBooks, context),
                            ),
                          )),
                        ],
                      )
                    : const Center(
                        child: Text(''),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    await fetchBooks(_searchTextController.text).then((value) {
      setState(() {
        listOfBooks = value;
      });
    }, onError: (val) {
      throw Exception('Failed to load books ${val.toString()}');
    });
  }

  List<Widget> createBookCards(List<Book> books, BuildContext context) {
    List<Widget> children = [];

    for (var book in books) {
      children.add(Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Card(
          elevation: 5,
          color: const Color(0xfff6f4ff),
          child: Wrap(
            children: [
              Image.network(
                (book.photoUrl == null || book.photoUrl!.isEmpty)
                    ? 'https://images.unsplash.com/photo-1553729784-e91953dec042?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80'
                    : book.photoUrl!,
                height: 100,
                width: 160,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.blueGrey.shade100),
                      color: const Color(0xfff1f3f6),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Text(book.isbn13!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xff5d48b6))),
                ),
              ),
              ListTile(
                title: Text(
                  book.title,
                  style: const TextStyle(color: Color(0xff5d48b6)),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  book.bookauthor!,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SearchdBookDetailDialog(
                        book: book,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ));
    }
    return children;
  }
}
