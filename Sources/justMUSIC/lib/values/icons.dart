enum JustMusicIcon {
  profile,
  spotify,
  trash,
  cross,
  history,
  theme,
  notification
}

extension MyIconExtension on JustMusicIcon {
  String get imagePath {
    switch (this) {
      case JustMusicIcon.profile:
        return 'assets/images/profile_icon.png';
      case JustMusicIcon.spotify:
        return 'assets/images/spotify_icon.png';
      case JustMusicIcon.trash:
        return 'assets/images/trash_icon.png';
      case JustMusicIcon.cross:
        return 'assets/images/cross_icon.png';
      case JustMusicIcon.history:
        return 'assets/images/history_icon.png';
      case JustMusicIcon.theme:
        return 'assets/images/theme_icon.png';
      case JustMusicIcon.notification:
        return 'assets/images/notification_icon.png';

      default:
        throw 'assets/images/unknown.png';
    }
  }
}
