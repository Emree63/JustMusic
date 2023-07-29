import 'package:justmusic/model/Artist.dart';
import 'package:justmusic/model/Music.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';

Future<void> main() async {
  MusicViewModel musicVM = new MusicViewModel();
  Music m = await musicVM.getMusic('295SxdR1DqunCNwd0U767w');

  print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
  print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}, explicit : ${m.explicit}");
  for (Artist a in m.artists) {
    print("id : ${a.id}, name : ${a.name}");
  }

  print('\nMusics :');

  List<Music> musics = await musicVM.getMusicsWithName('Shavkat');
  for (Music m in musics) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}, explicit : ${m.explicit}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

  print('\nMusics With Artist:');

  List<Music> musics2 = await musicVM.getMusicsWithArtistName('jul');
  for (Music m in musics2) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}, explicit : ${m.explicit}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

  print('\nArtist with Name:');

  Artist a = await musicVM.getArtistWithName('jul');
  print("id : ${a.id}, name : ${a.name}, image : ${a.image}");

  print('\nArtists with Name:');

  List<Artist> artists = await musicVM.getArtistsWithName('jul');
  for (Artist a in artists) {
    print("id : ${a.id}, name : ${a.name}, image : ${a.image}");
  }

  print('\nTop Musics :');

  List<Music> topMusics = await musicVM.getTopMusicsWithArtistId('3NH8t45zOTqzlZgBvZRjvB');
  for (Music m in topMusics) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}, explicit : ${m.explicit}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

  print('\nPlaylist Musics :');

  List<Music> playlistMusics = await musicVM.getMusicsWithPlaylistId('37i9dQZF1DX1X23oiQRTB5');
  for (Music m in playlistMusics) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}, explicit : ${m.explicit}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

  print('\nMusics With Ids :');

  List<Music> musicsIds = await musicVM.getMusicsWithIds(['6D1HiF2e3Z0F8FwQ5uLxwn','6IGg7qsBvA5xbrwz3MNHWK']);
  for (Music m in musicsIds) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}, explicit : ${m.explicit}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

}
