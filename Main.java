import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.*;
import java.util.Scanner;

public class Main{
    public static void main(String[] args) {
    
    try {
        FileReader archivo = new FileReader("datos.txt");
        BufferedReader br = new BufferedReader(archivo);
        String driver = br.readLine();
        String base_de_datos = br.readLine();
        String user = br.readLine();
        String pass = br.readLine();
        br.close();

        Class.forName(driver);
        Connection conn = DriverManager.getConnection("jdbc:postgresql://" + base_de_datos, user, pass);

        Scanner scanner = new Scanner(System.in);
        int num;

      do {
            System.out.println("Indique una opción según el número:");
            System.out.println("1. Agregar un padrino");
            System.out.println("2. Eliminar un donante");
            System.out.println("3. Listar padrinos y programas a los que aportan");
            System.out.println("4. Salir");

            num = scanner.nextInt();
            scanner.nextLine();

            switch (num) {
                case 1:
                    agregarPadrino(conn, scanner);
                    break;
                case 2:
                    eliminarDonante(conn, scanner);
                    break;
                case 3:
                    listarPadrinosyProgramas(conn , scanner);
                    break;
                case 4:
                    System.out.println("Saliendo del sistema");
                    break;
                default:
                    System.out.println("Opción no válida.");
                    break;
            }

        } while (num != 4);

        conn.close(); 
        
    }catch (Exception error) {
            System.out.println("Error al conectar con la base de datos");
            return;
        }
    }

    public static void agregarPadrino(Connection conn, Scanner scanner){


        System.out.println("Ingrese Dni (sin puntos ni comas): ");
        String dni = scanner.nextLine();

        System.out.println("Ingrese nombre y apellido:  ");
        String nombreYApellido = scanner.nextLine();

        System.out.println("Ingrese direccion:  ");
        String direcc = scanner.nextLine();

        System.out.println("Ingrese usuario de facebook: ");
        String userfb = scanner.nextLine();

        System.out.println("Ingrese mail: ");
        String mail = scanner.nextLine();

        System.out.println("Ingrese cod_postal: ");
        String cod_postal = scanner.nextLine();


        try{
        String sql = "INSERT INTO ciudad.padrino (dni, nombre_y_ape, direccion,facebook,mail,cod_postal) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement padrino = conn.prepareStatement(sql);

            padrino.setString(1, dni);
            padrino.setString(2, nombreYApellido);
            padrino.setString(3, direcc);
            padrino.setString(4, userfb);
            padrino.setString(5, mail);
            padrino.setString(6, cod_postal);
            padrino.executeUpdate();
            padrino.close();

            System.out.println(" Padrino insertado correctamente");

            }catch (Exception error) {
            System.out.println("Error al insertar padrino");
        }



    }

    public static void eliminarDonante(Connection conn, Scanner scanner) {
        
        

        try {

        String lista = "SELECT DISTINCT d.dni, p.nombre_y_ape " +
               "FROM ciudad.donante d " +
               "JOIN ciudad.padrino p ON d.dni = p.dni";
        PreparedStatement statement1 = conn.prepareStatement(lista);

        ResultSet Rlista = statement1.executeQuery();

        while (Rlista.next()) {
            
                String dnii = Rlista.getString("dni");
                String nombre = Rlista.getString("nombre_y_ape");

            System.out.printf("DNI: %s | Nombre: %s%n", dnii, nombre);
        }

        Rlista.close();
        statement1.close();

        System.out.println("Ingrese dni del donante a eliminar: ");
        String dni = scanner.nextLine();
            
            String consulta = "DELETE FROM ciudad.donante WHERE dni = ?";
            PreparedStatement statement = conn.prepareStatement(consulta);
            statement.setString(1, dni);
            int modificados = statement.executeUpdate();
            statement.close();

            if (modificados == 1) {
                System.out.println("Se borró exitosamente");
            } else {
                System.out.println("No se encontró un donante con ese DNI");
            }

        } catch (Exception error) {
            System.out.println("Error al eliminar donante");
            return;
        }
    }


    
    public static void listarPadrinosyProgramas(Connection conn, Scanner scanner){

        
            
            String consulta = "SELECT ciudad.padrino.dni, ciudad.padrino.nombre_y_ape, programa.nombre AS nombre_programa, aportan.monto, aportan.frecuencia \n" +
                  "FROM ciudad.padrino \n" +
                  "JOIN ciudad.aportan ON ciudad.padrino.dni = ciudad.aportan.dni \n" +
                  "JOIN ciudad.programa ON ciudad.aportan.id_programa = ciudad.programa.id_programa";

            try{
            PreparedStatement statement = conn.prepareStatement(consulta);
            ResultSet RTabla = statement.executeQuery();


            while (RTabla.next()) {

                String dni = RTabla.getString("dni");
                String nombre = RTabla.getString("nombre_y_ape");
                String programa = RTabla.getString("nombre_programa");
                int monto = RTabla.getInt("monto");
                String frecuencia = RTabla.getString("frecuencia");

                System.out.printf("DNI: %s | Nombre: %s | Programa: %s | Monto: $%d | Frecuencia: %s%n",
                        dni, nombre, programa, monto, frecuencia);
            }

            RTabla.close();
            statement.close();
    }catch(Exception error){    
        System.out.println("Error al eliminar donante");
        return;
        }
    }

}
