
/* 
 Tiek lietota A2 ieeja. Stacionārajā ALGAL16 tas ir pirmais pāris no kreisās puses.
 Pārnesājamos der jebkurā. 
 */

unsigned long laiks0;
float summa;
float skaits;
float videjais;

void setup() 
{
 Serial.begin(9600);
// Serial.begin(19200);
// Serial.begin(38400);
}

void loop()
{
laiks0 = millis();
summa=0;
skaits=0;
videjais=0;

do
{
  summa = summa + analogRead(A2);
  skaits=skaits+1;
 } while (millis() - laiks0 <500);
videjais = summa / skaits;

Serial.println (int(videjais));

}



