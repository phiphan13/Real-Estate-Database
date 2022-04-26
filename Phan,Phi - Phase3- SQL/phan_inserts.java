/* Creates INSERT statements into .sql file using table name and file path.
 * @author HaiHo and Phi Phan
 * made using Visual Studios
 */


import java.io.*;
import java.util.*;

public class phan_inserts {
    
    public static void sqlCreate(String table, String data) {
        try{
            FileWriter sqlData = new FileWriter("phan_inserts.sql", true);
            sqlData.append("INSERT INTO " + table + " VALUES" + "(" + data + ");\n");
            sqlData.close();
            
        } catch (IOException e){
            System.out.println("error " + e.getMessage());
        }
    }
    
    public static void main(String[] args) {
        try {
            Scanner input = new Scanner(System.in);
            
            //Obtain user input
            System.out.println("Type in the table name.");
            String inputName = input.nextLine();
            System.out.println("Type in the path of the file.");
            String inputPath = input.nextLine();
            
            File file = new File(inputPath);
                
                //Reads .csv file
                Scanner dataRead = new Scanner(file);
                
                while (dataRead.hasNextLine()) {
                    String data = dataRead.nextLine();
                    String[] attributes = data.split(",");
                    
                    //Formats attributes into correct datatype
                    for (int i=0; i<attributes.length; i++) {
                        if (attributes[i].matches("-?\\d+") || attributes[i].contentEquals("NULL")) {
                        } else{
                        attributes[i] = "'" + attributes[i]+ "'";
                        }
                        
                        if (attributes[i].matches("(.*)/(.*)/(.*)")) {
                        attributes[i] = "to_date(" + attributes[i] + ",'mm/dd/yyyy')";
                        }
                        
                    }
                    
                    String finalAttr = String.join(",", attributes);
                    
                    //Creates .sql INSERT statements
                    sqlCreate(inputName, finalAttr);
                    
                }
                
                //Adds COMMIT; after file read
                FileWriter sqlData = new FileWriter("phan_inserts.sql", true);
                sqlData.append("COMMIT;\n\n");
                sqlData.close();
                
        } catch (IOException e) {
            System.out.println("error " + e.getMessage());
        }
    }
}