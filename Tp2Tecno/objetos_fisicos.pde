// --------- Verduras --------- \\
class Verdura extends FCircle {
  PImage[] verduraImgDer, verduraImgIzq;
  String lado;
  float anguloVel = 40;
  float velocidad = 500;
  float angulo = radians(random (-85, -90));
  float anguloVerdura;
  float vxVerdura;
  float vyVerdura;
  float posX;
  float posY;

  Verdura (String _lado) {
    super (50);
    lado = _lado;

    verduraImgIzq = new PImage[2];
    verduraImgDer = new PImage[2];

    for (int i = 0; i < 2; i++) {
      verduraImgIzq[i] = loadImage ("img/verduraIzq" + i + ".png");
      verduraImgDer[i] = loadImage ("img/verduraDer" + i + ".png");
    }

    setGrabbable (false); // ¿Se puede agarrar? *va false
    setStatic (false); // ¿Es estático?
    setRestitution (1);
    setDamping (-2);
  }

  void inicializar () {
    if (lado.equals("verduraIzq")) {
      setName ("verduraIzq");
      attachImage (verduraImgIzq[int (random(0, 2))]);
      jugando.verduraPrevia = lado;
      posY = random(50, 150);
      posX = -5;
      setPosition (posX, posY); // Asignacion de posición
      anguloVerdura = angulo + radians(90);
      vxVerdura = velocidad * cos(anguloVerdura);
      vyVerdura = velocidad * sin(anguloVerdura);
      setVelocity(vxVerdura, vyVerdura);
    } else if (lado.equals("verduraDer")) {
      setName ("verduraDer");
      attachImage (verduraImgDer[int (random(0, 2))]);
      jugando.verduraPrevia = lado;
      posY = random(50, 100);
      posX = width + 5;
      setPosition (posX, posY); // Asignacion de posición
      anguloVerdura = angulo - radians(90);
      vxVerdura = velocidad/2 * cos(anguloVerdura);
      vyVerdura = velocidad * sin(anguloVerdura);
      setVelocity(vxVerdura, vyVerdura);
    }
  }
}


// --------- Ollas --------- \\
class Olla extends FBox {
  PImage[] ollaImgDer, ollaImgIzq;
  PImage[] vaporDer, vaporIzq;
  String lado;
  int frameAnimacion;

  Olla (float _w, float _h, String _lado) {
    super (_w, _h);
    lado = _lado;

    ollaImgIzq = new PImage[2];
    ollaImgDer = new PImage[2];
    vaporDer = new PImage[2];
    vaporIzq = new PImage[2];


    for (int i = 0; i < 2; i++) {
      vaporDer[i] = loadImage ("img/vaporDer" + i + ".png");
      vaporIzq[i] = loadImage ("img/vaporIzq" + i + ".png");
      ollaImgIzq[i] = loadImage ("img/ollaIzq" + i + ".png");
      ollaImgDer[i] = loadImage ("img/ollaDer" + i + ".png");
    }
  }

  void actualizar () {
    if (frameCount % 15 == 0) {
      frameAnimacion = (frameAnimacion + 1) % 2;
    }

    if (lado.equals("ollaDer")) {
      setName ("ollaDer"); // Asignacion de nombre
      attachImage(ollaImgDer[frameAnimacion]);
      image (vaporDer[frameAnimacion], width - 300, height -  675);
      setPosition (width - 200 / 2, height -  240 / 2 - 130); // Asignacion de posición
      setGrabbable (false); // ¿Se puede agarrar? *va false
      setStatic (true); // ¿Es estático?}
    } else if (lado.equals("ollaIzq")) {
      setName ("ollaIzq"); // Asignacion de nombre
      attachImage(ollaImgIzq[frameAnimacion]);
      image (vaporIzq[frameAnimacion], 0, height -  675);
      setPosition (200 / 2, height -  240 / 2 - 130); // Asignacion de posición
      setGrabbable (false); // ¿Se puede agarrar? *va false
      setStatic (true); // ¿Es estático?
    }
  }
}


// --------- Jugador --------- \\
class Jugador extends FBox {
  PImage jugadorImg;

  Jugador(float _ancho, float _alto) {
    super (_ancho, _alto);
    setName ("jugador"); // Asignacion de nombre
    setRotatable (false); // ¿Es estático?
    jugadorImg = loadImage ("img/jugadorImg.png");
  }

  void inicializar () {
    attachImage(jugadorImg);
    setPosition (width / 2, height - 119 / 2 - 120); // Asignacion de posición
    setGrabbable (false); // ¿Se puede agarrar? *va false
  }
}


// --------- funcion colision --------- \\
String  conseguirNombre (FBody body) {
  String nombre = "nada";
  if (body != null) {
    nombre = body.getName();
    if (nombre == null) {
      nombre = "nada";
    }
  }
  return nombre;
}


