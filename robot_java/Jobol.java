public class Jobol {
  public static void main(String[] args) {
    String tablero = args[0];
    int jugada = -1;
    for(int i=8; i>=0 && jugada < 0; i--) {
      if ("-".equals(tablero.substring(i,i+1))) {
        jugada = i;
      }
    }
    System.out.println(jugada);
  }
}
