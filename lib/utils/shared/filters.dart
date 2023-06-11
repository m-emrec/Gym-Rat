enum byType {
  cardio,
  olympic_weightlifting,
  plyometrics,
  powerlifting,
  strength,
  stretching,
  strongman,
}

enum byMuscle {
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
  beginner,
  intermediate,
  expert,
}

extension GetValueExtension on Enum {
  String get getValue {
    switch (this) {
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
      case byDifficulty.beginner:
        // TODO: Handle this case.
        return "Beginner";
      case byDifficulty.intermediate:
        // TODO: Handle this case.
        return "Intermediate";
      case byDifficulty.expert:
        // TODO: Handle this case.
        return "Expert";
      case byMuscle.abdominals:
        // TODO: Handle this case.
        return "Abdominals";
      case byMuscle.abductors:
        // TODO: Handle this case.
        return "Abductors";
      case byMuscle.adductors:
        // TODO: Handle this case.
        return "Adductors";
      case byMuscle.biceps:
        // TODO: Handle this case.
        return "Biceps";
      case byMuscle.calves:
        // TODO: Handle this case.
        return "Calves";
      case byMuscle.chest:
        // TODO: Handle this case.
        return "Chest";
      case byMuscle.forearms:
        // TODO: Handle this case.
        return "Forearms";
      case byMuscle.glutes:
        // TODO: Handle this case.
        return "Glutes";
      case byMuscle.hamstrings:
        // TODO: Handle this case.
        return "Hamstrings";
      case byMuscle.lats:
        // TODO: Handle this case.
        return "Lats";
      case byMuscle.lower_back:
        // TODO: Handle this case.
        return "Lower Back";
      case byMuscle.middle_back:
        // TODO: Handle this case.
        return "Middle Back";
      case byMuscle.neck:
        // TODO: Handle this case.
        return "Neck";
      case byMuscle.quadriceps:
        // TODO: Handle this case.
        return "Quadriceps";
      case byMuscle.traps:
        // TODO: Handle this case.
        return "Traps";
      case byMuscle.triceps:
        // TODO: Handle this case.
        return "Triceps";
      default:
        {
          return "";
        }
    }
  }
}
