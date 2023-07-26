import 'dart:convert';

import 'package:justmusic/view_model/TokenSpotify.dart';
import 'package:http/http.dart' as http;
import '../model/Artist.dart';
import '../model/Music.dart';

class MusicViewModel {
  final String API_URL = "https://api.spotify.com/v1";
  late TokenSpotify _token;

  MusicViewModel() {
    _token = new TokenSpotify();
  }

  // Methods
  Future<Music> getMusic(String id) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(Uri.parse('$API_URL/tracks/$id'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      List<Artist> artists =
          List<Artist>.from(responseData['artists'].map((artist) {
        return Artist(artist['id'], artist['name']);
      }));

      return Music(
          responseData['id'],
          responseData['name'],
          responseData['album']['images'][0]['url'],
          responseData['preview_url'],
          DateTime.parse(responseData['album']['release_date']),
          artists);
    } else {
      throw Exception(
          'Error retrieving music information : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  List<Music> _getMusicsFromResponse(Map<String, dynamic> responseData) {
    List<Music> musics = [];

    List<dynamic> tracks = responseData['tracks']['items'];
    for (var track in tracks) {
      List<Artist> artists = List<Artist>.from(track['artists'].map((artist) {
        return Artist(artist['id'], artist['name']);
      }));

      musics.add(Music(
          track['id'],
          track['name'],
          track['album']['images'][0]['url'],
          track['preview_url'],
          DateTime.now(),
          artists));
    }

    return musics;
  }

  Future<List<Music>> getMusicsWithName(String name, {int limit = 20, int offset = 1}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http
        .get(Uri.parse('$API_URL/search?q=track%3A$name&type=track&limit=$limit&offset=$offset'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return _getMusicsFromResponse(responseData);
    } else {
      throw Exception(
          'Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Music>> getMusicsWithArtistName(String name, {int limit = 20, int offset = 1}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(
        Uri.parse('$API_URL/search?q=artist%3A$name&type=track&limit=$limit&offset=$offset'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return _getMusicsFromResponse(responseData);
    } else {
      throw Exception(
          'Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
