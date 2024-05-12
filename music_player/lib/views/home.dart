// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/model/playlist_provider.dart';
import 'package:provider/provider.dart';

import '../model/song_model.dart';
import 'song.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final dynamic playlistProvider;
  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int index) {
    playlistProvider.setCurrentSongIndex = index;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('P L A Y L I S T',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        drawer: MyDrawer(),
        body: Consumer<PlaylistProvider>(builder: (context, value, child) {
          final List<Song> playlist = value.getPlaylist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        }));
  }
}
