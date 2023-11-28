import 'package:flutter/material.dart';
import 'package:movie_flix_app/design_comp.dart/movie_card.dart';
import 'package:movie_flix_app/movie_service/fetch_data.dart';

class CurrentlyPlayingTab extends StatefulWidget {
  @override
  State<CurrentlyPlayingTab> createState() => _CurrentlyPlayingTabState();
}

class _CurrentlyPlayingTabState extends State<CurrentlyPlayingTab> {
  late TextEditingController _searchController;
  bool showCancel = false;
  late List<Map<String, dynamic>> movies=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    Future.delayed(Duration.zero, () {
      _loadMovies();
    });
  }

  Future<void> _loadMovies() async {
    try {
      movies = await MovieService.fetchMovies();
      setState(() {});
    } catch (e) {
      print('Error loading movies: $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 162, 7),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 218, 162, 7),
        title: Container(
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          width: showCancel
              ? .7 * MediaQuery.of(context).size.width
              : 0.95 * MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              setState(() {
                showCancel = true;
              });
            },
            child: Center(
              child: IntrinsicWidth(
                stepWidth:
                    showCancel ? MediaQuery.of(context).size.width * .7 : 0,
                child: TextField(
                  autofocus: showCancel,
                  controller: _searchController,
                  textAlign: showCancel ? TextAlign.left : TextAlign.center,
                  decoration: InputDecoration(
                      suffixIcon: showCancel
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                              },
                              child: Icon(Icons.cancel))
                          : null,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      border: InputBorder.none),
                  onTap: () {
                    setState(() {
                      showCancel = true;
                    });
                  },
                  onChanged: (value) {
                    // Handle search logic if needed
                  },
                ),
              ),
            ),
          ),
        ),
        actions: [
          Visibility(
            visible: showCancel,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showCancel = false;
                });
                _searchController.clear();
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * .21,
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: Divider(
            color: Colors.black,
            thickness: 1.0,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: movies.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8),
                  child: MovieCard(
                    title: movie['title'],
                    subtitle: '${movie['overview']}',
                    image: movie['poster_path'],
                  ),
                );
              },
            ),
    );
  }
}
