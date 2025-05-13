object toretto {
  const autos = #{}

  method comprarAuto(autoX) {
    autos.add(autoX)
  }

  method autosEnCondiciones() = autos.filter({a => a.estaEnCondiciones()})
  method autosNoEnCondiciones() = autos.filter({a => not a.estaEnCondiciones()})

  method mandarAutosAlTaller() {
    taller.recibirAutos(self.autosEnCondiciones())
  }

  method realizarPruebas() {
    autos.forEach({a => a.prueba()})
  }

  method venderTodos() {
    autos.clear() 
  }

  method promedioVelocidades() = autos.sum({a => a.velocidadMaxima()}) / autos.size()

  method autoMasRapidoEnCondiciones() {
    return self.autosEnCondiciones().max({a => a.velocidadMaxima()})
  }

  method autoMuyRapido() {
    return self.autoMasRapidoEnCondiciones().velocidadMaxima() > self.promedioVelocidades() * 2
  } 
}

object taller {
  const autosRotos = #{}
  method velocidadMaxima() = 110

  method recibirAutos(autosX) {
    autosRotos.addAll(autosX)
  }

  method repararAutos() {
    autosRotos.forEach({a => a.reparar()})
  }
}


object ferrari {
  var motor = 87
  method motor(cant){motor = cant}

  method estaEnCondiciones() {
    return motor <= 65
  }

  method reparar() {
    motor = 100
  }

  method velocidadMaxima() = 110 + if(motor > 75) 15 else 110

  method prueba() {
    motor = (motor - 30).max(0)
  }
}


object flecha {
  var nivelCombustible = 100
  var color = azul
  var tipoGasolina = gasolina
  method tipoGasolina(tipo) {tipoGasolina = tipo}

  method estaEnCondiciones() {
    return nivelCombustible > tipoGasolina.nivelMinimo() and 
    color.esApto()
  }

  method reparar() {
    nivelCombustible * 2
    color = color.cambiarColor()
  }

  method prueba() {
    nivelCombustible = (nivelCombustible - 5).max(0)
  }

  method velocidadMaxima() {
    return nivelCombustible * 2 + tipoGasolina.calculoAdicional(nivelCombustible)
  }
}

object gasolina {
    method nivelMinimo() = 85
    method calculoAdicional(litros) = 10
}
object nafta {
    method nivelMinimo() = 50
    method calculoAdicional(litros) =  (((litros * 10) / 100)*2)*-1
}
object nitrogeno {
    method nivelMinimo() = 0
    method calculoAdicional(litros) = litros * 2 * 10
}

object azul {
    method cambiarColor() = verde
    method esApto() = false 
}
object rojo {
    method cambiarColor() = azul
    method esApto() = true
}
object verde {
    method cambiarColor() = rojo
    method esApto() = false 
}