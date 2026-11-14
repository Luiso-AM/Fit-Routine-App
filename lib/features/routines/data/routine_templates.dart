import '../domain/enums/routine_template_type.dart';
import '../domain/routine_template.dart';

// Predefined routines. They reference seed exercises by their fixed ids;
// a test checks every id exists in the seed library.

const _benchPress = 'cda5b584-236b-41ac-8c33-34c94235b1bb';
const _inclineDumbbellPress = 'ad255492-e435-4472-9d4e-04e37e5c72ad';
const _cableFly = '38a5b6af-6966-420f-a434-a319f738a7e6';
const _machineChestPress = 'c1cc75ca-e6af-4bd6-902c-dc36dd71a752';
const _pullUp = '54126f06-e4d8-4362-9ccb-bf127e645148';
const _barbellRow = '5fade84c-96e7-45ff-a765-4d04fd0bbabe';
const _latPulldown = 'e0321ae8-7035-4b00-9e77-21182d02eb33';
const _oneArmRow = '40c7ac4d-56d4-4848-a47c-307a9ebd6a9a';
const _machineRow = '839de648-3825-4974-8bb1-36980eb30ff0';
const _overheadPress = 'cf9070c5-32c6-409d-a391-f82a0207a4a0';
const _dumbbellShoulderPress = 'ebc7cf24-031d-4c08-b1cb-6e47904a6e92';
const _lateralRaise = 'f3e3fc80-0d4b-44ad-a0ef-e692aeab4381';
const _barbellCurl = '1007487c-cd97-4dd7-b3bb-d53c6a33473e';
const _alternatingCurl = '2615912d-b4d5-4696-9224-df05f54495fd';
const _hammerCurl = 'c287e310-cc96-4407-a9cb-d2680d75c972';
const _skullCrusher = '220852f2-b721-4a37-9271-d3ce2bf0f16c';
const _tricepsPushdown = '3beb3443-2db7-4771-b08a-e520f04d5b5a';
const _squat = '5f1ac738-8dc2-4a2f-9687-a0d88b0bd273';
const _legPress = 'e64fc7fd-dda9-40de-a70e-40863cff66a0';
const _legExtension = 'cc9eddc0-38ea-49b0-9cd8-7fe1554e08fe';
const _bulgarianSplitSquat = '28eda80d-7ebe-495f-a8ba-76729269818e';
const _romanianDeadlift = '1356eda2-030b-4f70-a6a5-9ac4d41eb6bf';
const _lyingLegCurl = '81bf21e4-fd09-4e72-b959-e7f579b81359';
const _seatedLegCurl = 'c45384e1-1514-4ed9-9944-5aed443fa8c2';
const _hipThrust = 'bde1029f-df8e-41ba-acf5-05191445ef79';
const _standingCalfRaise = '6ea42ca7-93da-4006-8134-dacf74b6477f';
const _seatedCalfRaise = '6250bc77-cf87-440c-bd95-5e443bd7e8fc';
const _plank = '25663005-82d3-4385-8700-1c8a055f9b68';
const _cableCrunch = 'd72cd46b-33a3-4be3-b857-ca590f9a2c1c';
const _hangingLegRaise = '4cd051e5-4299-4b31-9a1f-52eee96fac6f';

const List<RoutineTemplate> routineTemplates = [
  RoutineTemplate(
    type: RoutineTemplateType.fullBody,
    name: 'Full Body',
    days: [
      RoutineTemplateDay(
        name: 'Full Body A',
        exerciseIds: [
          _squat,
          _benchPress,
          _barbellRow,
          _dumbbellShoulderPress,
          _lyingLegCurl,
          _plank,
        ],
      ),
      RoutineTemplateDay(
        name: 'Full Body B',
        exerciseIds: [
          _romanianDeadlift,
          _inclineDumbbellPress,
          _latPulldown,
          _legPress,
          _lateralRaise,
          _cableCrunch,
        ],
      ),
      RoutineTemplateDay(
        name: 'Full Body C',
        exerciseIds: [
          _bulgarianSplitSquat,
          _machineChestPress,
          _oneArmRow,
          _hipThrust,
          _alternatingCurl,
          _tricepsPushdown,
        ],
      ),
    ],
  ),
  RoutineTemplate(
    type: RoutineTemplateType.upperLower,
    name: 'Upper / Lower',
    days: [
      RoutineTemplateDay(
        name: 'Superior A',
        exerciseIds: [
          _benchPress,
          _barbellRow,
          _overheadPress,
          _latPulldown,
          _barbellCurl,
          _tricepsPushdown,
        ],
      ),
      RoutineTemplateDay(
        name: 'Inferior A',
        exerciseIds: [
          _squat,
          _romanianDeadlift,
          _legPress,
          _seatedLegCurl,
          _standingCalfRaise,
          _plank,
        ],
      ),
      RoutineTemplateDay(
        name: 'Superior B',
        exerciseIds: [
          _inclineDumbbellPress,
          _pullUp,
          _dumbbellShoulderPress,
          _machineRow,
          _lateralRaise,
          _hammerCurl,
          _skullCrusher,
        ],
      ),
      RoutineTemplateDay(
        name: 'Inferior B',
        exerciseIds: [
          _hipThrust,
          _bulgarianSplitSquat,
          _legExtension,
          _lyingLegCurl,
          _seatedCalfRaise,
          _hangingLegRaise,
        ],
      ),
    ],
  ),
  RoutineTemplate(
    type: RoutineTemplateType.pushPullLegs,
    name: 'Push / Pull / Legs',
    days: [
      RoutineTemplateDay(
        name: 'Push',
        exerciseIds: [
          _benchPress,
          _inclineDumbbellPress,
          _overheadPress,
          _lateralRaise,
          _cableFly,
          _tricepsPushdown,
        ],
      ),
      RoutineTemplateDay(
        name: 'Pull',
        exerciseIds: [
          _pullUp,
          _barbellRow,
          _latPulldown,
          _oneArmRow,
          _barbellCurl,
          _hammerCurl,
        ],
      ),
      RoutineTemplateDay(
        name: 'Legs',
        exerciseIds: [
          _squat,
          _romanianDeadlift,
          _legPress,
          _legExtension,
          _seatedLegCurl,
          _standingCalfRaise,
        ],
      ),
    ],
  ),
];
