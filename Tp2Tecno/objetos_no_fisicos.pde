class Gesto {

  // --------- variables --------- \\
  float x; // Posición x de gesto
  float y; // Posición y de gesto
  float ancho; // Ancho de gesto
  float alto; // Alto de gesto
  boolean colision; // Evalua si hay colision
  PImage ollaColision;

  boolean colisionDetectada; // para rastrear si se detectó una colisión recientemente
  int tiempoColisionDetectada; //tTiempo en que se detectó la colisión
  int tiempoColisionMaximo = 4000; // duracion máxima de la colisión en milisegundos (3 segundos)


  Gesto (float _x, float _y, float _ancho, float _alto) {
    x = _x; 
    y = _y; 
    ancho = _ancho; 
    alto = _alto; 
    ollaColision = loadImage("img/ollaLuz.png");
  }

  void inicializar(float targetX, float targetY) {
    if (estado == 0 || estado == 3 || estado == 4) { // la colisión gestoIniciar solo se permite en 3 estados (Inicio, ganaste, perdiste)
      if (targetX >= x && targetX <= x + ancho && targetY >= y && targetY <= y + alto) { // Si hay colisión entre Mouse y Botón Central...
        if (!colisionDetectada) {
          // si no se ha detectado la colisión recientemente, la detectamos ahora
          colisionDetectada = true;
          tiempoColisionDetectada = millis(); // Registramos el tiempo de detección
        }

        // verificamos pasaron los 2 segundos para mantener la colisión
        if (millis() - tiempoColisionDetectada >= tiempoColisionMaximo) {
          colision = true; // Si ha pasado el tiempo máximo, dejamos de considerar la colisión
        }
      } else {
        colision = false;
        colisionDetectada = false; // restablecemos la detección de colisión si no colisiona
      }
    }
    // Dibuja la imagen si la colisión está detectada
    if (colisionDetectada && estado == 0) {
      image(ollaColision, 220, 250, 980, 470);
    }
  }
}

// --------- Instrucciones --------- \\
class Instrucciones {
  String [] instrucciones;
  PImage instruccionesImg; // Tiene la imagen del fondo

  Instrucciones() {
    // instrucciones = loadStrings ("instrucciones.txt");
    instruccionesImg = loadImage ("img/instruccionesImg.png");
  }

  void actualizar() {
    image (instruccionesImg, 0, 0); //Instrucciones
  }
}


// --------- Creditos --------- \\
class Creditos {
  PImage creditosImg;
  int posY; // Variable para controlar la posición vertical

  Creditos () {
    creditosImg = loadImage ("img/creditosImg.png");
    posY = height / 2; // Inicializar posY en la mitad de la pantalla
  }

  void actualizar () {
    image (creditosImg, 0, 0); // Fondo de pantalla

    // --------- Titular --------- \\
    push();
    fill(255);
    textSize(50);
    text ("Créditos de \"Un Especial\"", 0, posY, width, height/2);
    pop();

    // --------- Texto --------- \\
    push();
    textSize (30);
    fill (255);
    text ("Física: Ezequiel Ramírez", 0, posY + 100, width, height/2);
    text ("Sonido: Victoria Mestralet", 0, posY + 200, width, height/2);
    text ("Captura de Movimiento: Maria Candela Migone", 0, posY + 300, width, height/2);
    text ("Ilustración: Lara Magallanes Diaz", 0, posY + 400, width, height/2);
    text ("Basado en la Película Ratatouille de Disney-Pixar", 0, posY + 500, width, height/2);
    text ("TECNOLOGIA MULTIMEDIAL 2", 0, posY + 600, width, height/2);
    pop();
    posY--;
  }
}
