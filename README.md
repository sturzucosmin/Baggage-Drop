Arhitectura Calculatoarelor
Tema 1 - Baggage Drop
Nume: Sturzu Cosmin
Grupa 332AB 



1) MODULUL "square_root"
    Am folosit metoda CORDIC pentru calcularea radacinii patrate

    Iesirea modulului fiind pe 16 biti avem nevoie de 16 iteratii pentru calcularea rezultatului in registrul y cu ajutorul registrului base care este reprezentat tot pe 16 biti. 
    
    La fieare iteratie base-ul se adauga peste y dupa care se verifica conditia "y*y > in"; daca este adevarata se scoate base-ul din y, iar daca este falsa base-ul ramane si  se continua cu urmatoarea iteratie dupa ce base-ul se shifteaza cu 1 la dreapta.
    
    Pentru a putea compara y*y cu inputul modulului avem nevoie de un registru auxiliar "in_aux" in care sa stocam valoarea lui "in" pe 32 de biti deoarece nr_biti_max(y*y)=32, de asemenea in_aux este shiftat la stanga cu 16, acesta fiind numar natural, partea intreaga reprezentata pe bitii 31:16, iar partea fractionala este 0 si reprezentata pe bitii 15:0. 



####################################################################################

    EXEPLU NUMERIC ALGORITM
    ex: in  = 26, sqrt_results = 0000_0101_0001_1001 

    in_aux = 0000_0000_0000_0000_0000_0000_0001_1010  << 16 =   0000_0000_0001_1010_0000_0000_0000_0000
    base = 1000_0000_0000_0000

    Iteratia 1

    y = y + base = 1000_0000_0000_0000;
    y*y = 100_0000_0000_0000_0000_0000_0000_0000 > in_aux TRUE
    => y = y - base = 0000_0000_0000_0000
    base = base >> 1 = 0100_0000_0000_0000

    Iteratia 2

    y = y + base = 0100_0000_0000_0000;
    y*y = 1_0000_0000_0000_0000_0000_0000_0000 > in_aux  TRUE
    => y = y - base = 0000_0000_0000_0000
    base = base >> 1 = 0010_0000_0000_0000
    
    .....
    ....
    
    Iteratia 6


    y = y + base = 0000_0100_0000_0000
    y*y = 1_0000_0000_0000_0000_0000 > in_aux  FALS 
    => y = 0000_0100_0000_0000
    base = 0000_0010_0000_0000

    Iteratia 7
    
    y =  y + base =  0000_0110_0000_0000
    y*y = 10_0100_0000_0000_0000_0000 > in_aux TRUE 
    => y = y - base = 0000_0100_0000_0000
    base = base >> 1 = 0000_0001_0000_0000 

    Iteratia 8
    
    y = y + base = 0000_0101_0000_0000
    y*y = 1_1001_0000_0000_0000_0000 > in_aux FALS 
    => y = 0000_0101_0000_0000
    base = base >> 1 = 0000_0000_1000_0000

    Iteratia 9
    
    y = y + base = 0000_0101_1000_0000
    y*y = 1_1110_0100_0000_0000_0000 > in_aux true 
    => y = y - base = 0000_0101_0000_0000
    base = base >> 1 = 0000_0000_0100_0000
    
    ...
    ...
    
    Iteratia 12
    
    y = y + base = 0000_0101_0001_0000
    y*y = 1_1001_1010_0001_0000_0000 > in_aux FALS 
    => y = 0000_0101_0001_0000
    base = base >> 1 = 0000_0000_0000_1000

    Iteratia 13 
    
    y = y + base = 0000_0101_0001_1000
    y*y = 1100_1111_1001_0010_0000 > in_aux FALS
    => y = 0000_0101_0001_1000
    base = 0000_0000_0000_0100
    
    ...
    ...
#########################################################################################

2) MODULUL sensors_input
    Exista 3 posibilitati de a calcula media senzorilor 
        
        1.Senzorul 1 sau 3 este 0 => medie aritmetica de 2 numere

        2.Senzorul 2 sau 3 este 0 => medie aritmetica de 2 numere
        
        3.Niciun senzor nu este 0 => medie aritmetica de 4 numere

    In cazul 1 sau 2 suma se salveaza intr-un registru data_sum2 care se shifteaza la dreapta cu 1 pentru impartirea la 2 necesara calcularii mediei. Pentru aproximare se verifica daca data_sum2 este impar prin verificarea bitului 0 (2^0 = 1), daca este se adauga 1 la valoarea finala a mediei pentru aproximare.

    In cazul 3 suma se salveaza intr-un registru data_sum4 care se shifteaza la dreapta cu 2 pentru impartirea la 4 necesara calcularii mediei. Pentru aproximare se verifica daca (data_sum4 >> 1)este impar prin verificarea bitului 1 din data_sum4, daca este se adauga 1 la valoarea finala a mediei pentru aproximare.

##############################################################################################

3) MODULUL display_and_sdrop

    Am creat registrii pe 7 biti pentru fiecare litera necesara afisarii 

    Exista 3 cazuri de afisare, fiecare cu conditiile necesare in functie de t_act, t_lim si drop_en, valori ce sunt primite ca input. In functie de cazul valid fiecare display primeste litera corespunzatoare pentru afisarea starii deeclansatorului.


##############################################################################################

3) MODULUL baggage_drop

    In acest modul am calculat inaltimea cu ajotorul modului sensors_input. Iesirea de la sensors_input a devenit intrare pentru modulul square_root. Cu iesirea din square_root (height_square_root) am calculat t_act cu ajutorul formulei din enunt. In final m-am folosit de ultimnul modul, display_and_drop pentru afisarea mesajului si activarea lansatorului, acesta din urma avand ca input t_act calculat inainte si t_lim + drop_en date ca input-uri ale modulului.