import 'package:flutter/material.dart';

const String kUrlApi = 'https://iescarlesvallbona.atmosfera.net/api';


const kMiniBeatMainColor = Color(0xFF657485);
const kMiniBeatGradientFirst = Color(0xFFb4c15c);
const kMiniBeatGradientLast = Color(0xFF525921);

const distanceToSearch = 6;
const kpointsGainedByArtifact = 100;

const kTermsOfService =
    'Benvingut/da a MinibeatGo! Abans de començar a fer-ne ús, si us plau, llegiu amb atenció els nostres Termes i Condicions.\n\n'
    '• La nostra aplicació només recull i guarda el nom d\'usuari que l\'usuari ingressa per a accedir-hi. No recopilem, emmagatzemem ni compartim cap altra informació personal.\n\n'
    '• L\'aplicació només estarà disponible per a ser utilitzada durant el dia de l\'esdeveniment, el 7 de maig de 2023. Passat aquest temps, totes les dades relacionades amb l\'usuari seran eliminades permanentment dels nostres servidors.\n\n'
    '• L\'ús de la nostra aplicació està sotmès a la llei i regulacions aplicables en el territori en què es fa servir.\n\n'
    '• Els usuaris són responsables de la seguretat dels seus noms d\'usuari. No ens fem responsables per cap pèrdua o dany que resulti de l\'ús no autoritzat del seu nom d\'usuari.\n\n'
    '• No tolerem cap forma d\'abús, comportament il·lícit o inapropiat. Si l\'usuari incompleix aquesta condició, ens reservem el dret de suspendre o cancel·lar el seu compte sense avís previ.\n\n'
    '• L\'usuari reconeix que l\'ús de la nostra aplicació és sota la seva responsabilitat i que no ens responsabilitzem per cap pèrdua, dany o perjudici resultant de l\'ús de l\'aplicació.\n\n'
    'Gràcies per fer jugar a MinibeatGo! Si té alguna pregunta o dubte, si us plau, no dubti en contactar\-nos.';


const kHowToUseApp =
    '1. Començar a jugar obrirà una pantalla amb un radar, '
    'que anirà vigilant la teva ubicació dins del recinte. '
    'En el moment en què estiguis a prop d\'una peça del puzle disponible, '
    'notaràs una vibració al teu dispositiu i podràs fer clic a Obrir càmera. '
    'Un cop s\'obri la càmera, busca la peça! De vegades no és fàcil, busca bé al teu voltant i, '
    'un cop la trobis, toca-la per aconseguir-la!\n\n 2. El meu puzle. Aquí veuràs el teu progrés amb '
    'el puzle. Podràs veure les peces que has aconseguit i les que et queden per completar el puzle '
    'al 100%.\n\n 3. Rànquing. Aquí podràs veure un Rànquing general, els jugadors amb més punts i que '
    'abans han arribat a aquests punts sempre seran els primers. El primer que completi el puzle '
    'serà el guanyador!';



final List<String> profilePhotoMessages = [
  "Lamentablement, la teva foto de perfil és com la música de l'ascensor: no la pots canviar.",
  "Som una aplicació de música, no una aplicació de fotografia, així que no podràs canviar la teva foto de perfil.",
  "La teva foto de perfil és tan icònica com la veu de Freddie Mercury, així que no la deixarem canviar.",
  "No puc permetre que canviïs la teva foto de perfil, és com si la bateria de Keith Moon canviés de ritme.",
  "La teva foto de perfil és com el solo de guitarra de Jimi Hendrix, no hi ha cap raó per canviar-la.",
  "No et preocupis per la teva foto de perfil, la música que escoltes ja ens diu tot el que necessitem saber sobre tu!",
  "La teva foto de perfil és tan memorable com la cançó 'Bohemian Rhapsody', no puc permetre que la canviïs.",
  "La teva foto de perfil és com el ritme de 'We Will Rock You' de Queen, ha de ser sempre el mateix!",
  "La teva foto de perfil és com la guitarra de B.B. King, única i inimitable. No la deixarem canviar!",
  "La teva foto de perfil és tan emblemàtica com el logo dels Rolling Stones, no la pots canviar.",
  "La teva foto de perfil és com el groove de James Brown, et representa perfectament!",
  "La teva foto de perfil és com el riff de guitarra de Smoke on the Water de Deep Purple, inoblidable.",
  "La teva foto de perfil és tan increïble com el solo de guitarra de Slash. No la puc deixar canviar.",
  "No podràs canviar la teva foto de perfil, però almenys pots intentar tocar la guitarra com el teu músic preferit.",
  "Aquesta foto ha estat feta amb tot l'amor del món! Per què la vols canviar?",
];
