/* TIMER
  Written by AdamTheNoob from Processing Forum
  http://processing.org/discourse/yabb2/YaBB.pl?num=1245105034
*/
public class Timer{
  int timer(){
  if(!stopped) {
    mill=(millis()-timerStart);
    if(continued) mill += offset;
    
    seconds = mill / 1000;
    minutes = seconds / 60;
    seconds = seconds % 60;
    hundredths = mill / 10 % 100;
    
  }
  return seconds;
}

void timereset(){ // reset
    stopped = false;
    continued = false;
    timerStart = millis();
  }
  
void timercont(){ // continue
    stopped = false;
    continued = true;
    timerStart = millis();
    
    offset = mill;
  }
}

