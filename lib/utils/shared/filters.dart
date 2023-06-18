enum byType {
  none,
  cardio,
  olympic_weightlifting,
  plyometrics,
  powerlifting,
  strength,
  stretching,
  strongman,
}

enum byMuscle {
  none,
  abdominals,
  abductors,
  adductors,
  biceps,
  calves,
  chest,
  forearms,
  glutes,
  hamstrings,
  lats,
  lower_back,
  middle_back,
  neck,
  quadriceps,
  traps,
  triceps,
}

enum byDifficulty {
  none,
  beginner,
  intermediate,
  expert,
}

extension GetValueExtension on Enum {
  String get getValue {
    switch (this) {
      /// By Type
      case byType.cardio:
        return "Cardio";
      case byType.olympic_weightlifting:
        return "Olympic Weightlifting";
      case byType.plyometrics:
        return "Plyometrics";
      case byType.powerlifting:
        return "Powerlifting";
      case byType.strength:
        return "Strength";
      case byType.stretching:
        return "Stretching";
      case byType.strongman:
        return "Strongman";
      case byType.none:
        return "None";

      /// By Diff
      case byDifficulty.beginner:
        return "Beginner";
      case byDifficulty.intermediate:
        return "Intermediate";
      case byDifficulty.expert:
        return "Expert";
      case byDifficulty.none:
        return "None";

      /// By Muscle
      case byMuscle.abdominals:
        return "Abdominals";
      case byMuscle.abductors:
        return "Abductors";
      case byMuscle.adductors:
        return "Adductors";
      case byMuscle.biceps:
        return "Biceps";
      case byMuscle.calves:
        return "Calves";
      case byMuscle.chest:
        return "Chest";
      case byMuscle.forearms:
        return "Forearms";
      case byMuscle.glutes:
        return "Glutes";
      case byMuscle.hamstrings:
        return "Hamstrings";
      case byMuscle.lats:
        return "Lats";
      case byMuscle.lower_back:
        return "Lower Back";
      case byMuscle.middle_back:
        return "Middle Back";
      case byMuscle.neck:
        return "Neck";
      case byMuscle.quadriceps:
        return "Quadriceps";
      case byMuscle.traps:
        return "Traps";
      case byMuscle.triceps:
        return "Triceps";
      case byMuscle.none:
        return "None";
      default:
        {
          return "";
        }
    }
  }
}
