import TUIO.*;
import ddf.minim.*;
import ddf.minim.javasound.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer[] player=new AudioPlayer[3];
AudioPlayer clipped;
AudioPlayer click;
AudioPlayer welldone;
AudioInput input;
int r=(int)random(3);
/*Variables for timer*/
Timer times= new Timer();
int timerStart = 0;
int offset;

int mill;
int minutes;
int seconds;
int hundredths;

boolean stopped = false;
boolean continued = false;

TuioProcessing tuioClient;

HashMap placed=new HashMap();
HashMap symbols=new HashMap();
HashMap rotation=new HashMap();
HashMap audio=new HashMap();
HashMap rposition=new HashMap();
HashMap correct=new HashMap();

//Creating the image array for the backgrounds
PImage[]img=new PImage[3];
//Creating a randome number between 0 and 2 to represent the position of background image in the array
int opt=(int)random(3);

int x0=0;
int y0=0;
int x0l=0;
int y0l=0;
int x0r=0;
int y0r=0;
int x1=0;
int y1=0;
int x1l=0;
int y1l=0;
int x1r=0;
int y1r=0;
int x2=0;
int y2=0;
int x2l=0;
int y2l=0;
int x2r=0;
int y2r=0;
int x3=0;
int y3=0;
int x3l=0;
int y3l=0;
int x3r=0;
int y3r=0;
int x4=0;
int y4=0;
int x4l=0;
int y4l=0;
int x4r=0;
int y4r=0;
int x5=0;
int y5=0;
int x5l=0;
int y5l=0;
int x5r=0;
int y5r=0;
int x6=0;
int y6=0;
int x6l=0;
int y6l=0;
int x6r=0;
int y6r=0;
int x7=0;
int y7=0;
int x7l=0;
int y7l=0;
int x7r=0;
int y7r=0;
int x8=0;
int y8=0;
int x8l=0;
int y8l=0;
int x8r=0;
int y8r=0;
int x9=0;
int y9=0;
int x9l=0;
int y9l=0;
int x9r=0;
int y9r=0;
int x10=0;
int y10=0;
int x10l=0;
int y10l=0;
int x10r=0;
int y10r=0;
int x11=0;
int y11=0;
int x11l=0;
int y11l=0;
int x11r=0;
int y11r=0;
int x12=0;
int y12=0;
int x12l=0;
int y12l=0;
int x12r=0;
int y12r=0;
int x13=0;
int y13=0;
int x13l=0;
int y13l=0;
int x13r=0;
int y13r=0;
int x14=0;
int y14=0;
int x14l=0;
int y14l=0;
int x14r=0;
int y14r=0;
int x15=0;
int y15=0;
int x15l=0;
int y15l=0;
int x15r=0;
int y15r=0;
int x16=0;
int y16=0;
int x16l=0;
int y16l=0;
int x16r=0;
int y16r=0;
int x17=0;
int y17=0;
int x17l=0;
int y17l=0;
int x17r=0;
int y17r=0;
int aud1=0;
int aud2=0;
int aud3=0;
int aud4=0;
int aud5=0;
int aud6=0;
void setup(){  
  
//assigning the images into the array
  img[0] = loadImage("Stage 2 unfurnishedopt1.jpg");
  img[1] = loadImage("Stage 2 unfurnished 2.jpg");
  img[2] = loadImage("Stage 2 unfurnished 3.jpg");
  
  size(950,717);
  background(img[opt]);
  minim = new Minim(this);
  player[0] = minim.loadFile("playhouse1.mp3");
  player[1] = minim.loadFile("playhouse2.mp3");
  player[2] = minim.loadFile("playhouse3.mp3");
  welldone= minim.loadFile("welldone.mp3");
  clipped = minim.loadFile("click.mp3");
  input = minim.getLineIn();
  player[r].play();
  player[r].loop();
  player[r].setGain(-5); //set Volume
  
    PImage bed1=loadImage("Bed1_center.png");
    symbols.put(0, bed1);
    PImage bed2=loadImage("Bed2_center.png");
    symbols.put(1, bed2);
    PImage bed3=loadImage("Bed3_center.png");
    symbols.put(2, bed3);
    PImage drawer1=loadImage("Drawer1_center.png");
    symbols.put(3, drawer1);
    PImage drawer2=loadImage("Drawer2_center.png");
    symbols.put(4, drawer2);
    PImage drawer3=loadImage("Drawer3_center.png");
    symbols.put(5, drawer3);
    PImage lamp1=loadImage("Lamp1_center.png");
    symbols.put(6, lamp1);
    PImage lamp2=loadImage("Lamp2_center.png");
    symbols.put(7, lamp2);
    PImage lamp3=loadImage("Lamp3_left.png");
    symbols.put(8, lamp3);
    PImage portrait1=loadImage("Portrait1_center.png");
    symbols.put(9, portrait1);
    PImage portrait2=loadImage("Portrait2_center.png");
    symbols.put(10, portrait2);
    PImage portrait3=loadImage("Portrait3_center.png");
    symbols.put(11, portrait3);
    PImage sofa1=loadImage("Sofa1_center.png");
    symbols.put(12, sofa1);
    PImage sofa2=loadImage("Sofa2_center.png");
    symbols.put(13, sofa2);
    PImage sofa3=loadImage("Sofa3_center.png");
    symbols.put(14, sofa3);
    PImage Wardrobe1=loadImage("Wardrobe1_center.png");
    symbols.put(15, Wardrobe1);
    PImage Wardrobe2=loadImage("Wardrobe2_center.png");
    symbols.put(16, Wardrobe2);
    PImage Wardrobe3=loadImage("Wardrobe3_center.png");
    symbols.put(17, Wardrobe3);

    
    tuioClient  = new TuioProcessing(this);       
  loop();
}
void draw(){
  background(img[opt]);
  TuioObject[] tuioObjectList = sortObjs(tuioClient.getTuioObjects());
    for (int i=0;i<tuioObjectList.length;i++) {
    TuioObject tobj = tuioObjectList[i];
    pushMatrix();
    translate(tobj.getScreenX(950),tobj.getScreenY(717));
    rotate(tobj.getAngle());
    float angle=tobj.getAngleDegrees();
    int id = tobj.getSymbolID();
    println("X = "+tobj.getScreenX(950)+" Y = "+tobj.getScreenY(717)+" Symbol id is "+ id);   
             
        if (symbols.containsKey(id)){
                           
          
                 //image((PImage)symbols.get(id),0,0);
              if (tuioObjectList[i].getSymbolID()==0&&tuioObjectList[i].getScreenX(950)<=324)
               {
                     image((PImage)symbols.get(id),-45,-70);
                     PImage bed1=loadImage("Bed1_left.png");
                     symbols.put(0, bed1);
                     rposition.put(0,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==0&&tuioObjectList[i].getScreenX(950)>=551)
               {
                     image((PImage)symbols.get(id),-145,-70);
                     PImage bed1=loadImage("Bed1_right.png");
                     symbols.put(0, bed1);
                     rposition.put(0,"TRUE");
               }else if(tuioObjectList[i].getSymbolID()==0){
                     
                     image((PImage)symbols.get(id),-45,-70);
                     PImage bed1=loadImage("Bed1_center.png");
                     symbols.put(0, bed1);
                     rposition.put(0,"TRUE");
                     }
                     
                      
               }
               
               if (tuioObjectList[i].getSymbolID()==1&&tuioObjectList[i].getScreenX(950)<=350)
               {
                     PImage bed2=loadImage("Bed2_left.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-30,-120);
                     rposition.put(1,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==1&&tuioObjectList[i].getScreenX(950)>=573)
               {
                     PImage bed2=loadImage("Bed2_right.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-250,-100);
                     rposition.put(1,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==1){
                     PImage bed2=loadImage("Bed2_center.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-70,-50);
                     rposition.put(1,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)<=343)
               {
                     PImage bed3=loadImage("Bed3_left.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(2,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)>=557)
               {
                     PImage bed3=loadImage("Bed3_right.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-100,-50);
                     rposition.put(2,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==2){
                     PImage bed3=loadImage("Bed3_center.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-70,-100);
                     rposition.put(2,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==3&&tuioObjectList[i].getScreenX(950)<=312)
               {
                     PImage drawer1=loadImage("Drawer1_left.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(3,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==3&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage drawer1=loadImage("Drawer1_right.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(3,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==3){
                     PImage drawer1=loadImage("Drawer1_center.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-30,-50);
                     rposition.put(3,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)<=315)
               {
                     PImage drawer2=loadImage("Drawer2_left.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-100,-100);
                     rposition.put(4,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage drawer2=loadImage("Drawer2_right.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-20,-70);
                     rposition.put(4,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==4){
                     PImage drawer2=loadImage("Drawer2_center.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(4,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)<=315)
               {
                     PImage drawer3=loadImage("Drawer3_left.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(5,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage drawer3=loadImage("Drawer3_right.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(5,"TRUE");
                     
               }else if (tuioObjectList[i].getSymbolID()==5){
                     PImage drawer3=loadImage("Drawer3_center.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(5,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)<=267)
               {
                     PImage Lamp1=loadImage("Lamp1_left.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-35,-150);
                     rposition.put(6,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Lamp1=loadImage("Lamp1_right.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-55,-50);
                     rposition.put(6,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==6){
                     PImage Lamp1=loadImage("Lamp1_center.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(6,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)<=297)
               {
                     PImage Lamp2=loadImage("Lamp2_right.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(7,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)>=658)
               {
                     PImage Lamp2=loadImage("Lamp2_right.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(7,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==7){
                     PImage Lamp2=loadImage("Lamp2_center.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(7,"TRUE");
               }
               
               
               if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)<=307)
               {
                     PImage Lamp3=loadImage("Lamp3_left.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-35,-150);
                     rposition.put(8,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)>=655)
               {
                     PImage Lamp3=loadImage("Lamp3_left.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-15,-150);
                     rposition.put(8,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==8){
                     PImage Lamp3=loadImage("Lamp3_center.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(8,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)<=301)
               {
                     PImage Portrait1=loadImage("Portrait1_left.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-45,-80);
                     rposition.put(9,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)>=629)
               {
                     PImage Portrait1=loadImage("Portrait1_right.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(9,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==9){
                     PImage Portrait1=loadImage("Portrait1_center.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(9,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)<=297)
               {
                     PImage Portrait2=loadImage("Portrait2_left.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-50,-90);
                     rposition.put(10,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Portrait2=loadImage("Portrait2_right.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(10,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==10){
                     PImage Portrait2=loadImage("Portrait2_center.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(10,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==11&&tuioObjectList[i].getScreenX(950)<=292)
               {
                     PImage Portrait3=loadImage("Portrait3_left.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-45,-100);
                     rposition.put(11,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==11&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Portrait3=loadImage("Portrait3_right.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(11,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==11){
                     PImage Portrait3=loadImage("Portrait3_center.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(11,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)<=373)
               {
                     PImage Sofa1=loadImage("Sofa1_left.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-100,-120);
                     rposition.put(12,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Sofa1=loadImage("Sofa1_right.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-70,-100);
                     rposition.put(12,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==12){
                     PImage Sofa1=loadImage("Sofa1_center.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-100,-50);
                     rposition.put(12,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==13&&tuioObjectList[i].getScreenX(950)<=310)
               {
                     PImage Sofa2=loadImage("Sofa2_left.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-50,-100);
                     rposition.put(13,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==13&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Sofa2=loadImage("Sofa2_right.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-40,-80);
                     rposition.put(13,"TRUE");
               }else  if (tuioObjectList[i].getSymbolID()==13){
                     PImage Sofa2=loadImage("Sofa2_center.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(13,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)<=318)
               {
                     PImage Sofa3=loadImage("Sofa3_left.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-70,-90);
                     rposition.put(14,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Sofa3=loadImage("Sofa3_right.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-40,-90);
                     rposition.put(14,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==14){
                     PImage Sofa3=loadImage("Sofa3_center.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(14,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)<=313)
               {
                     PImage Wardrobe1=loadImage("Wardrobe1_left.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-90,-150);
                     rposition.put(15,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Wardrobe1=loadImage("Wardrobe1_right.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-50,-140);
                     rposition.put(15,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==15){
                     PImage Wardrobe1=loadImage("Wardrobe1_center.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(15,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)<=321)
               {
                     PImage Wardrobe2=loadImage("Wardrobe2_left.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-90,-170);
                     rposition.put(16,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Wardrobe2=loadImage("Wardrobe2_right.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-40,-150);
                     rposition.put(16,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==16){
                     PImage Wardrobe2=loadImage("Wardrobe2_center.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(16,"TRUE");
               }
               
               if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)<=316)
               {
                     PImage Wardrobe3=loadImage("Wardrobe3_left.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-90,-170);
                     rposition.put(17,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Wardrobe3=loadImage("Wardrobe3_right.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-40,-170);
                     rposition.put(17,"TRUE");
               }else if (tuioObjectList[i].getSymbolID()==17){
                     PImage Wardrobe3=loadImage("Wardrobe3_center.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(17,"TRUE");
               }
               
               
             //Ceiling Condition
             if (tuioObjectList[i].getSymbolID()==0 && tuioObjectList[i].getScreenY(717)<=154 && tuioObjectList[i].getScreenX(950)<=232)
               {
                     PImage bed1=loadImage("Bed1_leftred.png");
                     symbols.put(0, bed1);
                     image((PImage)symbols.get(id),-45,-70);
                     rposition.put(0,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==0 && tuioObjectList[i].getScreenY(717)<=154 && tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage bed1=loadImage("Bed1_rightred.png");
                     symbols.put(0, bed1);
                     image((PImage)symbols.get(id),-145,-70);
                     rposition.put(0,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==0 && tuioObjectList[i].getScreenY(717)<=154){
                     PImage bed1=loadImage("Bed1_centerred.png");
                     symbols.put(0, bed1);
                     image((PImage)symbols.get(id),-45,-70);
                     rposition.put(0,"FALSE");
               }
               
             if (tuioObjectList[i].getSymbolID()==1 && tuioObjectList[i].getScreenY(717)<=154 && tuioObjectList[i].getScreenX(950)<=232)
               {
                     PImage bed2=loadImage("Bed2_leftred.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-30,-120);
                     rposition.put(1,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==1 && tuioObjectList[i].getScreenY(717)<=154 && tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage bed2=loadImage("Bed2_rightred.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-250,-100);
                     rposition.put(1,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==1 && tuioObjectList[i].getScreenY(717)<=154){
                     PImage bed2=loadImage("Bed2_centerred.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-70,-50);
                     rposition.put(1,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==2&& tuioObjectList[i].getScreenY(717)<=240&&tuioObjectList[i].getScreenX(950)<=343)
               {
                     PImage bed3=loadImage("Bed3_leftred.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(2,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==2&& tuioObjectList[i].getScreenY(717)<=240&&tuioObjectList[i].getScreenX(950)>=557)
               {
                     PImage bed3=loadImage("Bed3_rightred.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-100,-50);
                     rposition.put(2,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==2&& tuioObjectList[i].getScreenY(717)<=240){
                     PImage bed3=loadImage("Bed3_centerred.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-70,-100);
                     rposition.put(2,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==3&& tuioObjectList[i].getScreenY(717)<=209 &&tuioObjectList[i].getScreenX(950)<=312)
               {
                     PImage drawer1=loadImage("Drawer1_leftred.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(3,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==3&& tuioObjectList[i].getScreenY(717)<=209&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage drawer1=loadImage("Drawer1_rightred.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(3,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==3&& tuioObjectList[i].getScreenY(717)<=209){
                     PImage drawer1=loadImage("Drawer1_centerred.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-30,-50);
                     rposition.put(3,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==4&& tuioObjectList[i].getScreenY(717)<=206&&tuioObjectList[i].getScreenX(950)<=315)
               {
                     PImage drawer2=loadImage("Drawer2_leftred.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-100,-115);
                     rposition.put(4,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==4&& tuioObjectList[i].getScreenY(717)<=206&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage drawer2=loadImage("Drawer2_rightred.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-20,-70);
                     rposition.put(4,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==4&& tuioObjectList[i].getScreenY(717)<=206){
                     PImage drawer2=loadImage("Drawer2_centerred.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(4,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==5&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)<=315)
               {
                     PImage drawer3=loadImage("Drawer3_leftred.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(5,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==5&& tuioObjectList[i].getScreenY(717)<=154 &&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage drawer3=loadImage("Drawer3_rightred.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(5,"FALSE");
                     
               }else if (tuioObjectList[i].getSymbolID()==5&& tuioObjectList[i].getScreenY(717)<=154){
                     PImage drawer3=loadImage("Drawer3_centerred.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(5,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==6&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)<=267)
               {
                     PImage Lamp1=loadImage("Lamp1_leftred.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-35,-150);
                     rposition.put(6,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==6&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Lamp1=loadImage("Lamp1_rightred.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-55,-50);
                     rposition.put(6,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==6&& tuioObjectList[i].getScreenY(717)<=154){
                     PImage Lamp1=loadImage("Lamp1_centerred.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(8,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==7&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)<=297)
               {
                     PImage Lamp2=loadImage("Lamp2_rightred.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(7,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==7&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)>=658)
               {
                     PImage Lamp2=loadImage("Lamp2_rightred.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(7,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==7&& tuioObjectList[i].getScreenY(717)<=154){
                     PImage Lamp2=loadImage("Lamp2_centerred.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(7,"FALSE");
               }
               
               
               if (tuioObjectList[i].getSymbolID()==8&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)<=307)
               {
                     PImage Lamp3=loadImage("Lamp3_leftred.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-35,-150);
                     rposition.put(8,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==8&& tuioObjectList[i].getScreenY(717)<=154&&tuioObjectList[i].getScreenX(950)>=655)
               {
                     PImage Lamp3=loadImage("Lamp3_leftred.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-15,-150);
                     rposition.put(8,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==8&& tuioObjectList[i].getScreenY(717)<=154){
                     PImage Lamp3=loadImage("Lamp3_centerred.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(8,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==9&& tuioObjectList[i].getScreenY(717)<=224&&tuioObjectList[i].getScreenX(950)<=301)
               {
                     PImage Portrait1=loadImage("Portrait1_leftred.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-45,-80);
                     rposition.put(9,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==9&& tuioObjectList[i].getScreenY(717)<=224&&tuioObjectList[i].getScreenX(950)>=629)
               {
                     PImage Portrait1=loadImage("Portrait1_rightred.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(9,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==9&& tuioObjectList[i].getScreenY(717)<=224){
                     PImage Portrait1=loadImage("Portrait1_centerred.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(9,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==10&& tuioObjectList[i].getScreenY(717)<=229&&tuioObjectList[i].getScreenX(950)<=297)
               {
                     PImage Portrait2=loadImage("Portrait2_leftred.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-50,-90);
                     rposition.put(10,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==10&& tuioObjectList[i].getScreenY(717)<=229&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Portrait2=loadImage("Portrait2_rightred.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(10,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==10&& tuioObjectList[i].getScreenY(717)<=229){
                     PImage Portrait2=loadImage("Portrait2_centerred.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(10,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==11&& tuioObjectList[i].getScreenY(717)<=220 &&tuioObjectList[i].getScreenX(950)<=292)
               {
                     PImage Portrait3=loadImage("Portrait3_leftred.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-45,-100);
                     rposition.put(11,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==11&& tuioObjectList[i].getScreenY(717)<=220&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Portrait3=loadImage("Portrait3_rightred.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(11,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==11&& tuioObjectList[i].getScreenY(717)<=220){
                     PImage Portrait3=loadImage("Portrait3_centerred.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(11,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==12&& tuioObjectList[i].getScreenY(717)<=199&&tuioObjectList[i].getScreenX(950)<=373)
               {
                     PImage Sofa1=loadImage("Sofa1_leftred.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-100,-120);
                     rposition.put(12,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==12&& tuioObjectList[i].getScreenY(717)<=199&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Sofa1=loadImage("Sofa1_rightred.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-70,-100);
                     rposition.put(12,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==12&& tuioObjectList[i].getScreenY(717)<=199){
                     PImage Sofa1=loadImage("Sofa1_centerred.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-100,-50);
                     rposition.put(12,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==13 && tuioObjectList[i].getScreenY(717)<=202&&tuioObjectList[i].getScreenX(950)<=310)
               {
                     PImage Sofa2=loadImage("Sofa2_leftred.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-50,-100);
                     rposition.put(13,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==13 && tuioObjectList[i].getScreenY(717)<=206&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Sofa2=loadImage("Sofa2_rightred.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-40,-80);
                     rposition.put(13,"FALSE");
               }else  if (tuioObjectList[i].getSymbolID()==13&& tuioObjectList[i].getScreenY(717)<=206){
                     PImage Sofa2=loadImage("Sofa2_centerred.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(13,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==14&& tuioObjectList[i].getScreenY(717)<=206&&tuioObjectList[i].getScreenX(950)<=318)
               {
                     PImage Sofa3=loadImage("Sofa3_leftred.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-70,-90);
                     rposition.put(14,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==14&& tuioObjectList[i].getScreenY(717)<=206&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Sofa3=loadImage("Sofa3_rightred.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-40,-90);
                     rposition.put(14,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==14&& tuioObjectList[i].getScreenY(717)<=206){
                     PImage Sofa3=loadImage("Sofa3_centerred.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(14,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==15&& tuioObjectList[i].getScreenY(717)<=181&&tuioObjectList[i].getScreenX(950)<=313)
               {
                     PImage Wardrobe1=loadImage("Wardrobe1_leftred.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-90,-150);
                     rposition.put(15,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==15&& tuioObjectList[i].getScreenY(717)<=181&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Wardrobe1=loadImage("Wardrobe1_rightred.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-50,-140);
                     rposition.put(15,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==15&& tuioObjectList[i].getScreenY(717)<=181){
                     PImage Wardrobe1=loadImage("Wardrobe1_centerred.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(15,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==16&& tuioObjectList[i].getScreenY(717)<=181&&tuioObjectList[i].getScreenX(950)<=321)
               {
                     PImage Wardrobe2=loadImage("Wardrobe2_leftred.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-90,-170);
                     rposition.put(16,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==16&& tuioObjectList[i].getScreenY(717)<=181&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Wardrobe2=loadImage("Wardrobe2_rightred.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-40,-150);
                     rposition.put(16,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==16&& tuioObjectList[i].getScreenY(717)<=181){
                     PImage Wardrobe2=loadImage("Wardrobe2_centerred.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(16,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==17&& tuioObjectList[i].getScreenY(717)<=181&&tuioObjectList[i].getScreenX(950)<=316)
               {
                     PImage Wardrobe3=loadImage("Wardrobe3_leftred.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-90,-170);
                     rposition.put(17,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==17&& tuioObjectList[i].getScreenY(717)<=181&&tuioObjectList[i].getScreenX(950)>=610)
               {
                     PImage Wardrobe3=loadImage("Wardrobe3_rightred.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-40,-170);
                     rposition.put(17,"FALSE");
               }else if (tuioObjectList[i].getSymbolID()==17&& tuioObjectList[i].getScreenY(717)<=181){
                     PImage Wardrobe3=loadImage("Wardrobe3_centerred.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(17,"FALSE");
               }
            //Door Standards 
             if (opt==0){
               
               if (tuioObjectList[i].getSymbolID()==0 && tuioObjectList[i].getScreenX(950)>=723)
               {
                     PImage bed1=loadImage("Bed1_rightred.png");
                     symbols.put(0, bed1);
                     image((PImage)symbols.get(id),-145,-70);
                     rposition.put(0,"FALSE");
               }
               
             if (tuioObjectList[i].getSymbolID()==1 && tuioObjectList[i].getScreenX(950)>=787)
               {
                     PImage bed2=loadImage("Bed2_rightred.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-250,-100);
                     rposition.put(1,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)>=778)
               {
                     PImage bed3=loadImage("Bed3_rightred.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-100,-50);
                     rposition.put(2,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==3 &&tuioObjectList[i].getScreenX(950)>=796)
               {
                     PImage drawer1=loadImage("Drawer1_rightred.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(3,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)>=761)
               {
                     PImage drawer2=loadImage("Drawer2_rightred.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-20,-70);
                     rposition.put(4,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)>=794)
               {
                     PImage drawer3=loadImage("Drawer3_rightred.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(5,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)>=756)
               {
                     PImage Lamp1=loadImage("Lamp1_rightred.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-55,-50);
                     rposition.put(6,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)>=788)
               {
                     PImage Lamp2=loadImage("Lamp2_rightred.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(7,"FALSE");
               }
               
               
               if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)>=793)
               {
                     PImage Lamp3=loadImage("Lamp3_leftred.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-15,-150);
                     rposition.put(8,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)>=772)
               {
                     PImage Portrait1=loadImage("Portrait1_rightred.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(9,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)>=772)
               {
                     PImage Portrait2=loadImage("Portrait2_rightred.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(10,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==11 &&tuioObjectList[i].getScreenX(950)>=772)
               {
                     PImage Portrait3=loadImage("Portrait3_rightred.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(11,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)>=757)
               {
                     PImage Sofa1=loadImage("Sofa1_rightred.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-70,-100);
                     rposition.put(12,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==13&&tuioObjectList[i].getScreenX(950)>=757)
               {
                     PImage Sofa2=loadImage("Sofa2_rightred.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-40,-80);
                     rposition.put(13,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)>=757)
               {
                     PImage Sofa3=loadImage("Sofa3_rightred.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-40,-90);
                     rposition.put(14,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)>=729)
               {
                     PImage Wardrobe1=loadImage("Wardrobe1_rightred.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-50,-140);
                     rposition.put(15,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)>=729)
               {
                     PImage Wardrobe2=loadImage("Wardrobe2_rightred.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-40,-150);
                     rposition.put(16,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)>=729)
               {
                     PImage Wardrobe3=loadImage("Wardrobe3_rightred.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-40,-170);
                     rposition.put(17,"FALSE");
               }
             
             }
              else if (opt==1){
               
               if (tuioObjectList[i].getSymbolID()==0 && tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage bed1=loadImage("Bed1_leftred.png");
                     symbols.put(0, bed1);
                     image((PImage)symbols.get(id),-45,-70);
                     rposition.put(0,"FALSE");
               }
               
             if (tuioObjectList[i].getSymbolID()==1 && tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage bed2=loadImage("Bed2_leftred.png");
                     symbols.put(1, bed2);
                     image((PImage)symbols.get(id),-30,-120);
                     rposition.put(1,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage bed3=loadImage("Bed3_leftred.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(2,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==3 &&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage drawer1=loadImage("Drawer1_leftred.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-50,-70);
                     rposition.put(3,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)<=191)
               {
                     PImage drawer2=loadImage("Drawer2_leftred.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-100,-115);
                     rposition.put(4,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)<=135)
               {
                     PImage drawer3=loadImage("Drawer3_leftred.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(5,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)<=122)
               {
                     PImage Lamp1=loadImage("Lamp1_leftred.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-35,-150);
                     rposition.put(6,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage Lamp2=loadImage("Lamp2_rightred.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-100);
                     rposition.put(7,"FALSE");
               }
               
               
               if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage Lamp3=loadImage("Lamp3_leftred.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-35,-150);
                     rposition.put(8,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage Portrait1=loadImage("Portrait1_leftred.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-45,-80);
                     rposition.put(9,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage Portrait2=loadImage("Portrait2_leftred.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-50,-90);
                     rposition.put(10,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==11 &&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage Portrait3=loadImage("Portrait3_leftred.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-45,-100);
                     rposition.put(11,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)<=203)
               {
                     PImage Sofa1=loadImage("Sofa1_leftred.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-100,-120);
                     rposition.put(12,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==13&&tuioObjectList[i].getScreenX(950)<=148)
               {
                     PImage Sofa2=loadImage("Sofa2_leftred.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-50,-100);
                     rposition.put(13,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)<=166)
               {
                     PImage Sofa3=loadImage("Sofa3_leftred.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-70,-90);
                     rposition.put(14,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)<=180)
               {
                     PImage Wardrobe1=loadImage("Wardrobe1_leftred.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-90,-150);
                     rposition.put(15,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)<=181)
               {
                     PImage Wardrobe2=loadImage("Wardrobe2_leftred.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-90,-170);
                     rposition.put(16,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)<=183)
               {
                     PImage Wardrobe3=loadImage("Wardrobe3_leftred.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-90,-170);
                     rposition.put(17,"FALSE");
               }
              }
             else  if (opt==2){
               if (tuioObjectList[i].getSymbolID()==0&&327<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=404
                     && 161<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=474)
               {
                     PImage bed1=loadImage("Bed1_centerred.png");
                     symbols.put(0, bed1);
                     image((PImage)symbols.get(id),-45,-70);
                     rposition.put(0,"FALSE");
               }
               if (tuioObjectList[i].getSymbolID()==1&&353<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=404
                     && 161<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=474)
               {
                     PImage bed2=loadImage("Bed2_centerred.png");
                     symbols.put(1, bed2);
                      image((PImage)symbols.get(id),-70,-50);
                      rposition.put(1,"FALSE");
               }
               if (tuioObjectList[i].getSymbolID()==2&&345<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=432
                     && 161<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=515)
               {
                     PImage bed3=loadImage("Bed3_centerred.png");
                     symbols.put(2, bed3);
                     image((PImage)symbols.get(id),-70,-100);
                     rposition.put(2,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==3&&313<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=386
                     &&tuioObjectList[i].getScreenY(717)<=457){
                     PImage drawer1=loadImage("Drawer1_centerred.png");
                     symbols.put(3, drawer1);
                     image((PImage)symbols.get(id),-30,-50);
                     rposition.put(3,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==4&&313<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=386
                     &&tuioObjectList[i].getScreenY(717)<=457){
                     PImage drawer2=loadImage("Drawer2_centerred.png");
                     symbols.put(4, drawer2);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(4,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==5&&313<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=386
                     &&tuioObjectList[i].getScreenY(717)<=457){
                     PImage drawer3=loadImage("Drawer3_centerred.png");
                     symbols.put(5, drawer3);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(5,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==6&&275<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=395
                     && 161<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=450){
                     PImage Lamp1=loadImage("Lamp1_centerred.png");
                     symbols.put(6, Lamp1);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(6,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==7&&322<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=389
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Lamp2=loadImage("Lamp2_centerred.png");
                     symbols.put(7, Lamp2);
                     image((PImage)symbols.get(id),-35,-50);
                     rposition.put(7,"FALSE");
               }
               
               
                if (tuioObjectList[i].getSymbolID()==8&&310<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=374
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Lamp3=loadImage("Lamp3_centerred.png");
                     symbols.put(8, Lamp3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(8,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==9&&309<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=370
                     ){
                     PImage Portrait1=loadImage("Portrait1_centerred.png");
                     symbols.put(9, Portrait1);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(9,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==10&&310<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=322
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Portrait2=loadImage("Portrait2_centerred.png");
                     symbols.put(10, Portrait2);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(10,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==11&&310<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=370
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Portrait3=loadImage("Portrait3_centerred.png");
                     symbols.put(11, Portrait3);
                     image((PImage)symbols.get(id),-15,-70);
                     rposition.put(11,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==12&&392<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=457
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Sofa1=loadImage("Sofa1_centerred.png");
                     symbols.put(12, Sofa1);
                     image((PImage)symbols.get(id),-100,-50);
                     rposition.put(12,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==13&&333<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=395
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Sofa2=loadImage("Sofa2_centerred.png");
                     symbols.put(13, Sofa2);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(13,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==14&&333<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=398
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Sofa3=loadImage("Sofa3_centerred.png");
                     symbols.put(14, Sofa3);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(14,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==15&&337<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=398
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Wardrobe1=loadImage("Wardrobe1_centerred.png");
                     symbols.put(15, Wardrobe1);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(15,"FALSE");
               }
               
               if (tuioObjectList[i].getSymbolID()==16&&334<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=398
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Wardrobe2=loadImage("Wardrobe2_centerred.png");
                     symbols.put(16, Wardrobe2);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(16,"FALSE");
               }
               
                if (tuioObjectList[i].getSymbolID()==17&&333<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=399
                     && tuioObjectList[i].getScreenY(717)<=453){
                     PImage Wardrobe3=loadImage("Wardrobe3_centerred.png");
                     symbols.put(17, Wardrobe3);
                     image((PImage)symbols.get(id),-40,-70);
                     rposition.put(17,"FALSE");
               }
                               
                } 
                          //Validation
                  int sec= times.timer();
                  if(tuioObjectList[i].getSymbolID()==0){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(0)||"TRUE"==correct.get(0)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-45;
                            //y =tuioObjectList[i].getScreenY(717)-70;
                                    if (tuioObjectList[i].getSymbolID()==0&&tuioObjectList[i].getScreenX(950)<=324)
                                           {
                                                x0l=(tuioObjectList[i].getScreenX(950)-45);
                                                y0l=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(0,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==0&&tuioObjectList[i].getScreenX(950)>=551)
                                           {
                                                x0r=(tuioObjectList[i].getScreenX(950)-145);
                                                y0r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(0,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==0){
                                                x0=(tuioObjectList[i].getScreenX(950)-45);
                                                y0=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(0,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(0)){
                                        if (tuioObjectList[i].getSymbolID()==0&&tuioObjectList[i].getScreenX(950)<=324)
                                       {
                                       
                                               PImage bed1=loadImage("Bed1_left.png");
                                               symbols.put(0, bed1);
                                               copy(bed1,0,0, 261, 111, x0l, y0l, 261, 111);  
                                        }else if (tuioObjectList[i].getSymbolID()==0&&tuioObjectList[i].getScreenX(950)>=551)
                                       {
                                       
                                               PImage bed1=loadImage("Bed1_right.png");
                                               symbols.put(0, bed1);
                                               copy(bed1,0,0, 26, 111, x0r, y0r, 261, 111);
                                       }else if(tuioObjectList[i].getSymbolID()==0){
                                              //else{      //image(bed1,429,372,160,104);
                                               PImage bed1=loadImage("Bed1_center.png");
                                               symbols.put(0, bed1);
                                               copy(bed1,0,0, 160, 104, x0, y0, 160, 104);}
                                       }
                           }
             }
             

            
            
             if(tuioObjectList[i].getSymbolID()==1){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(1)||"TRUE"==correct.get(1)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-45;
                            //y =tuioObjectList[i].getScreenY(717)-70;
                                    if (tuioObjectList[i].getSymbolID()==1&&tuioObjectList[i].getScreenX(950)<=324)
                                           {
                                                x1l=(tuioObjectList[i].getScreenX(950)-30);
                                                y1l=tuioObjectList[i].getScreenY(717)-120;
                                                correct.put(1,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==1&&tuioObjectList[i].getScreenX(950)>=551)
                                           {
                                                x1r=(tuioObjectList[i].getScreenX(950)-250);
                                                y1r=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(1,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==1){
                                                x1=(tuioObjectList[i].getScreenX(950)-70);
                                                y1=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(1,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(1)){
                                        if (tuioObjectList[i].getSymbolID()==1&&tuioObjectList[i].getScreenX(950)<=324)
                                       {
                                       
                                               PImage bed1=loadImage("Bed2_left.png");
                                               symbols.put(1, bed1);
                                               copy(bed1,0,0, 311, 188, x1l, y1l, 311, 188);  
                                        }else if (tuioObjectList[i].getSymbolID()==1&&tuioObjectList[i].getScreenX(950)>=551)
                                       {
                                       
                                               PImage bed1=loadImage("Bed2_right.png");
                                               symbols.put(1, bed1);
                                               copy(bed1,0,0, 311, 188, x1r, y1r, 311, 188);
                                       }else if(tuioObjectList[i].getSymbolID()==1){
                                              //else{      //image(bed1,429,372,160,104);
                                               PImage bed1=loadImage("Bed2_center.png");
                                               symbols.put(1, bed1);
                                               copy(bed1,0,0, 167, 118, x1, y1, 167, 118);
                                             }
                                       }
                           }
             }
           
           
           
           if(tuioObjectList[i].getSymbolID()==2){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(2)||"TRUE"==correct.get(2)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-45;
                            //y =tuioObjectList[i].getScreenY(727)-70;
                                    if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)<=324)
                                           {
                                                x2l=(tuioObjectList[i].getScreenX(950)-50);
                                                y2l=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(2,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)>=552)
                                           {
                                                x2r=(tuioObjectList[i].getScreenX(950)-100);
                                                y2r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(2,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==2){
                                                x2=(tuioObjectList[i].getScreenX(950)-70);
                                                y2=tuioObjectList[i].getScreenY(717)-100;
//                                              clipped.play();
                                                correct.put(2,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(2)){
                                        if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)<=324)
                                       {
                                       
                                               PImage bed2=loadImage("Bed3_left.png");
                                               symbols.put(2, bed2);
                                               copy(bed2,0,0, 158, 69, x2l, y2l, 158, 69);  
                                        }else if (tuioObjectList[i].getSymbolID()==2&&tuioObjectList[i].getScreenX(950)>=552)
                                       {
                                       
                                               PImage bed2=loadImage("Bed3_right.png");
                                               symbols.put(2, bed2);
                                               copy(bed2,0,0, 158, 69, x2r, y2r, 158, 69);
                                       }else if(tuioObjectList[i].getSymbolID()==2){
                                              //else{      //image(bed2,429,372,260,204);
                                               PImage bed2=loadImage("Bed3_center.png");
                                               symbols.put(2, bed2);
                                               copy(bed2,0,0, 184, 115, x2, y2, 184, 115);
                                             }
                                       }
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==3){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(3)||"TRUE"==correct.get(3)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-45;
                            //y =tuioObjectList[i].getScreenY(737)-70;
                                    if (tuioObjectList[i].getSymbolID()==3&&tuioObjectList[i].getScreenX(950)<=334)
                                           {
                                                x3l=(tuioObjectList[i].getScreenX(950)-50);
                                                y3l=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(3,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==3&&tuioObjectList[i].getScreenX(950)>=553)
                                           {
                                                x3r=(tuioObjectList[i].getScreenX(950)-50);
                                                y3r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(3,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==3){
                                                x3=(tuioObjectList[i].getScreenX(950)-30);
                                                y3=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(3,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(3)){
                                        if (tuioObjectList[i].getSymbolID()==3&&tuioObjectList[i].getScreenX(950)<=334)
                                       {
                                       
                                               PImage bed3=loadImage("Drawer1_left.png");
                                               symbols.put(3, bed3);
                                               copy(bed3,0,0, 95, 174, x3l, y3l, 95, 174);  
                                        }else if (tuioObjectList[i].getSymbolID()==3&&tuioObjectList[i].getScreenX(950)>=553)
                                       {
                                       
                                               PImage bed3=loadImage("Drawer1_right.png");
                                               symbols.put(3, bed3);
                                               copy(bed3,0,0, 95, 174, x3r, y3r, 95, 174);
                                       }else if(tuioObjectList[i].getSymbolID()==3){
                                              //else{      //image(bed3,439,373,360,304);
                                               PImage bed3=loadImage("Drawer1_center.png");
                                               symbols.put(3, bed3);
                                               copy(bed3,0,0, 85, 55, x3, y3, 85, 55);
                                             }
                                       }
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==4){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(4)||"TRUE"==correct.get(4)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-45;
                            //y =tuioObjectList[i].getScreenY(747)-70;
                                    if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)<=315)
                                           {
                                                x4l=(tuioObjectList[i].getScreenX(950)-100);
                                                y4l=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(4,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x4r=(tuioObjectList[i].getScreenX(950)-20);
                                                y4r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(4,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==4){
                                                x4=(tuioObjectList[i].getScreenX(950)-35);
                                                y4=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(4,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(4)){
                                        if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)<=315)
                                       {
                                       
                                               PImage bed4=loadImage("Drawer2_left.png");
                                               symbols.put(4, bed4);
                                               copy(bed4,0,0, 134, 208, x4l, y4l, 134, 208);  
                                        }else if (tuioObjectList[i].getSymbolID()==4&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed4=loadImage("Drawer2_right.png");
                                               symbols.put(4, bed4);
                                               copy(bed4,0,0, 134, 208, x4r, y4r, 134, 208);
                                       }else if(tuioObjectList[i].getSymbolID()==4){
                                              //else{      //image(bed4,449,474,460,404);
                                               PImage bed4=loadImage("Drawer2_center.png");
                                               symbols.put(4, bed4);
                                               copy(bed4,0,0, 96,58, x4, y4, 96,58);
                                             }
                                       }
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==5){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(5)||"TRUE"==correct.get(5)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-55;
                            //y =tuioObjectList[i].getScreenY(757)-70;
                                    if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)<=315)
                                           {
                                                x5l=(tuioObjectList[i].getScreenX(950)-35);
                                                y5l=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(5,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x5r=(tuioObjectList[i].getScreenX(950)-35);
                                                y5r=tuioObjectList[i].getScreenY(717)-50;
                                                correct.put(5,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==5){
                                                x5=(tuioObjectList[i].getScreenX(950)-35);
                                                y5=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(5,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(5)){
                                        if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)<=315)
                                       {
                                       
                                               PImage bed5=loadImage("Drawer3_left.png");
                                               symbols.put(5, bed5);
                                               copy(bed5,0,0, 50,156, x5l, y5l, 50,156);  
                                        }else if (tuioObjectList[i].getSymbolID()==5&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed5=loadImage("Drawer3_right.png");
                                               symbols.put(5, bed5);
                                               copy(bed5,0,0, 50,156, x5r, y5r, 50,156);
                                       }else if(tuioObjectList[i].getSymbolID()==5){
                                              //else{      //image(bed5,559,575,560,505);
                                               PImage bed5=loadImage("Drawer3_center.png");
                                               symbols.put(5, bed5);
                                               copy(bed5,0,0, 83, 64, x5, y5, 83, 64);
                                             }
                                       } 
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==6){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(6)||"TRUE"==correct.get(6)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(960)-66;
                            //y =tuioObjectList[i].getScreenY(767)-70;
                                    if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)<=267)
                                           {
                                                x6l=(tuioObjectList[i].getScreenX(960)-35);
                                                y6l=tuioObjectList[i].getScreenY(717)-150;
                                                correct.put(6,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x6r=(tuioObjectList[i].getScreenX(960)-55);
                                                y6r=tuioObjectList[i].getScreenY(717)-50;
                                                correct.put(6,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==6){
                                                x6=(tuioObjectList[i].getScreenX(960)-35);
                                                y6=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(6,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(6)){
                                        if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)<=267)
                                       {
                                       
                                               PImage bed6=loadImage("Lamp1_left.png");
                                               symbols.put(6, bed6);
                                               copy(bed6,0,0, 141,331, x6l, y6l, 141,331);  
                                        }else if (tuioObjectList[i].getSymbolID()==6&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed6=loadImage("Lamp1_right.png");
                                               symbols.put(6, bed6);
                                               copy(bed6,0,0, 141,331, x6r, y6r, 141,331);
                                       }else if(tuioObjectList[i].getSymbolID()==6){
                                              //else{      //image(bed6,669,676,660,606);
                                               PImage bed6=loadImage("Lamp1_center.png");
                                               symbols.put(6, bed6);
                                               copy(bed6,0,0, 73, 144, x6, y6, 73, 144);
                                             }
                                       } 
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==7){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(7)||"TRUE"==correct.get(7)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(970)-77;
                            //y =tuioObjectList[i].getScreenY(777)-70;
                                    if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)<=287)
                                           {
                                                x7l=(tuioObjectList[i].getScreenX(950)-35);
                                                y7l=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(7,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)>=658)
                                           {
                                                x7r=(tuioObjectList[i].getScreenX(950)-35);
                                                y7r=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(7,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==7){
                                                x7=(tuioObjectList[i].getScreenX(950)-35);
                                                y7=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(7,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(7)){
                                        if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)<=287)
                                       {
                                       
                                               PImage bed7=loadImage("Lamp2_right.png");
                                               symbols.put(7, bed7);
                                               copy(bed7,0,0, 90,254, x7l, y7l, 90,254);  
                                        }else if (tuioObjectList[i].getSymbolID()==7&&tuioObjectList[i].getScreenX(950)>=658)
                                       {
                                       
                                               PImage bed7=loadImage("Lamp2_right.png");
                                               symbols.put(7, bed7);
                                               copy(bed7,0,0, 90,254, x7r, y7r, 90,254);
                                       }else if(tuioObjectList[i].getSymbolID()==7){
                                              //else{      //image(bed7,779,777,770,707);
                                               PImage bed7=loadImage("Lamp2_center.png");
                                               symbols.put(7, bed7);
                                               copy(bed7,0,0, 43,120, x7, y7, 43,120);
                                             }
                                       } 
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==8){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(8)||"TRUE"==correct.get(8)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(980)-88;
                            //y =tuioObjectList[i].getScreenY(888)-80;
                                    if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)<=307)
                                           {
                                                x8l=(tuioObjectList[i].getScreenX(950)-35);
                                                y8l=tuioObjectList[i].getScreenY(717)-150;
                                                correct.put(8,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)>=655)
                                           {
                                                x8r=(tuioObjectList[i].getScreenX(950)-15);
                                                y8r=tuioObjectList[i].getScreenY(717)-150;
                                                correct.put(8,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==8){
                                                x8=(tuioObjectList[i].getScreenX(950)-15);
                                                y8=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(8,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(8)){
                                        if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)<=307)
                                       {
                                       
                                               PImage bed8=loadImage("Lamp3_left.png");
                                               symbols.put(8, bed8);
                                               copy(bed8,0,0, 57,272, x8l, y8l, 57,272);  
                                        }else if (tuioObjectList[i].getSymbolID()==8&&tuioObjectList[i].getScreenX(950)>=655)
                                       {
                                       
                                               PImage bed8=loadImage("Lamp3_left.png");
                                               symbols.put(8, bed8);
                                               copy(bed8,0,0, 57,272, x8r, y8r, 57,272);
                                       }else if(tuioObjectList[i].getSymbolID()==8){
                                              //else{      //image(bed8,889,888,880,808);
                                               PImage bed8=loadImage("Lamp3_center.png");
                                               symbols.put(8, bed8);
                                               copy(bed8,0,0, 29, 136, x8, y8, 29, 136);
                                             }
                                       } 
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==9){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(9)||"TRUE"==correct.get(9)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-99;
                            //y =tuioObjectList[i].getScreenY(999)-90;
                                    if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)<=319)
                                           {
                                                x9l=(tuioObjectList[i].getScreenX(950)-45);
                                                y9l=tuioObjectList[i].getScreenY(717)-80;
                                                correct.put(9,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)>=910)
                                           {
                                                x9r=(tuioObjectList[i].getScreenX(950)-15);
                                                y9r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(9,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==9){
                                                x9=(tuioObjectList[i].getScreenX(950)-15);
                                                y9=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(9,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(9)){
                                        if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)<=319)
                                       {
                                       
                                               PImage bed9=loadImage("Portrait1_left.png");
                                               symbols.put(9, bed9);
                                               copy(bed9,0,0, 86,98, x9l, y9l, 86,98);  
                                        }else if (tuioObjectList[i].getSymbolID()==9&&tuioObjectList[i].getScreenX(950)>=910)
                                       {
                                       
                                               PImage bed9=loadImage("Portrait1_right.png");
                                               symbols.put(9, bed9);
                                               copy(bed9,0,0, 67,101, x9r, y9r, 67,101);
                                       }else if(tuioObjectList[i].getSymbolID()==9){
                                              //else{      //image(bed9,999,999,950,909);
                                               PImage bed9=loadImage("Portrait1_center.png");
                                               symbols.put(9, bed9);
                                               copy(bed9,0,0, 45, 53, x9, y9, 45, 53);
                                             }
                                       } 
                           }
             }
             
             if(tuioObjectList[i].getSymbolID()==10){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(10)||"TRUE"==correct.get(10)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1010;
                            //y =tuioObjectList[i].getScreenY(717)-100;
                                    if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)<=197)
                                           {
                                                x10l=(tuioObjectList[i].getScreenX(950)-50);
                                                y10l=tuioObjectList[i].getScreenY(717)-90;
                                                correct.put(10,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x10r=(tuioObjectList[i].getScreenX(950)-15);
                                                y10r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(10,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==10){
                                                x10=(tuioObjectList[i].getScreenX(950)-15);
                                                y10=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(10,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(10)){
                                        if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)<=197)
                                       {
                                       
                                               PImage bed10=loadImage("Portrait2_left.png");
                                               symbols.put(10, bed10);
                                               copy(bed10,0,0, 54,62, x10l, y10l, 54,62);  
                                        }else if (tuioObjectList[i].getSymbolID()==10&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed10=loadImage("Portrait2_right.png");
                                               symbols.put(10, bed10);
                                               copy(bed10,0,0, 107,110, x10r, y10r, 107,110);
                                       }else if(tuioObjectList[i].getSymbolID()==10){
                                              //else{      //image(bed10,717,717,950,10010);
                                               PImage bed10=loadImage("Portrait2_center.png");
                                               symbols.put(10, bed10);
                                               copy(bed10,0,0, 59, 49, x10, y10, 59, 49);
                                             }
                                       } 
                           }
             }
                          if(tuioObjectList[i].getSymbolID()==11){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(11)||"TRUE"==correct.get(11)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1111;
                            //y =tuioObjectList[i].getScreenY(717)-110;
                                    if (tuioObjectList[i].getSymbolID()==11&&tuioObjectList[i].getScreenX(950)<=197)
                                           {
                                                x11l=(tuioObjectList[i].getScreenX(950)-50);
                                                y11l=tuioObjectList[i].getScreenY(717)-90;
                                                correct.put(11,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==11&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x11r=(tuioObjectList[i].getScreenX(950)-15);
                                                y11r=tuioObjectList[i].getScreenY(717)-70;
                                                correct.put(11,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==11){
                                                x11=(tuioObjectList[i].getScreenX(950)-15);
                                                y11=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(11,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(11)){
                                        if (tuioObjectList[i].getSymbolID()==11&&tuioObjectList[i].getScreenX(950)<=197)
                                       {
                                       
                                               PImage bed11=loadImage("Portrait3_left.png");
                                               symbols.put(11, bed11);
                                               copy(bed11,0,0, 77,102, x11l, y11l, 77,102);  
                                        }else if (tuioObjectList[i].getSymbolID()==11&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed11=loadImage("Portrait3_right.png");
                                               symbols.put(11, bed11);
                                               copy(bed11,0,0, 77,102, x11r, y11r, 77,102);
                                       }else if(tuioObjectList[i].getSymbolID()==11){
                                              //else{      //image(bed11,717,717,950,11011);
                                               PImage bed11=loadImage("Portrait3_center.png");
                                               symbols.put(11, bed11);
                                               copy(bed11,0,0, 77, 54, x11, y11, 77, 54);
                                             }
                                       } 
                           }
             }
             
                   if(tuioObjectList[i].getSymbolID()==12){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(12)||"TRUE"==correct.get(12)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1212;
                            //y =tuioObjectList[i].getScreenY(717)-120;
                                    if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)<=373)
                                           {
                                                x12l=(tuioObjectList[i].getScreenX(950)-100);
                                                y12l=tuioObjectList[i].getScreenY(717)-120;
                                                correct.put(12,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x12r=(tuioObjectList[i].getScreenX(950)-70);
                                                y12r=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(12,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==12){
                                                x12=(tuioObjectList[i].getScreenX(950)-100);
                                                y12=tuioObjectList[i].getScreenY(717)-50;
//                                              clipped.play();
                                                correct.put(12,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(12)){
                                        if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)<=373)
                                       {
                                       
                                               PImage bed12=loadImage("Sofa1_left.png");
                                               symbols.put(12, bed12);
                                               copy(bed12,0,0, 153,214, x12l, y12l, 153,214);  
                                        }else if (tuioObjectList[i].getSymbolID()==12&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed12=loadImage("Sofa1_right.png");
                                               symbols.put(12, bed12);
                                               copy(bed12,0,0, 153,214, x12r, y12r, 153,214);
                                       }else if(tuioObjectList[i].getSymbolID()==12){
                                              //else{      //image(bed12,717,717,950,12012);
                                               PImage bed12=loadImage("Sofa1_center.png");
                                               symbols.put(12, bed12);
                                               copy(bed12,0,0, 184, 84, x12, y12, 184, 84);
                                             }
                                       } 
                           }
             }
             
              if(tuioObjectList[i].getSymbolID()==13){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(13)||"TRUE"==correct.get(13)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1313;
                            //y =tuioObjectList[i].getScreenY(717)-130;
                                    if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)<=310)
                                           {
                                                x14l=(tuioObjectList[i].getScreenX(950)-50);
                                                y14l=tuioObjectList[i].getScreenY(717)-100;
                                                correct.put(14,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x14r=(tuioObjectList[i].getScreenX(950)-40);
                                                y14r=tuioObjectList[i].getScreenY(717)-80;
                                                correct.put(14,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==14){
                                                x14=(tuioObjectList[i].getScreenX(950)-40);
                                                y14=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(14,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(13)){
                                        if (tuioObjectList[i].getSymbolID()==13&&tuioObjectList[i].getScreenX(950)<=310)
                                       {
                                       
                                               PImage bed13=loadImage("Sofa2_left.png");
                                               symbols.put(13, bed13);
                                               copy(bed13,0,0, 128,134, x13l, y13l, 128,134);  
                                        }else if (tuioObjectList[i].getSymbolID()==13&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed13=loadImage("Sofa2_right.png");
                                               symbols.put(13, bed13);
                                               copy(bed13,0,0, 128,134, x13r, y13r, 128,134);
                                       }else if(tuioObjectList[i].getSymbolID()==13){
                                              //else{      //image(bed13,717,717,950,13013);
                                               PImage bed13=loadImage("Sofa2_center.png");
                                               symbols.put(13, bed13);
                                               copy(bed13,0,0, 94, 81, x13, y13, 94, 81);
                                             }
                                       } 
                           }
             }
           if(tuioObjectList[i].getSymbolID()==14){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(14)||"TRUE"==correct.get(14)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1414;
                            //y =tuioObjectList[i].getScreenY(717)-140;
                                    if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)<=318)
                                           {
                                                x14l=(tuioObjectList[i].getScreenX(950)-70);
                                                y14l=tuioObjectList[i].getScreenY(717)-90;
                                                correct.put(14,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x14r=(tuioObjectList[i].getScreenX(950)-40);
                                                y14r=tuioObjectList[i].getScreenY(717)-90;
                                                correct.put(14,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==14){
                                                x14=(tuioObjectList[i].getScreenX(950)-40);
                                                y14=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(14,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(14)){
                                        if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)<=318)
                                       {
                                       
                                               PImage bed14=loadImage("Sofa3_left.png");
                                               symbols.put(14, bed14);
                                               copy(bed14,0,0, 128,172, x14l, y14l, 128,172);  
                                        }else if (tuioObjectList[i].getSymbolID()==14&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed14=loadImage("Sofa3_right.png");
                                               symbols.put(14, bed14);
                                               copy(bed14,0,0, 128,172, x14r, y14r, 128,172);
                                       }else if(tuioObjectList[i].getSymbolID()==14){
                                              //else{      //image(bed14,717,717,950,14014);
                                               PImage bed14=loadImage("Sofa3_center.png");
                                               symbols.put(14, bed14);
                                               copy(bed14,0,0, 96, 90, x14, y14, 96, 90);
                                             }
                                       } 
                           }
             }
               if(tuioObjectList[i].getSymbolID()==15){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(15)||"TRUE"==correct.get(15)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1515;
                            //y =tuioObjectList[i].getScreenY(717)-150;
                                    if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)<=313)
                                           {
                                                x15l=(tuioObjectList[i].getScreenX(950)-90);
                                                y15l=tuioObjectList[i].getScreenY(717)-150;
                                                correct.put(15,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x15r=(tuioObjectList[i].getScreenX(950)-50);
                                                y15r=tuioObjectList[i].getScreenY(717)-140;
                                                correct.put(15,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==15){
                                                x15=(tuioObjectList[i].getScreenX(950)-40);
                                                y15=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(15,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(15)){
                                        if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)<=313)
                                       {
                                       
                                               PImage bed15=loadImage("Wardrobe1_left.png");
                                               symbols.put(15, bed15);
                                               copy(bed15,0,0, 131,354, x15l, y15l, 131,354);  
                                        }else if (tuioObjectList[i].getSymbolID()==15&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed15=loadImage("Wardrobe1_right.png");
                                               symbols.put(15, bed15);
                                               copy(bed15,0,0, 131,354, x15r, y15r, 131,354);
                                       }else if(tuioObjectList[i].getSymbolID()==15){
                                              //else{      //image(bed15,717,717,950,15015);
                                               PImage bed15=loadImage("Wardrobe1_center.png");
                                               symbols.put(15, bed15);
                                               copy(bed15,0,0, 109, 164, x15, y15, 109, 164);
                                             }
                                       } 
                           }
             }  
             if(tuioObjectList[i].getSymbolID()==16){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(16)||"TRUE"==correct.get(16)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1616;
                            //y =tuioObjectList[i].getScreenY(717)-160;
                                    if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)<=321)
                                           {
                                                x16l=(tuioObjectList[i].getScreenX(950)-90);
                                                y16l=tuioObjectList[i].getScreenY(717)-170;
                                                correct.put(16,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x16r=(tuioObjectList[i].getScreenX(950)-40);
                                                y16r=tuioObjectList[i].getScreenY(717)-150;
                                                correct.put(16,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==16){
                                                x16=(tuioObjectList[i].getScreenX(950)-40);
                                                y16=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(16,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(16)){
                                        if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)<=321)
                                       {
                                       
                                               PImage bed16=loadImage("Wardrobe2_left.png");
                                               symbols.put(16, bed16);
                                               copy(bed16,0,0, 124,378, x16l, y16l, 124,378);  
                                        }else if (tuioObjectList[i].getSymbolID()==16&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed16=loadImage("Wardrobe2_right.png");
                                               symbols.put(16, bed16);
                                               copy(bed16,0,0, 124,378, x16r, y16r, 124,378);
                                       }else if(tuioObjectList[i].getSymbolID()==16){
                                              //else{      //image(bed16,717,717,950,16016);
                                               PImage bed16=loadImage("Wardrobe2_center.png");
                                               symbols.put(16, bed16);
                                               copy(bed16,0,0, 98, 187, x16, y16, 98, 187);
                                             }
                                       } 
                           }
             }
             
         if(tuioObjectList[i].getSymbolID()==17){
                     times.timereset();  
                   if("TRUE"==(String)rposition.get(17)||"TRUE"==correct.get(17)){
                                
                     times.timercont();
                                       
                     if(sec==4){
                           
                            //x =tuioObjectList[i].getScreenX(950)-1717;
                            //y =tuioObjectList[i].getScreenY(717)-170;
                                    if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)<=321)
                                           {
                                                x17l=(tuioObjectList[i].getScreenX(950)-90);
                                                y17l=tuioObjectList[i].getScreenY(717)-170;
                                                correct.put(17,"TRUE");
                                    }else if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)>=610)
                                           {
                                                x17r=(tuioObjectList[i].getScreenX(950)-40);
                                                y17r=tuioObjectList[i].getScreenY(717)-170;
                                                correct.put(17,"TRUE");
                                   }else if(tuioObjectList[i].getSymbolID()==17){
                                                x17=(tuioObjectList[i].getScreenX(950)-40);
                                                y17=tuioObjectList[i].getScreenY(717)-70;
//                                              clipped.play();
                                                correct.put(17,"TRUE");
                                  }
                     }
                      if(sec>=4||"TRUE"==correct.get(17)){
                                        if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)<=321)
                                       {
                                       
                                               PImage bed17=loadImage("Wardrobe3_left.png");
                                               symbols.put(17, bed17);
                                               copy(bed17,0,0, 154,420, x17l, y17l, 154,420);  
                                        }else if (tuioObjectList[i].getSymbolID()==17&&tuioObjectList[i].getScreenX(950)>=610)
                                       {
                                       
                                               PImage bed17=loadImage("Wardrobe3_right.png");
                                               symbols.put(17, bed17);
                                               copy(bed17,0,0, 154,420, x17r, y17r, 154,420);
                                       }else if(tuioObjectList[i].getSymbolID()==17){
                                              //else{      //image(bed17,717,717,950,17017);
                                               PImage bed17=loadImage("Wardrobe3_center.png");
                                               symbols.put(17, bed17);
                                               copy(bed17,0,0, 97, 179, x17, y17, 97, 179);
                                             }
                                       } 
                           }
             }    
             
            if("TRUE"==correct.get(0)||"TRUE"==correct.get(1)||"TRUE"==correct.get(2)) {
              
              PImage bed101=loadImage("bedcomplete.png");
              symbols.put(18, bed101);
              copy(bed101,0,0,120,39 ,22, 10,120,39);
              
              println(clipped.length());
                    if(aud1==0){
                      clipped.setGain(0);
                      clipped.play(0);
                      if(clipped.position()>150){
                          clipped.pause();
                        clipped.setGain(-500);
                      } 
                     aud1=1;
              }
            }
             
             if("TRUE"==correct.get(3)||"TRUE"==correct.get(4)||"TRUE"==correct.get(5)) {
              
              PImage bed101=loadImage("tablecomplete.png");
              symbols.put(19, bed101);
              copy(bed101,0,0,120,39 ,182, 12,120,39);
              println(clipped.length());
                    if(aud2==0){
                      clipped.setGain(0);
                      clipped.play(0);
                      if(clipped.position()>150){
                          clipped.pause();
                        clipped.setGain(-500);
                      } 
                     aud2=1;
              }
            }
            
            
             if("TRUE"==correct.get(6)||"TRUE"==correct.get(7)||"TRUE"==correct.get(8)) {
              
              PImage bed101=loadImage("lampcomplete.png");
              symbols.put(20, bed101);
              copy(bed101,0,0,120,39 ,335, 12,120,39);
              println(clipped.length());
                    if(aud3==0){
                      clipped.setGain(0);
                      clipped.play(0);
                      if(clipped.position()>150){
                          clipped.pause();
                        clipped.setGain(-500);
                      } 
                     aud3=1;
              }
            }
             if("TRUE"==correct.get(9)||"TRUE"==correct.get(10)||"TRUE"==correct.get(11)) {
              
              PImage bed101=loadImage("portrait.png");
              symbols.put(21, bed101);
              copy(bed101,0,0,120,39 ,618, 12,120,39);
              println(clipped.length());
                    if(aud4==0){
                      clipped.setGain(0);
                      clipped.play(0);
                      if(clipped.position()>150){
                          clipped.pause();
                        clipped.setGain(-500);
                      } 
                     aud4=1;
              }
            }
            if("TRUE"==correct.get(12)||"TRUE"==correct.get(13)||"TRUE"==correct.get(14)) {
              
              PImage bed101=loadImage("sofacomplete.png");
              symbols.put(21, bed101);
              copy(bed101,0,0,120,39 ,776, 12,120,39);
              println(clipped.length());
                    if(aud5==0){
                      clipped.setGain(0);
                      clipped.play(0);
                      if(clipped.position()>150){
                          clipped.pause();
                        clipped.setGain(-500);
                      } 
                     aud5=1;
              }
            }
            if("TRUE"==correct.get(15)||"TRUE"==correct.get(16)||"TRUE"==correct.get(17)) {
              
              PImage bed101=loadImage("wardrobe.png");
              symbols.put(21, bed101);
              copy(bed101,0,0,120,39 ,474, 12,120,39);
              println(clipped.length());
                    if(aud6==0){
                      clipped.setGain(0);
                      clipped.play(0);
                      if(clipped.position()>150){
                          clipped.pause();
                        clipped.setGain(-500);
                      } 
                     aud6=1;
              }
            }
            
             if(("TRUE"==correct.get(0)||"TRUE"==correct.get(1)||"TRUE"==correct.get(2))&&("TRUE"==correct.get(3)||"TRUE"==correct.get(4)||"TRUE"==correct.get(5))&&
                 ("TRUE"==correct.get(6)||"TRUE"==correct.get(7)||"TRUE"==correct.get(8))&&("TRUE"==correct.get(9)||"TRUE"==correct.get(10)||"TRUE"==correct.get(11))&&
                 ("TRUE"==correct.get(12)||"TRUE"==correct.get(13)||"TRUE"==correct.get(14))&&("TRUE"==correct.get(15)||"TRUE"==correct.get(16)||"TRUE"==correct.get(17))){
             
             
                                 player[r].pause();
                                   welldone.play();
                                   symbols.clear();
                                   PImage welldonepix=loadImage("well done.JPG");
                                   background(welldonepix);
                                   if (welldone.position()>=8000){
                                       welldone.pause();
                                       welldone.setGain(-50);}}
    popMatrix();
  }
}


TuioObject [] sortObjs(Vector objs){
  /* Sort the objects in order of their X position - left-most first */
  TuioObject [] newObjs = new TuioObject [objs.size()];
  int numObjs =objs.size();
  float prevX=-1;
  TuioObject o;
  for (int i =0; i<numObjs; i++){
    float minX =height;
    for (int j =0; j<numObjs; j++){
      TuioObject x=(TuioObject)objs.elementAt(j);
      if (x.getX()<minX && x.getX()>prevX){
        minX=x.getX(); 
        newObjs[i]=x;
      }
    }
    prevX=minX;
  }
  return newObjs;
}


// called when an object is added to the scene
void addTuioObject(TuioObject tobj) { 
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) { 
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) { 
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) { 
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) { 
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) { 
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  //redraw();
}
