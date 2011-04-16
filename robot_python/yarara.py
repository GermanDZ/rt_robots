import sys
jugadas = [6,3,0,8,6,4,5,6,2]

if __name__ == "__main__":
    jugada = -1
    tablero = sys.argv[1]
    for posicion in jugadas:
        if tablero[posicion] == '-' and jugada == -1: jugada = posicion
    print jugada