void contactStarted (FContact colision) {
  FBody _body1 = colision.getBody1();
  FBody _body2 = colision.getBody2();

  String nombre1 = conseguirNombre (_body1);
  String nombre2 = conseguirNombre (_body2);

  if ((nombre1.equals("verduraIzq") && nombre2.equals("ollaDer")) || (nombre2.equals ("verduraIzq") && nombre1.equals("ollaDer"))) {
    println (nombre1, nombre2);
    if (nombre1.equals("verduraIzq") && colision.getNormalY() > 0) {
      reproducirEv (4);
      jugando.remyEstado = 4;
      jugando.puntos++;
      println ("puntos: " + jugando.puntos);
      jugando.limpiar();
    } else if (nombre2.equals("verduraIzq") && colision.getNormalY() < 0) {
      reproducirEv (4);
      jugando.remyEstado = 4;
      jugando.puntos++;
      println ("puntos: " + jugando.puntos);
      jugando.limpiar();
    }
  } else if ((nombre1.equals("verduraIzq") && nombre2.equals("ollaIzq")) || (nombre2.equals ("verduraIzq") && nombre1.equals("ollaIzq"))) {
    println (nombre1, nombre2);
    if (nombre1.equals("verduraIzq") && colision.getNormalY() > 0) {
      println ("perdiste");
      reproducirEs (3);
      estado = 4; // cambio de estado
      jugando.puntos = 0;
      jugando.limpiar();
    } else if (nombre2.equals("verduraIzq") && colision.getNormalY() < 0) {
      println ("perdiste");
      reproducirEs (3);
      estado = 4; // cambio de estado
      jugando.puntos = 0;
      jugando.limpiar();
    }
  } else if ((nombre1.equals("verduraIzq") && nombre2.equals("piso")) || (nombre2.equals ("verduraIzq") && nombre1.equals("piso"))) {
    //println (nombre1, nombre2);
    reproducirEv (2);
    jugando.remyEstado = 2;
    jugando.verduraIzq.setVelocity(0, 0);
    jugando.verduraIzq.setRestitution (0);
    jugando.verduraIzq.setDamping (0);
  } else if ((nombre1.equals("verduraDer") && nombre2.equals("piso")) || (nombre2.equals ("verduraDer") && nombre1.equals("piso"))) {
    //println (nombre1, nombre2);
    reproducirEv (2);
    jugando.remyEstado = 2;
    jugando.verduraDer.setVelocity(0, 0);
    jugando.verduraDer.setRestitution (0);
    jugando.verduraDer.setDamping (0);
  } else if ((nombre1.equals("verduraIzq") && nombre2.equals("jugador")) || (nombre2.equals ("verduraIzq") && nombre1.equals("jugador"))) {
    println (nombre1, nombre2);
    reproducirEv (1);
  } else if ((nombre1.equals("verduraDer") && nombre2.equals("jugador")) || (nombre2.equals ("verduraDer") && nombre1.equals("jugador"))) {
    println (nombre1, nombre2);
    reproducirEv (1);
  } else if ((nombre1.equals("verduraDer") && nombre2.equals("ollaIzq")) || (nombre2.equals ("verduraDer") && nombre1.equals("ollaIzq"))) {
    if (nombre1.equals("verduraDer") && colision.getNormalY() > 0) {
      reproducirEv (4);
      jugando.remyEstado = 4;
      jugando.puntos++;
      println ("puntos: " + jugando.puntos);
      jugando.limpiar();
    } else if (nombre2.equals("verduraDer") && colision.getNormalY() < 0) {
      reproducirEv (4);
      jugando.remyEstado = 4;
      jugando.puntos++;
      println ("puntos: " + jugando.puntos);
      jugando.limpiar();
    }
  } else if ((nombre1.equals("verduraDer") && nombre2.equals("ollaDer")) || (nombre2.equals ("verduraDer") && nombre1.equals("ollaDer"))) {
    if (nombre1.equals("verduraDer") && colision.getNormalY() > 0) {
      println ("perdiste");
      reproducirEs (3);
      estado = 4; // cambio de estado
      jugando.puntos = 0;
      jugando.limpiar();
    } else if (nombre2.equals("verduraDer") && colision.getNormalY() < 0) {
      println ("perdiste");
      reproducirEs (3);
      estado = 4; // cambio de estado
      jugando.puntos = 0;
      jugando.limpiar();
    }
  }
}

void contactPersisted (FContact colision) {
  jugando.colisionConBarra = false;
  FBody _body1 = colision.getBody1();
  FBody _body2 = colision.getBody2();

  String nombre1 = conseguirNombre (_body1);
  String nombre2 = conseguirNombre (_body2);

  if ((nombre1.equals("verduraIzq") && nombre2.equals("piso")) || (nombre2.equals ("verduraIzq") && nombre1.equals("piso"))) {
    jugando.evaluarColisionBarra ();
    println (jugando.colisionConBarra);
    if (jugando.colisionConBarra) {
      reproducirEv (3);
      jugando.limpiar();
    }
  } else if ((nombre1.equals("verduraDer") && nombre2.equals("piso")) || (nombre2.equals ("verduraDer") && nombre1.equals("piso"))) {
    jugando.remyEstado =3;
    jugando.evaluarColisionBarra ();
    println (jugando.colisionConBarra);
    if (jugando.colisionConBarra) {
      reproducirEv (3);
      jugando.limpiar();
    }
  }
}
