
import processing.serial.*;

PFont f;  
int [] edr;
int w=0;
int vieta=0;
int kluda=0;
float summa25=0;
float kgr=0;
int i=0;
int[] r;
int[] rr;
int[] rrr;
int skaits=0;
int kopskaits=0;
int z=0;
int iepr=0;
float sum=0;
int v=0;
Serial myPort;
PrintWriter output1;
PrintWriter output2;
PrintWriter output3;


void setup() {
  size (900,500);  
  f = createFont("Arial",16,true);
  textFont(f,16);
  edr = new int [100000];
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  
r = new int[10000];
rr = new int[10000];
rrr = new int[10000];

output1 = createWriter("rawdataarzimem.txt");
output2 = createWriter("editeddataarzimem.txt");
output3 = createWriter("editeddatabezzimem.txt");
  
}

void draw() {
  
  if ( myPort.available() > 0) 
  {
    String inBuffer = myPort.readStringUntil('\n'); 
      if (inBuffer != null) {
      i = Integer.parseInt(inBuffer.trim());
      kopskaits=kopskaits+1;
      edr [kopskaits] = i;
      println (edr [kopskaits]); 
     
      background(#266FA5);
      fill(#EDE378);
      textSize(36);
      text("MOMENTĀNAIS EDR = ",100,200);
      textSize(64); text(i,700,200);

rrr[kopskaits]=i;

if (kopskaits>=5){
kluda=0;
kgr=edr[kopskaits] - edr[kopskaits-1];
kgr= kgr*100/edr[kopskaits-1];  
if (edr[kopskaits]<200){kgr=0;stroke(#F52C2C); kluda=5;}
if (kgr<-10){kgr=0;stroke(#F52C2C); kluda=5;}
if (kgr>10){kgr=0;stroke(#F52C2C); kluda=5;}
if (kluda==0) {z=z+1; r[z]=i; rr[z]=i; skaits=skaits+1; iepr=i;} 
} // beigas if (kopskaits>=5){

  if (skaits==30){
  sum=0;
  for (v=1; v<=30; v++) {sum=sum+rr[z];}
  sum=sum/30;  
  skaits=0;
  } // if skaits>30...  
  
  textSize(48);
  text ("VIDĒJAIS EDR = ",100,300); text (int(sum), 700, 300);
      
       
            
   } // if inBuffer...
  } // if myPort....


} // void draw


void keyPressed() { // Press a key to save the data

if (key == 'z'){
 saveFrame("output-####.png");
 }

 if (key == '1'){
 println(1);
 rrr[kopskaits-2]=1;
 rr[z-2]=1;
 }

 if (key == '2'){
 println(2);
 rrr[kopskaits-2]=2;
 rr[z-2]=2;
 }

if (key == 'b'){
for (v=1; v<= kopskaits; v++){output1.println(rrr[v]);}
output1.flush(); // Write the remaining data
output1.close(); // Finish the file
for (v=1; v <= z; v++){output2.println(rr[v]);}
output2.flush(); // Write the remaining data
output2.close(); // Finish the file
for (v=1; v <= z; v++){output3.println(r[v]);}
output3.flush(); // Write the remaining data
output3.close(); // Finish the file
exit(); // Stop the program 
}
 
} // beidzas if key pressed
 