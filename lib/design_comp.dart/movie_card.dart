import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  MovieCard({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width * .95,
      alignment: Alignment.center,
      // color: Color.fromARGB(255, 218, 162, 7),
      child: Row(
        children: [
          Image.network('https://image.tmdb.org/t/p/w342$image',fit: BoxFit.cover,width: 120,height: 150,),
          SizedBox(width: 10,),
          Flexible(
              child: Container(
            width: double.infinity,
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  // Set maxLines to null for unlimited lines
                  maxLines: 1,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  // Set maxLines to null for unlimited lines
                  maxLines: 4,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
