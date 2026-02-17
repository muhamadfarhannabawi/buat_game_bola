import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 1.0;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  Future<void> initialize() async {
    try {
      await FlameAudio.audioCache.loadAll([
        'music/instrumental.mp3',
        'sfx/assets_audio_sfx_explode.mp3',
        'sfx/assets_audio_sfx_collect.mp3',
        'sfx/assets_audio_sfx_toet_kowek.mp3',
      ]);
      print('Audio Initialize Successfully');
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  void playBackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.play('music/instrumental.mp3', volume: _musicVolume);
      } catch (e) {
        print('Error playing backsound: $e');
      }
    }
  }

  void pauseBackgroundMusic() {
    try {
      FlameAudio.bgm.pause();
    } catch (e) {
      print('Error when paused backsound: $e');
    }
  }

  void resumeBackgroundMusic() {
    try {
      FlameAudio.bgm.resume();
    } catch (e) {
      print('error resuming backsound: $e');
    }
  }

  void playSfx(String fileName) {
    if (_isSfxEnabled) {
      try {
        FlameAudio.play('sfx/$fileName', volume: _sfxVolume);
      } catch (e) {
        print('error playing sfx: $e');
      }
    }
  }

  void playSfxWithVolume(String fileName, double volume) {
    if (_isSfxEnabled) {
      try {
        final adjustedVolume =
            ((volume * _sfxVolume).clamp(0.0, 1.0)) as double;
        FlameAudio.play('sfx/$fileName', volume: adjustedVolume);
      } catch (e) {
        print('Error customing volume sound effect: $e');
      }
    }
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    try {
      FlameAudio.bgm.audioPlayer?.setVolume(_musicVolume);
    } catch (e) {
      print('Error setting volume music: $e');
    }
  }

  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      resumeBackgroundMusic();
    } else {
      pauseBackgroundMusic();
    }
  }

  // Deprecated alias for backward compatibility (typo in older code)
  @deprecated
  void toggleMUsic() => toggleMusic();

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }

  void enableMusic() {
    _isMusicEnabled = true;
    resumeBackgroundMusic();
  }

  void disableMusic() {
    if (_isMusicEnabled) {
      _isMusicEnabled = false;
      pauseBackgroundMusic();
    }
  }

  void enableSfx() {
    _isSfxEnabled = true;
  }

  void disableSfx() {
    if (_isSfxEnabled) {
      _isSfxEnabled = false;
    }
  }

  void dispose() {
    try {
      FlameAudio.bgm.dispose();
    } catch (e) {
      print('Error disposing audio: $e');
    }
  }
}