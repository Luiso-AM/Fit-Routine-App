import '../../domain/enums/difficulty.dart';
import '../../domain/enums/equipment.dart';
import '../../domain/enums/exercise_type.dart';
import '../../domain/enums/muscle_group.dart';
import '../../domain/exercise.dart';

/// Base exercise library shipped with the app.
///
/// Ids are fixed UUIDs: never change or reuse one, because routines and
/// history reference them and the seeder relies on them to stay idempotent.
/// Names follow the pattern `Exercise Name (Equipment)`.
const List<Exercise> seedExercises = [
  // Chest
  Exercise(
    id: 'cda5b584-236b-41ac-8c33-34c94235b1bb',
    name: 'Press de Banca (Barra)',
    primaryMuscle: MuscleGroup.chest,
    secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.shoulders],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Acuéstate en el banco con los ojos bajo la barra y los pies firmes en el suelo.\n'
        '2. Toma la barra con un agarre algo más ancho que los hombros y retrae las escápulas.\n'
        '3. Baja la barra controlada hasta la parte media del pecho.\n'
        '4. Empuja hacia arriba hasta extender los brazos sin perder la posición de la espalda.',
    commonMistakes:
        '- Rebotar la barra en el pecho.\n'
        '- Abrir los codos a 90° respecto al torso.\n'
        '- Levantar los glúteos del banco.',
  ),
  Exercise(
    id: 'ad255492-e435-4472-9d4e-04e37e5c72ad',
    name: 'Press Inclinado (Mancuerna)',
    primaryMuscle: MuscleGroup.chest,
    secondaryMuscles: [MuscleGroup.shoulders, MuscleGroup.triceps],
    type: ExerciseType.compound,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Ajusta el banco a una inclinación de 30° a 45°.\n'
        '2. Sostén las mancuernas a la altura del pecho con las palmas hacia adelante.\n'
        '3. Empuja hacia arriba juntando ligeramente las mancuernas.\n'
        '4. Baja de forma controlada hasta sentir el estiramiento del pecho.',
    commonMistakes:
        '- Usar una inclinación tan alta que el trabajo pasa a los hombros.\n'
        '- Bajar las mancuernas sin control.\n'
        '- Arquear en exceso la zona lumbar.',
  ),
  Exercise(
    id: '38a5b6af-6966-420f-a434-a319f738a7e6',
    name: 'Aperturas (Polea)',
    primaryMuscle: MuscleGroup.chest,
    secondaryMuscles: [MuscleGroup.shoulders],
    type: ExerciseType.isolation,
    equipment: Equipment.cable,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Coloca las poleas a la altura de los hombros y toma un agarre en cada mano.\n'
        '2. Da un paso al frente con el torso ligeramente inclinado.\n'
        '3. Con los codos un poco flexionados, junta las manos frente al pecho.\n'
        '4. Regresa despacio hasta sentir el estiramiento.',
    commonMistakes:
        '- Flexionar y extender los codos, convirtiéndolo en un press.\n'
        '- Usar impulso del torso.',
  ),
  Exercise(
    id: 'c1cc75ca-e6af-4bd6-902c-dc36dd71a752',
    name: 'Press de Pecho (Máquina)',
    primaryMuscle: MuscleGroup.chest,
    secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.shoulders],
    type: ExerciseType.compound,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento para que los agarres queden a la altura media del pecho.\n'
        '2. Apoya la espalda en el respaldo y retrae las escápulas.\n'
        '3. Empuja los agarres hasta casi extender los brazos.\n'
        '4. Regresa de forma controlada sin que el peso toque el tope.',
    commonMistakes:
        '- Asiento demasiado alto o bajo.\n'
        '- Despegar la espalda del respaldo al empujar.',
  ),
  Exercise(
    id: 'cc2d8ff4-1a59-4650-99ef-fe5ebcfc6071',
    name: 'Press de Pecho Inclinado (Máquina)',
    primaryMuscle: MuscleGroup.chest,
    secondaryMuscles: [MuscleGroup.shoulders, MuscleGroup.triceps],
    type: ExerciseType.compound,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento para que los agarres queden a la altura de la parte alta del pecho.\n'
        '2. Apoya la espalda y mantén las escápulas retraídas.\n'
        '3. Empuja hacia arriba y adelante hasta casi extender los brazos.\n'
        '4. Regresa despacio manteniendo la tensión.',
    commonMistakes:
        '- Encoger los hombros hacia las orejas.\n'
        '- Recortar el recorrido en la bajada.',
  ),
  Exercise(
    id: '391aa244-1f2a-4b54-acca-50b4da2d554a',
    name: 'Pec Deck (Máquina)',
    primaryMuscle: MuscleGroup.chest,
    secondaryMuscles: [MuscleGroup.shoulders],
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento para que los brazos queden a la altura de los hombros.\n'
        '2. Toma los agarres con los codos ligeramente flexionados.\n'
        '3. Junta los brazos frente al pecho contrayendo el pecho.\n'
        '4. Abre de forma controlada hasta sentir el estiramiento.',
    commonMistakes:
        '- Abrir demasiado y perder el control al final del recorrido.\n'
        '- Empujar con las manos en lugar de cerrar con los brazos.',
  ),

  // Back
  Exercise(
    id: '54126f06-e4d8-4362-9ccb-bf127e645148',
    name: 'Dominadas (Peso Corporal)',
    primaryMuscle: MuscleGroup.back,
    secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.forearms],
    type: ExerciseType.compound,
    equipment: Equipment.bodyweight,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Cuélgate de la barra con agarre prono, algo más ancho que los hombros.\n'
        '2. Lleva las escápulas hacia abajo antes de tirar.\n'
        '3. Tira hasta que la barbilla supere la barra.\n'
        '4. Baja de forma controlada hasta extender los brazos.',
    commonMistakes:
        '- Balancear las piernas para ganar impulso.\n'
        '- Hacer medias repeticiones sin extender los brazos.',
  ),
  Exercise(
    id: '5fade84c-96e7-45ff-a765-4d04fd0bbabe',
    name: 'Remo (Barra)',
    primaryMuscle: MuscleGroup.back,
    secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.forearms],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. De pie, inclina el torso hacia adelante con la espalda neutra y las rodillas algo flexionadas.\n'
        '2. Toma la barra con agarre prono a la anchura de los hombros.\n'
        '3. Tira de la barra hacia el abdomen llevando los codos hacia atrás.\n'
        '4. Baja de forma controlada sin cambiar la posición del torso.',
    commonMistakes:
        '- Redondear la espalda.\n'
        '- Levantar el torso en cada repetición para mover más peso.',
  ),
  Exercise(
    id: 'e0321ae8-7035-4b00-9e77-21182d02eb33',
    name: 'Jalón al Pecho (Polea)',
    primaryMuscle: MuscleGroup.back,
    secondaryMuscles: [MuscleGroup.biceps],
    type: ExerciseType.compound,
    equipment: Equipment.cable,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Siéntate con los muslos bajo los soportes y toma la barra con agarre ancho.\n'
        '2. Inclina ligeramente el torso hacia atrás.\n'
        '3. Tira de la barra hacia la parte alta del pecho llevando los codos hacia abajo.\n'
        '4. Sube de forma controlada hasta extender los brazos.',
    commonMistakes:
        '- Llevar la barra detrás de la nuca.\n'
        '- Balancear el torso hacia atrás para bajar la barra.',
  ),
  Exercise(
    id: '40c7ac4d-56d4-4848-a47c-307a9ebd6a9a',
    name: 'Remo a Una Mano (Mancuerna)',
    primaryMuscle: MuscleGroup.back,
    secondaryMuscles: [MuscleGroup.biceps],
    type: ExerciseType.compound,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Apoya una rodilla y una mano en el banco con la espalda paralela al suelo.\n'
        '2. Sostén la mancuerna con el brazo extendido.\n'
        '3. Tira de la mancuerna hacia la cadera llevando el codo cerca del cuerpo.\n'
        '4. Baja de forma controlada.',
    commonMistakes:
        '- Rotar el torso para subir la mancuerna.\n'
        '- Tirar hacia el hombro en lugar de hacia la cadera.',
  ),
  Exercise(
    id: '839de648-3825-4974-8bb1-36980eb30ff0',
    name: 'Remo Sentado con Agarre Prono (Máquina)',
    primaryMuscle: MuscleGroup.back,
    secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.shoulders],
    type: ExerciseType.compound,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento y el apoyo de pecho para alcanzar los agarres con los brazos extendidos.\n'
        '2. Toma los agarres con las palmas hacia abajo.\n'
        '3. Tira llevando los codos hacia atrás y juntando las escápulas.\n'
        '4. Regresa de forma controlada hasta extender los brazos.',
    commonMistakes:
        '- Despegar el pecho del apoyo.\n'
        '- Encoger los hombros al tirar.',
  ),

  // Shoulders
  Exercise(
    id: 'cf9070c5-32c6-409d-a391-f82a0207a4a0',
    name: 'Press Militar (Barra)',
    primaryMuscle: MuscleGroup.shoulders,
    secondaryMuscles: [MuscleGroup.triceps],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. De pie, sostén la barra a la altura de las clavículas con agarre a la anchura de los hombros.\n'
        '2. Aprieta glúteos y abdomen.\n'
        '3. Empuja la barra hacia arriba pasando cerca de la cara hasta extender los brazos.\n'
        '4. Baja de forma controlada a la posición inicial.',
    commonMistakes:
        '- Arquear la zona lumbar para empujar.\n'
        '- Empujar la barra hacia adelante en lugar de hacia arriba.',
  ),
  Exercise(
    id: 'ebc7cf24-031d-4c08-b1cb-6e47904a6e92',
    name: 'Press de Hombros (Mancuerna)',
    primaryMuscle: MuscleGroup.shoulders,
    secondaryMuscles: [MuscleGroup.triceps],
    type: ExerciseType.compound,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Sentado con respaldo, sostén las mancuernas a la altura de los hombros.\n'
        '2. Empuja hacia arriba hasta casi juntar las mancuernas.\n'
        '3. Baja de forma controlada hasta la altura de las orejas.',
    commonMistakes:
        '- Bajar demasiado poco y acortar el recorrido.\n'
        '- Despegar la espalda del respaldo.',
  ),
  Exercise(
    id: 'f3e3fc80-0d4b-44ad-a0ef-e692aeab4381',
    name: 'Elevaciones Laterales (Mancuerna)',
    primaryMuscle: MuscleGroup.shoulders,
    type: ExerciseType.isolation,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. De pie, sostén las mancuernas a los costados con los codos ligeramente flexionados.\n'
        '2. Eleva los brazos hacia los lados hasta la altura de los hombros.\n'
        '3. Baja de forma controlada.',
    commonMistakes:
        '- Balancear el cuerpo para subir las mancuernas.\n'
        '- Subir por encima de los hombros encogiendo el trapecio.',
  ),
  Exercise(
    id: 'ba703eb9-6cc6-45b9-865f-e156d8277089',
    name: 'Press de Hombros (Máquina)',
    primaryMuscle: MuscleGroup.shoulders,
    secondaryMuscles: [MuscleGroup.triceps],
    type: ExerciseType.compound,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento para que los agarres queden a la altura de los hombros.\n'
        '2. Apoya la espalda en el respaldo.\n'
        '3. Empuja hacia arriba hasta casi extender los brazos.\n'
        '4. Baja de forma controlada sin que el peso toque el tope.',
    commonMistakes:
        '- Arquear la espalda para empujar.\n'
        '- Bloquear los codos de golpe arriba.',
  ),

  // Biceps
  Exercise(
    id: '1007487c-cd97-4dd7-b3bb-d53c6a33473e',
    name: 'Curl (Barra)',
    primaryMuscle: MuscleGroup.biceps,
    secondaryMuscles: [MuscleGroup.forearms],
    type: ExerciseType.isolation,
    equipment: Equipment.barbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. De pie, toma la barra con agarre supino a la anchura de los hombros.\n'
        '2. Con los codos pegados al cuerpo, sube la barra flexionando los codos.\n'
        '3. Baja de forma controlada hasta extender los brazos.',
    commonMistakes:
        '- Balancear el torso para subir la barra.\n'
        '- Adelantar los codos al subir.',
  ),
  Exercise(
    id: '2615912d-b4d5-4696-9224-df05f54495fd',
    name: 'Curl Alterno (Mancuerna)',
    primaryMuscle: MuscleGroup.biceps,
    secondaryMuscles: [MuscleGroup.forearms],
    type: ExerciseType.isolation,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. De pie, sostén una mancuerna en cada mano con los brazos extendidos.\n'
        '2. Sube una mancuerna girando la palma hacia arriba.\n'
        '3. Baja de forma controlada y repite con el otro brazo.',
    commonMistakes:
        '- Mover el hombro hacia adelante.\n'
        '- Bajar la mancuerna sin control.',
  ),
  Exercise(
    id: 'c287e310-cc96-4407-a9cb-d2680d75c972',
    name: 'Curl Martillo (Mancuerna)',
    primaryMuscle: MuscleGroup.biceps,
    secondaryMuscles: [MuscleGroup.forearms],
    type: ExerciseType.isolation,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. De pie, sostén las mancuernas con las palmas mirándose entre sí.\n'
        '2. Sube flexionando los codos sin girar las muñecas.\n'
        '3. Baja de forma controlada.',
    commonMistakes:
        '- Balancear el cuerpo.\n'
        '- Separar los codos del torso.',
  ),
  Exercise(
    id: '2235a2a8-1820-4fb9-97a6-da4e30c19135',
    name: 'Curl Predicador (Máquina)',
    primaryMuscle: MuscleGroup.biceps,
    secondaryMuscles: [MuscleGroup.forearms],
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento para que la parte posterior de los brazos quede apoyada en el cojín.\n'
        '2. Toma los agarres con las palmas hacia arriba.\n'
        '3. Sube flexionando los codos.\n'
        '4. Baja de forma controlada hasta casi extender los brazos.',
    commonMistakes:
        '- Levantar los codos del cojín.\n'
        '- Dejar caer el peso en la bajada.',
  ),

  // Triceps
  Exercise(
    id: '220852f2-b721-4a37-9271-d3ce2bf0f16c',
    name: 'Press Francés (Barra EZ)',
    primaryMuscle: MuscleGroup.triceps,
    type: ExerciseType.isolation,
    equipment: Equipment.ezBar,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Acostado en el banco, sostén la barra con los brazos extendidos sobre el pecho.\n'
        '2. Flexiona los codos y baja la barra hacia la frente.\n'
        '3. Extiende los codos para volver arriba.',
    commonMistakes:
        '- Abrir los codos hacia afuera.\n'
        '- Mover los hombros en lugar de solo los codos.',
  ),
  Exercise(
    id: '3beb3443-2db7-4771-b08a-e520f04d5b5a',
    name: 'Extensión de Tríceps (Polea)',
    primaryMuscle: MuscleGroup.triceps,
    type: ExerciseType.isolation,
    equipment: Equipment.cable,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Frente a la polea alta, toma la barra o cuerda con los codos pegados al cuerpo.\n'
        '2. Extiende los codos empujando hacia abajo.\n'
        '3. Regresa de forma controlada hasta que los antebrazos queden paralelos al suelo.',
    commonMistakes:
        '- Separar los codos del cuerpo.\n'
        '- Inclinar el torso para empujar con el peso corporal.',
  ),
  Exercise(
    id: 'f36bd82d-782f-440f-b646-a0cee2bf07a8',
    name: 'Press de Banca Agarre Cerrado (Barra)',
    primaryMuscle: MuscleGroup.triceps,
    secondaryMuscles: [MuscleGroup.chest, MuscleGroup.shoulders],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Acostado en el banco, toma la barra con las manos a la anchura de los hombros.\n'
        '2. Baja la barra a la parte baja del pecho con los codos cerca del cuerpo.\n'
        '3. Empuja hasta extender los brazos.',
    commonMistakes:
        '- Usar un agarre demasiado estrecho que fuerza las muñecas.\n'
        '- Abrir los codos al bajar.',
  ),
  Exercise(
    id: '8a799c68-f61f-4549-a25a-f9746b37391b',
    name: 'Extensión de Tríceps (Máquina)',
    primaryMuscle: MuscleGroup.triceps,
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el asiento para que los codos queden alineados con el eje de la máquina.\n'
        '2. Apoya los brazos en el cojín y toma los agarres.\n'
        '3. Extiende los codos hasta casi bloquearlos.\n'
        '4. Regresa de forma controlada.',
    commonMistakes:
        '- Despegar los brazos del cojín.\n'
        '- Recortar el recorrido.',
  ),

  // Forearms
  Exercise(
    id: '1918461f-ae14-48ba-982c-2b0a9c6bb4c5',
    name: 'Curl de Muñeca (Barra)',
    primaryMuscle: MuscleGroup.forearms,
    type: ExerciseType.isolation,
    equipment: Equipment.barbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Sentado, apoya los antebrazos sobre los muslos con las palmas hacia arriba.\n'
        '2. Deja que la barra baje flexionando las muñecas.\n'
        '3. Sube la barra solo con el movimiento de las muñecas.',
    commonMistakes:
        '- Levantar los antebrazos de los muslos.\n'
        '- Usar un peso que impide completar el recorrido.',
  ),
  Exercise(
    id: 'c9ab7a64-5327-4034-ab76-7a0c19acb82e',
    name: 'Paseo del Granjero (Mancuerna)',
    primaryMuscle: MuscleGroup.forearms,
    secondaryMuscles: [MuscleGroup.back, MuscleGroup.abs],
    type: ExerciseType.compound,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Toma una mancuerna pesada en cada mano con los brazos a los costados.\n'
        '2. Camina con pasos cortos, el torso erguido y los hombros hacia atrás.\n'
        '3. Mantén el agarre firme durante toda la distancia o el tiempo elegido.',
    commonMistakes:
        '- Inclinarse hacia un lado.\n'
        '- Encoger los hombros mientras caminas.',
  ),

  // Quadriceps
  Exercise(
    id: '5f1ac738-8dc2-4a2f-9687-a0d88b0bd273',
    name: 'Sentadilla (Barra Alta)',
    primaryMuscle: MuscleGroup.quadriceps,
    secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.hamstrings],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Apoya la barra sobre los trapecios y separa los pies a la anchura de los hombros.\n'
        '2. Toma aire, aprieta el abdomen y baja flexionando caderas y rodillas a la vez.\n'
        '3. Baja hasta que los muslos queden al menos paralelos al suelo.\n'
        '4. Sube empujando el suelo con todo el pie.',
    commonMistakes:
        '- Dejar que las rodillas se vayan hacia adentro.\n'
        '- Levantar los talones del suelo.\n'
        '- Redondear la espalda en la parte baja.',
  ),
  Exercise(
    id: 'e64fc7fd-dda9-40de-a70e-40863cff66a0',
    name: 'Prensa de Piernas (Máquina)',
    primaryMuscle: MuscleGroup.quadriceps,
    secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.hamstrings],
    type: ExerciseType.compound,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Siéntate con la espalda apoyada y los pies en la plataforma a la anchura de las caderas.\n'
        '2. Quita los seguros y baja la plataforma flexionando las rodillas.\n'
        '3. Empuja hasta casi extender las piernas.',
    commonMistakes:
        '- Bloquear las rodillas arriba.\n'
        '- Bajar tanto que la pelvis se despega del asiento.',
  ),
  Exercise(
    id: 'cc9eddc0-38ea-49b0-9cd8-7fe1554e08fe',
    name: 'Extensión de Cuádriceps (Máquina)',
    primaryMuscle: MuscleGroup.quadriceps,
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el respaldo para que las rodillas queden alineadas con el eje de la máquina.\n'
        '2. Coloca el rodillo sobre la parte baja de las espinillas.\n'
        '3. Extiende las rodillas hasta estirar las piernas.\n'
        '4. Baja de forma controlada.',
    commonMistakes:
        '- Usar impulso para subir el peso.\n'
        '- Levantar la cadera del asiento.',
  ),
  Exercise(
    id: '28eda80d-7ebe-495f-a8ba-76729269818e',
    name: 'Sentadilla Búlgara (Mancuerna)',
    primaryMuscle: MuscleGroup.quadriceps,
    secondaryMuscles: [MuscleGroup.glutes],
    type: ExerciseType.compound,
    equipment: Equipment.dumbbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. De espaldas a un banco, apoya el empeine de un pie sobre él.\n'
        '2. Sostén una mancuerna en cada mano.\n'
        '3. Baja flexionando la rodilla delantera hasta que el muslo quede casi paralelo al suelo.\n'
        '4. Sube empujando con la pierna delantera y repite con la otra.',
    commonMistakes:
        '- Colocar el pie delantero demasiado cerca del banco.\n'
        '- Dejar que la rodilla delantera se vaya hacia adentro.',
  ),

  // Hamstrings
  Exercise(
    id: '1356eda2-030b-4f70-a6a5-9ac4d41eb6bf',
    name: 'Peso Muerto Rumano (Barra)',
    primaryMuscle: MuscleGroup.hamstrings,
    secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.back],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. De pie, sostén la barra frente a los muslos con las rodillas ligeramente flexionadas.\n'
        '2. Lleva la cadera hacia atrás y baja la barra pegada a las piernas.\n'
        '3. Baja hasta sentir el estiramiento de los isquiotibiales, con la espalda neutra.\n'
        '4. Sube empujando la cadera hacia adelante.',
    commonMistakes:
        '- Redondear la espalda.\n'
        '- Flexionar demasiado las rodillas y convertirlo en una sentadilla.\n'
        '- Alejar la barra del cuerpo.',
  ),
  Exercise(
    id: '81bf21e4-fd09-4e72-b959-e7f579b81359',
    name: 'Curl Femoral Tumbado (Máquina)',
    primaryMuscle: MuscleGroup.hamstrings,
    secondaryMuscles: [MuscleGroup.calves],
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Acuéstate boca abajo con las rodillas justo fuera del borde del banco.\n'
        '2. Coloca el rodillo sobre la parte baja de las pantorrillas.\n'
        '3. Flexiona las rodillas llevando los talones hacia los glúteos.\n'
        '4. Baja de forma controlada.',
    commonMistakes:
        '- Levantar la cadera del banco.\n'
        '- Dejar caer el peso en la bajada.',
  ),
  Exercise(
    id: 'c45384e1-1514-4ed9-9944-5aed443fa8c2',
    name: 'Curl Femoral Sentado (Máquina)',
    primaryMuscle: MuscleGroup.hamstrings,
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Ajusta el respaldo para que las rodillas queden alineadas con el eje de la máquina.\n'
        '2. Fija los muslos con el soporte y apoya el rodillo sobre las pantorrillas.\n'
        '3. Flexiona las rodillas llevando los talones hacia abajo y atrás.\n'
        '4. Regresa de forma controlada.',
    commonMistakes:
        '- Soporte de muslos demasiado flojo.\n'
        '- Recortar el recorrido.',
  ),

  // Glutes
  Exercise(
    id: 'bde1029f-df8e-41ba-acf5-05191445ef79',
    name: 'Hip Thrust (Barra)',
    primaryMuscle: MuscleGroup.glutes,
    secondaryMuscles: [MuscleGroup.hamstrings],
    type: ExerciseType.compound,
    equipment: Equipment.barbell,
    difficulty: Difficulty.intermediate,
    instructions:
        '1. Apoya la parte alta de la espalda en un banco y coloca la barra sobre la cadera.\n'
        '2. Con los pies firmes en el suelo, empuja la cadera hacia arriba.\n'
        '3. Aprieta los glúteos arriba con el torso alineado con los muslos.\n'
        '4. Baja de forma controlada.',
    commonMistakes:
        '- Arquear la zona lumbar en lugar de extender la cadera.\n'
        '- Colocar los pies demasiado lejos o demasiado cerca.',
  ),
  Exercise(
    id: '0e463b95-e7eb-4a32-b0ce-e122df5cc6b7',
    name: 'Hip Thrust (Máquina)',
    primaryMuscle: MuscleGroup.glutes,
    secondaryMuscles: [MuscleGroup.hamstrings],
    type: ExerciseType.compound,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Siéntate con la espalda en el respaldo y ajusta el cinturón o cojín sobre la cadera.\n'
        '2. Coloca los pies firmes en la plataforma.\n'
        '3. Empuja la cadera hacia arriba hasta alinear torso y muslos.\n'
        '4. Baja de forma controlada.',
    commonMistakes:
        '- Arquear la zona lumbar al final del recorrido.\n'
        '- Empujar con las puntas de los pies.',
  ),
  Exercise(
    id: 'e4c1d810-6797-4e28-8afa-182519270058',
    name: 'Patada de Glúteo (Polea)',
    primaryMuscle: MuscleGroup.glutes,
    secondaryMuscles: [MuscleGroup.hamstrings],
    type: ExerciseType.isolation,
    equipment: Equipment.cable,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Coloca la tobillera en la polea baja y sujétate de la máquina.\n'
        '2. Con el torso ligeramente inclinado, lleva la pierna hacia atrás.\n'
        '3. Aprieta el glúteo al final y regresa de forma controlada.',
    commonMistakes:
        '- Arquear la espalda para subir más la pierna.\n'
        '- Usar impulso.',
  ),
  Exercise(
    id: '6e7e16e0-f751-4601-9cc8-0f29a369a6ad',
    name: 'Abducción de Cadera (Máquina)',
    primaryMuscle: MuscleGroup.glutes,
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Siéntate con la espalda apoyada y los cojines por fuera de las rodillas.\n'
        '2. Separa las piernas empujando los cojines hacia afuera.\n'
        '3. Regresa de forma controlada sin que el peso toque el tope.',
    commonMistakes:
        '- Dejar que las piernas se cierren de golpe.\n'
        '- Despegar la espalda del respaldo.',
  ),

  // Calves
  Exercise(
    id: '6ea42ca7-93da-4006-8134-dacf74b6477f',
    name: 'Elevación de Talones de Pie (Máquina)',
    primaryMuscle: MuscleGroup.calves,
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Coloca los hombros bajo los soportes y la punta de los pies en la plataforma.\n'
        '2. Baja los talones hasta sentir el estiramiento.\n'
        '3. Sube los talones lo más alto posible y mantén un instante arriba.',
    commonMistakes:
        '- Rebotar abajo.\n'
        '- Flexionar las rodillas para ayudarte.',
  ),
  Exercise(
    id: '6250bc77-cf87-440c-bd95-5e443bd7e8fc',
    name: 'Elevación de Talones Sentado (Máquina)',
    primaryMuscle: MuscleGroup.calves,
    type: ExerciseType.isolation,
    equipment: Equipment.machine,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Siéntate con los muslos bajo el soporte y la punta de los pies en la plataforma.\n'
        '2. Baja los talones hasta sentir el estiramiento.\n'
        '3. Sube los talones lo más alto posible.',
    commonMistakes:
        '- Recortar el recorrido.\n'
        '- Subir y bajar demasiado rápido.',
  ),

  // Abs
  Exercise(
    id: '25663005-82d3-4385-8700-1c8a055f9b68',
    name: 'Plancha (Peso Corporal)',
    primaryMuscle: MuscleGroup.abs,
    secondaryMuscles: [MuscleGroup.shoulders],
    type: ExerciseType.isolation,
    equipment: Equipment.bodyweight,
    difficulty: Difficulty.beginner,
    instructions:
        '1. Apoya los antebrazos en el suelo con los codos bajo los hombros.\n'
        '2. Extiende las piernas y forma una línea recta de la cabeza a los talones.\n'
        '3. Aprieta abdomen y glúteos y mantén la posición el tiempo elegido.',
    commonMistakes:
        '- Dejar caer la cadera.\n'
        '- Elevar demasiado los glúteos.',
  ),
  Exercise(
    id: 'd72cd46b-33a3-4be3-b857-ca590f9a2c1c',
    name: 'Crunch (Polea)',
    primaryMuscle: MuscleGroup.abs,
    type: ExerciseType.isolation,
    equipment: Equipment.cable,
    difficulty: Difficulty.beginner,
    instructions:
        '1. De rodillas frente a la polea alta, sostén la cuerda junto a la cabeza.\n'
        '2. Flexiona el torso llevando los codos hacia los muslos.\n'
        '3. Regresa de forma controlada.',
    commonMistakes:
        '- Mover la cadera en lugar de flexionar el torso.\n'
        '- Tirar con los brazos.',
  ),
  Exercise(
    id: '4cd051e5-4299-4b31-9a1f-52eee96fac6f',
    name: 'Elevación de Piernas Colgado (Peso Corporal)',
    primaryMuscle: MuscleGroup.abs,
    secondaryMuscles: [MuscleGroup.forearms],
    type: ExerciseType.isolation,
    equipment: Equipment.bodyweight,
    difficulty: Difficulty.advanced,
    instructions:
        '1. Cuélgate de una barra con los brazos extendidos.\n'
        '2. Eleva las piernas llevando las rodillas o los pies hacia el pecho.\n'
        '3. Baja de forma controlada sin balancearte.',
    commonMistakes:
        '- Balancear el cuerpo para subir las piernas.\n'
        '- Bajar las piernas de golpe.',
  ),
];
