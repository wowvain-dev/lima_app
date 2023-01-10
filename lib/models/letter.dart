enum LetterType {
  vowel,
  consonant
}

/// Letter class used for containing a corresponding letter and its pronunciation
/// audio file
class Letter {
  Letter({
    this.character, this.audioPath
  });

  String? character;
  String? audioPath;

  LetterType get letterType {
    if (['a', 'e', 'i', 'o', 'u', 'î', 'ă', 'â'].contains(character)) {
      return LetterType.vowel;
    }
    return LetterType.consonant;
  }

  @override
  String toString() => character ?? '';
}