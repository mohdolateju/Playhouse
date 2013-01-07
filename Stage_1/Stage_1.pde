import TUIO.*;
import ddf.minim.*;
import ddf.minim.javasound.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer[] player=new AudioPlayer[3];
AudioPlayer click;
AudioPlayer welldone;
AudioInput input;
int r=(int)random(3);
TuioProcessing tuioClient;
Timer times=new Timer();

float obj_size = 60;
int txtSize=32;
PFont font;

/*Variables for timer*/
int timerStart = 0;
int offset;

int mill;
int minutes;
int seconds;
int hundredths;

boolean stopped = false;
boolean continued = false;

HashMap placed=new HashMap();
HashMap symbols=new HashMap();
HashMap rotation=new HashMap();
HashMap audio=new HashMap();
//Creating the image array for the backgrounds
PImage[]img=new PImage[3];
//Creating a randome number between 0 and 2 to represent the position of background image in the array
int opt=(int)random(3);


void setup(){  
//assigning the images into the array
  img[0] = loadImage("Stage1_opt1.jpg");
  img[1] = loadImage("Stage1_opt2.jpg");
  img[2] = loadImage("Stage1_opt3.jpg");
  
  size(950,717);
  background(img[opt]);
  minim = new Minim(this);
  player[0] = minim.loadFile("playhouse1.mp3");
  player[1] = minim.loadFile("playhouse2.mp3");
  player[2] = minim.loadFile("playhouse3.mp3");
  click=minim.loadFile("bellclick.mp3");
  welldone=minim.loadFile("welldone.mp3");
  input = minim.getLineIn();
  player[r].play();
  player[r].loop();
  player[r].setGain(-5); //set Volume
  //new 
  //player[r].setVolume(50.0);
  //float v=player[r].getVolume();
  //println(v);
   
  //} 
//loading fudicials according to the background image
  if(opt==0){
  PImage drawer=loadImage("draweropt1.png");
    symbols.put(0, drawer);
  PImage lamp=loadImage("lampopt1.png");
    symbols.put(1, lamp);
  PImage potrait1=loadImage("Portrait1opt1.png");
    symbols.put(2, potrait1);
  PImage potrait2=loadImage("Portrait2opt1.png");
    symbols.put(3, potrait2);
  PImage sofa=loadImage("singlesofaopt1.png");
    symbols.put(4, sofa);
  PImage table=loadImage("tableopt1.png");
    symbols.put(5, table);
  PImage wardrobe=loadImage("wardrobeopt1.png");
    symbols.put(6, wardrobe);
  PImage bed=loadImage("bedopt1.png");
    symbols.put(7, bed);
    }
    
    else if(opt==1){
  PImage desk=loadImage("Deskopt2.png");
    symbols.put(0, desk);
  PImage lamp1=loadImage("Lamp1opt2.png");
    symbols.put(1, lamp1); 
 PImage lamp2=loadImage("Lamp2opt2.png");
    symbols.put(2, lamp2); 
 PImage table=loadImage("Tableopt2.png");
    symbols.put(3, table); 
 PImage wardrobe=loadImage("Wardrobeopt2.png");
    symbols.put(4, wardrobe); 
 PImage bed=loadImage("Bedopt2.png");
    symbols.put(5, bed); 
 PImage bench=loadImage("benchopt2.png");
    symbols.put(6, bench); 
 PImage portrait1=loadImage("Portrait1opt2.png");
    symbols.put(7, portrait1); 
 PImage portrait2=loadImage("portrait2opt2.png");
    symbols.put(8, portrait2);    
    }
    else if(opt==2){
  PImage bed=loadImage("bedopt3.png");
    symbols.put(0, bed);
  PImage desktop=loadImage("deskopt3.png");
    symbols.put(1, desktop); 
 PImage lamp=loadImage("lampop3.png");
    symbols.put(2, lamp); 
 PImage portrait1=loadImage("Portrait1opt3.png");
    symbols.put(3, portrait1); 
 PImage portrait2=loadImage("Portrait2op3.png");
    symbols.put(4, portrait2);
 PImage sofa=loadImage("Sofaopt3.png");
    symbols.put(5, sofa); 
 PImage table=loadImage("Tableopt3.png");
    symbols.put(6, table);     
  PImage wardrobeopt3=loadImage("Wardrobeopt3.png");
    symbols.put(7, wardrobeopt3);
    }
  loop();
  
  // an instance of the TuioProcessing
  // since we ad "this" class as an argument the TuioClient expects
  // an implementation of the TUIO callback methods (see below)
  
  tuioClient  = new TuioProcessing(this);       

}

void draw(){
  background(img[opt]);
  TuioObject[] tuioObjectList = sortObjs(tuioClient.getTuioObjects());
  // Draw objects on the screen
  for (int i=0;i<tuioObjectList.length;i++) {
    TuioObject tobj = tuioObjectList[i];
    pushMatrix();
    translate(tobj.getScreenX(950),tobj.getScreenY(717));
    rotate(tobj.getAngle());
    float angle=tobj.getAngleDegrees();
    int id = tobj.getSymbolID();
    String txt;

     if (symbols.containsKey(id)){// if it's one in symbols, then look it up
     
      if(angle<=15 || angle>=345){
                  //println("RIGHT ANGLE");
                  if (id==0){
                  rotation.put(0,"TRUE");
                        }
                  if (id==1){
                  rotation.put(1,"TRUE");
                        }
                  if (id==2){
                  rotation.put(2,"TRUE");
                        }
                  if (id==3){
                  rotation.put(3,"TRUE");
                        }
                  if (id==4){
                  rotation.put(4,"TRUE");
                        }
                  if (id==5){
                  rotation.put(5,"TRUE");
                        }
                  if (id==6){
                  rotation.put(6,"TRUE");
                        }
                  if (id==7){
                  rotation.put(7,"TRUE");
                        }
                  if (id==8){
                  rotation.put(8,"TRUE");
                        }
                  }else {
                  if(id==0){
                  rotation.put(0,"FALSE");}
                  if(id==1){
                  rotation.put(1,"FALSE");}
                  if(id==2){
                  rotation.put(2,"FALSE");}
                  if(id==3){
                  rotation.put(3,"FALSE");}
                  if(id==4){
                  rotation.put(4,"FALSE");}
                  if(id==5){
                  rotation.put(5,"FALSE");}
                  if(id==6){
                  rotation.put(6,"FALSE");}
                    if(id==7){
                  rotation.put(7,"FALSE");
                      }
                    if(id==8){
                  rotation.put(8,"FALSE");
                      }
                }
//Displaying the fudicials according to the background

        if(opt==0){
          
          //translate(tobj.getScreenX(750),tobj.getScreenY(537));
          //translate(-100,-80);
          //image((PImage)symbols.get(id),0,0);
               //txt = (String)symbols.get(id);
               int x=tuioObjectList[i].getScreenX(950);
               int y=tuioObjectList[i].getScreenY(717);
               println("X = "+tobj.getScreenX(950)+" Y = "+tobj.getScreenY(717)+" Symbol id is "+ id);
               //println(tuioObjectList );
               
              //Testing if the fudicials are in the right position
               //timereset();
               //timercont();
               int sec= times.timer();
               times.timereset();
              println(sec);
               if (tuioObjectList[i].getSymbolID()==0&&312<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=352 
                     && 384<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=424)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(0)=="TRUE")&&((String)rotation.get(0)=="TRUE"))
                  {
                       PImage sucdrawer=loadImage("Green_drawer.png");
                       symbols.put(0,sucdrawer);
                       image((PImage)symbols.get(id),-30,-45);
                       placed.put(0,"TRUE");
                       
                       if (audio.get(0)!="1"){
                           click.play(0);
                           audio.put(0,"1");
                                                   }
                   }else if((String)rotation.get(0)=="TRUE"){
                           PImage drawer=loadImage("draweropt1.png");
                           symbols.put(0, drawer);
                           image((PImage)symbols.get(id),-30,-45);
                                       }
                   else{
                          PImage sucdrawer=loadImage("Red_draweropt.png");
                          symbols.put(0,sucdrawer);                    
                          image((PImage)symbols.get(id),-30,-45);
                          
                }
               } else
                        {
                          if(tuioObjectList[i].getSymbolID()==0){
                                  PImage drawer=loadImage("draweropt1.png");
                                  symbols.put(0, drawer);
                                  image((PImage)symbols.get(id),-30,-45);
                                                                }
                          if(tuioObjectList[i].getSymbolID()==0&&((String)rotation.get(0)=="FALSE")){
                                  PImage sucdrawer=loadImage("Red_draweropt.png");
                          symbols.put(0,sucdrawer);                    
                          image((PImage)symbols.get(id),-30,-45);
                          
                                                               }  
                         }
               
                if (tuioObjectList[i].getSymbolID()==1&&307<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=347
                     && 346<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=386){    
                       times.timereset();
                          if(id==1){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(1)=="TRUE")&&((String)rotation.get(1)=="TRUE")){
                                              PImage lamp=loadImage("greenlampoopt1.png");
                                              symbols.put(1, lamp);
                                              image((PImage)symbols.get(id),-10,-55);
                                               placed.put(1,"TRUE");
                                         if (audio.get(1)!="1"){
                                              click.play(0);
                                              audio.put(1,"1");
                                                   }  
                                          }
                                  else if((String)rotation.get(1)=="TRUE"){
                     
                                              PImage lamp=loadImage("lampopt1.png");
                                              symbols.put(1, lamp);
                                              image((PImage)symbols.get(id),-10,-55);
                                       } 
                                  else{
                                              PImage lamp=loadImage("Red_lampopt1.png");
                                              symbols.put(1, lamp);
                                              image((PImage)symbols.get(id),-10,-55);
                                       }
                     }
                     }else {
                          if(tuioObjectList[i].getSymbolID()==1){
                                  PImage lamp=loadImage("lampopt1.png");
                                  symbols.put(1, lamp);
                                  image((PImage)symbols.get(id),-10,-55);
                                                               }
                          if(tuioObjectList[i].getSymbolID()==1&&((String)rotation.get(1)=="FALSE")){
                                  PImage lamp=loadImage("Red_lampopt1.png");
                                  symbols.put(1, lamp);
                                  image((PImage)symbols.get(id),-10,-55);
                          
                                                               }   
                         }
               
             
                     
                if (808<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=845
                     && 242<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=282){     
                       times.timereset();
                          if(id==2){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(2)=="TRUE")&&((String)rotation.get(2)=="TRUE")){
                                              PImage potrait1=loadImage("GreenPortrait1Right.png");
                                              symbols.put(2, potrait1);
                                              image((PImage)symbols.get(id),-30,-100);
                                              placed.put(2,"TRUE");
                                          if (audio.get(2)!="1"){
                                              click.play(0);
                                              audio.put(2,"1");
                                                   }  
                                          }
                                  else if((String)rotation.get(2)=="TRUE"){
                                              PImage potrait1=loadImage("Portrait1opt1.png");
                                              symbols.put(2, potrait1);
                                              image((PImage)symbols.get(id),-30,-100);
                                       }    
                                  else{
                                              PImage potrait1=loadImage("Red_Portraitopt1.png");
                                              symbols.put(2, potrait1);
                                              image((PImage)symbols.get(id),-30,-100);
                                       }
                                  
                     }
                     }
                    else 
                        {
                          if(tuioObjectList[i].getSymbolID()==2){
                                  PImage potrait1=loadImage("Portrait1opt1.png");
                                  symbols.put(2, potrait1);
                                  image((PImage)symbols.get(id),-30,-100);
                                                               }
                           if(tuioObjectList[i].getSymbolID()==2&&((String)rotation.get(2)=="FALSE")){
                                  PImage potrait1=loadImage("Red_Portraitopt1.png");
                                  symbols.put(2, potrait1);
                                  image((PImage)symbols.get(id),-30,-100);
                          
                                                               }  
                         } 
                   
                
                if (328<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=368
                     && 278<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=318){     
                       times.timereset();
                          if(id==3){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(3)=="TRUE")&&((String)rotation.get(3)=="TRUE")){
                                              PImage potrait2=loadImage("GreenPortrait2opt1.png");
                                              symbols.put(3, potrait2);
                                              image((PImage)symbols.get(id),-30,-60);
                                              placed.put(3,"TRUE");
                                              
                                              if (audio.get(3)!="1"){
                                              click.play(0);
                                              audio.put(3,"1");
                                                   }
                                            }
                                  else if((String)rotation.get(3)=="TRUE"){
                                              PImage potrait2=loadImage("Portrait2opt1.png");
                                              symbols.put(3, potrait2);
                                              image((PImage)symbols.get(id),-30,-60);
                                       }  
                                  else{
                                              PImage potrait2=loadImage("Red_Portrait2opt1.png");
                                              symbols.put(3, potrait2);
                                              image((PImage)symbols.get(id),-30,-60);
                                       }
                                  
                     }
                     }
                     else  {
                          if(tuioObjectList[i].getSymbolID()==3){
                                  PImage potrait2=loadImage("Portrait2opt1.png");
                                  symbols.put(3, potrait2);
                                  image((PImage)symbols.get(id),-30,-60);
                                                               }  
                                                               
                            if(tuioObjectList[i].getSymbolID()==3&&((String)rotation.get(3)=="FALSE")){
                                  PImage potrait2=loadImage("Red_Portrait2opt1.png");
                                  symbols.put(3, potrait2);
                                  image((PImage)symbols.get(id),-30,-60);
                          
                                                               }
                         } 
                         
                     
                  if (580<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=620
                     && 403<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=443){     
                       times.timereset();
                          if(id==4){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(4)=="TRUE")&&((String)rotation.get(4)=="TRUE")){
                                              PImage sofa=loadImage("Greensinglesofa.png");
                                              symbols.put(4, sofa);
                                              image((PImage)symbols.get(id),-30,-70);
                                              placed.put(4,"TRUE");
                                              
                                              if (audio.get(4)!="1"){
                                              click.play(0);
                                              audio.put(4,"1");
                                                   }
                                            }
                                  else if((String)rotation.get(4)=="TRUE"){
                                              PImage sofa=loadImage("singlesofaopt1.png");
                                              symbols.put(4, sofa);
                                              image((PImage)symbols.get(id),-30,-70); 
                                            }
                                  else{
                                              PImage sofa=loadImage("Red_singleopt1.png");
                                              symbols.put(4, sofa);
                                              image((PImage)symbols.get(id),-30,-70);
                                       }
                                  
                     }
                     }               else{
                          if(tuioObjectList[i].getSymbolID()==4){
                                  PImage sofa=loadImage("singlesofaopt1.png");
                                  symbols.put(4, sofa);
                                  image((PImage)symbols.get(id),-30,-70);
                                                               }
                          if(tuioObjectList[i].getSymbolID()==4&&((String)rotation.get(4)=="FALSE")){
                                  PImage sofa=loadImage("Red_singleopt1.png");
                                  symbols.put(4, sofa);
                                  image((PImage)symbols.get(id),-30,-70);
                          
                                                               }  
                         }
                 
                  if (697<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=737
                     && 498<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=538){     
                       times.timereset();
                          if(id==5){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(5)=="TRUE")&&((String)rotation.get(5)=="TRUE")){
                                              
                                              PImage table=loadImage("Greentableopt1.png");
                                               symbols.put(5, table);
                                               image((PImage)symbols.get(id),-150,-100);
                                              placed.put(5,"TRUE");
                                              
                                              if (audio.get(5)!="1"){
                                              click.play(0);
                                              audio.put(5,"1");
                                                   }
                                            }
                                           
                                            
                                  else if((String)rotation.get(5)=="TRUE"){
                                               PImage table=loadImage("tableopt1.png");
                                               symbols.put(5, table);
                                               image((PImage)symbols.get(id),-150,-100);
                                            }
                                  else{         
                                               PImage table=loadImage("Red_tableopt1.png");
                                               symbols.put(5, table);
                                               image((PImage)symbols.get(id),-150,-100);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==5){
                                  PImage table=loadImage("tableopt1.png");
                                  symbols.put(5, table);
                                  image((PImage)symbols.get(id),-150,-100);
                                                               }
                         if(tuioObjectList[i].getSymbolID()==5&&((String)rotation.get(5)=="FALSE")){
                                  PImage table=loadImage("Red_tableopt1.png");
                                  symbols.put(5, table);
                                  image((PImage)symbols.get(id),-150,-100);
                          
                                                               }  
                         }
                     
                   if (178<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=218
                     && 311<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=351){     
                       times.timereset();
                          if(id==6){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(6)=="TRUE")&&((String)rotation.get(6)=="TRUE")){
                                               PImage wardrobe=loadImage("Greenwardrobeopt1.png");
                                               symbols.put(6, wardrobe);
                                               image((PImage)symbols.get(id),-90,-170);
                                              placed.put(6,"TRUE");
                                              
                                              if (audio.get(6)!="1"){
                                              click.play(0);
                                              audio.put(6,"1");
                                                   }
                                            }
                                  else if((String)rotation.get(6)=="TRUE"){
                                               PImage wardrobe=loadImage("wardrobeopt1.png");
                                               symbols.put(6, wardrobe);
                                               image((PImage)symbols.get(id),-90,-170);
                                            } 
                                  else{
                                               PImage wardrobe=loadImage("Red_wardrobeopt1.png");
                                               symbols.put(6, wardrobe);
                                               image((PImage)symbols.get(id),-90,-170);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==6){
                                  PImage wardrobe=loadImage("wardrobeopt1.png");
                                  symbols.put(6, wardrobe);
                                  image((PImage)symbols.get(id),-90,-170);
                                                               }  
                         }
                         if(tuioObjectList[i].getSymbolID()==6&&((String)rotation.get(6)=="FALSE")){
                                  PImage wardrobe=loadImage("Red_wardrobeopt1.png");
                                  symbols.put(6, wardrobe);
                                  image((PImage)symbols.get(id),-90,-170);
                          
                                                               }
                     /*
                 else if (559<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=579
                     && 343<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=363){     
                       times.timereset();
                          if(id==4){
                               times.timercont();
                                  if(sec>=2 || (String)placed.get(4)=="TRUE"){
                                              PImage sofa=loadImage("Greensinglesofa.png");
                                              symbols.put(4, sofa);
                                              placed.put(4,"TRUE");
                                            } 
                                  else{
                                              PImage sofa=loadImage("singlesofaopt1.png");
                                              symbols.put(4, sofa);
                                       }
                                  
                     }
                     }*/    
                 if ((445<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=485)
                     && (394<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=434)){     
                       times.timereset();
                          if(id==7){
                            /*test
                            placed.put(0,"TRUE");
                            placed.put(1,"TRUE");
                            placed.put(2,"TRUE");
                            placed.put(3,"TRUE");
                            placed.put(4,"TRUE");
                            placed.put(5,"TRUE");
                            placed.put(6,"TRUE");*/
                               times.timercont();//&&((String)rotation.get(0)=="TRUE")
                                  if((sec>=2 || (String)placed.get(7)=="TRUE")&&((String)rotation.get(7)=="TRUE")){
                                              
                                              if (audio.get(7)!="1"){
                                              click.play(7);
                                              audio.put(7,"1");
                                                   }
                                    
                                              PImage bed=loadImage("greenbedopt1.png");
                                              symbols.put(7, bed);
                                              placed.put(7,"TRUE");
                                              image((PImage)symbols.get(id),-90,-60);
                                              
                                            }
                                   else if((String)rotation.get(7)=="TRUE"){
                                              PImage bed=loadImage("bedopt1.png");
                                              symbols.put(7, bed);
                                              image((PImage)symbols.get(id),-90,-60);
                                       }    
                                  else{
                                              PImage bed=loadImage("redbedopt2.png");
                                              symbols.put(7, bed);
                                              image((PImage)symbols.get(id),-90,-60);
                                       }
                                 
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==7){
                                  PImage bed=loadImage("bedopt1.png");
                                  symbols.put(7, bed);
                                  image((PImage)symbols.get(id),-90,-60);
                                                               }
                          if(tuioObjectList[i].getSymbolID()==7&&((String)rotation.get(7)=="FALSE")){
                                  PImage bed=loadImage("redbedopt2.png");
                                  symbols.put(7, bed);
                                  image((PImage)symbols.get(id),-90,-60);
                                                               }  
                                              
                         }
                      // To place object if removed   &&((String)rotation.get(0)=="TRUE")
                  if (((String)placed.get(0)=="TRUE")){
                          if( id!=0||((266>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=404)
                                 || (338>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=462))){
                                  
                                PImage drawer=loadImage("draweropt1r.png");
                                    symbols.put(16, drawer);
                                  copy(drawer,0,0, 64, 59, 305, 355, 64, 59);
                          }
                        }
                  if (((String)placed.get(1)=="TRUE")){
                          if( id!=1||((300>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=368)
                                 || (336>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=417))){
                                  
                                PImage lamp=loadImage("lampopt1r.png");
                                    symbols.put(15, lamp);
                                  copy(lamp,0,0, 34, 34, 322, 321, 34, 34);
                          }
                        }
                  if (((String)placed.get(2)=="TRUE")){
                          if( id!=2||((711>=tuioObjectList[i].getScreenX(950))
                                 || (100>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=376))){
                                  
                                PImage potrait1=loadImage("Portrait1opt1r.png");
                                    symbols.put(14, potrait1);
                                  copy(potrait1,0,0, 126, 159, 800, 160, 126, 159);
                          }
                        }
                  if (((String)placed.get(3)=="TRUE")){
                          if( id!=3||((312>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=387)
                                 || (246>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=345))){
                                  
                                PImage potrait2=loadImage("Portrait2opt1.png");
                                    symbols.put(13, potrait2);
                                  copy(potrait2,0,0, 38, 48, 320, 235, 38, 48);
                          }
                        }
                   
                   if (((String)placed.get(4)=="TRUE")){
                          if( id!=4||((509>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=687)
                                 || (336>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=520))){
                                  
                                PImage sofar=loadImage("singlesofaopt1r.png");
                                    symbols.put(12, sofar);
                                  copy(sofar,0,0, 86, 92, 570, 347, 86, 92);
                          }
                   } 
                   if (((String)placed.get(5)=="TRUE")){
                          if(( id!=5)||(392>=tuioObjectList[i].getScreenX(950)||399>=tuioObjectList[i].getScreenY(717))){
                                  
                                PImage tablec=loadImage("tableopt1c.png");
                                    symbols.put(10, tablec);
                                  copy(tablec,0,0, 309, 197, 569, 440, 309, 197);
                                PImage tablet=loadImage("tableopt1ct.png");
                                    symbols.put(11, tablet);
                                  copy(tablet,0,0, 93, 26, 705, 425, 93, 26);
                          }
                        }
                   if (((String)placed.get(6)=="TRUE")){
                          if(( id!=6)||((34>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=358))){
                                  
                                PImage wardrobec=loadImage("wardrobeopt1r.png");
                                    symbols.put(9, wardrobec);
                                  copy(wardrobec,0,0, 159, 445, 109, 165, 159, 445);
                          }
                        }
                   if (((String)placed.get(7)=="TRUE")){
                          if( (id!=7)||((279>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=656)
                                 || (288>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=538))){
                                  
                                PImage bedc=loadImage("bedopt1r.png");
                                    symbols.put(8, bedc);
                                  copy(bedc,0,0, 189, 120, 378, 355, 189, 120);
                          }
                        }
                        
                  
        }
        
          else if(opt==1){
              //txt = (String)symbols.get(id);
               println("X = "+tobj.getScreenX(950)+" Y = "+tobj.getScreenY(717)+" Symbol id is "+ id);
        
               int x=tuioObjectList[i].getScreenX(950);
               int y=tuioObjectList[i].getScreenY(717);
               int sec= times.timer();
               times.timereset();
              println(sec);
               if (tuioObjectList[i].getSymbolID()==0&&514<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=554 
                     && 374<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=414)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(0)=="TRUE")&&((String)rotation.get(0)=="TRUE"))
                  {
                       PImage desk=loadImage("GreenDesk.png");
                       symbols.put(0, desk);
                       image((PImage)symbols.get(id),-10,-30);
                       placed.put(0,"TRUE");
                       
                       if (audio.get(0)!="1"){
                           click.play(0);
                           audio.put(0,"1");
                         }
                   }
                   else if((String)rotation.get(0)=="TRUE"){
                           PImage desk=loadImage("Deskopt2.png");
                           symbols.put(0, desk);
                           image((PImage)symbols.get(id),-10,-30);
                                       }
                   else{
                        PImage desk=loadImage("Red_Deskopt2.png");
                        symbols.put(0, desk);
                        image((PImage)symbols.get(id),-10,-30);
                }
               }else{
                          if(tuioObjectList[i].getSymbolID()==0){
                                  PImage desk=loadImage("Deskopt2.png");
                                  symbols.put(0, desk);
                                  image((PImage)symbols.get(id),-10,-30);
                                                               }
                          if(tuioObjectList[i].getSymbolID()==0&&((String)rotation.get(0)=="FALSE")){
                          PImage desk=loadImage("Red_Deskopt2.png");
                          symbols.put(0,desk);                    
                          image((PImage)symbols.get(id),-10,-30);
                          }   
                         }
               
               
                      if (tuioObjectList[i].getSymbolID()==1&&82<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=122
                           && 403<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=443){    
                       times.timereset();
                          if(id==1){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(1)=="TRUE")&&((String)rotation.get(1)=="TRUE")){
                                              PImage lamp1=loadImage("GreenLamp1.png");
                                              symbols.put(1, lamp1);
                                              image((PImage)symbols.get(id),-50,-70);
                                               placed.put(1,"TRUE");
                                               
                                     if (audio.get(1)!="1"){
                                     click.play(0);
                                     audio.put(1,"1");
                                     }  
                                            }
                                    else if((String)rotation.get(1)=="TRUE"){
                                              PImage lamp1=loadImage("Lamp1opt2.png");
                                            
                                            symbols.put(1, lamp1);
                                            image((PImage)symbols.get(id),-50,-70);
                                       }
                                  else{
                                             PImage lamp1=loadImage("Red_Lamp1opt2.png");
                                             symbols.put(1, lamp1);
                                             image((PImage)symbols.get(id),-50,-70);
                                       }
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==1){
                               PImage lamp1=loadImage("Lamp1opt2.png");
                               symbols.put(1, lamp1);
                               image((PImage)symbols.get(id),-50,-70);
                                                               }
                          if(tuioObjectList[i].getSymbolID()==1&&((String)rotation.get(1)=="FALSE")){
                          PImage lamp1=loadImage("Red_Lamp1opt2.png");
                          symbols.put(1, lamp1);
                          image((PImage)symbols.get(id),-50,-70);
                          }  
                         }
                     
                   if (527<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=547
                     && 350<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=390){     
                       times.timereset();
                          if(id==2){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(2)=="TRUE")&&((String)rotation.get(2)=="TRUE")){
                                              PImage lamp2=loadImage("GreenLamp2.png");
                                              symbols.put(2, lamp2);
                                              image((PImage)symbols.get(id),0,-50);
                                              placed.put(2,"TRUE");
                                              
                                         if (audio.get(2)!="1"){
                                         click.play(0);
                                         audio.put(2,"1");
                                           }
                                            }
                                     else if((String)rotation.get(2)=="TRUE"){
                                             PImage lamp2=loadImage("Lamp2opt2.png");
                                            symbols.put(2, lamp2);
                                            image((PImage)symbols.get(id),0,-50);
                                       } 
                                  else{
                                              PImage lamp2=loadImage("Red_Lampopt2.png");
                                              symbols.put(2, lamp2);
                                              image((PImage)symbols.get(id),0,-50);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==2){
                               PImage lamp2=loadImage("Lamp2opt2.png");
                               symbols.put(2, lamp2);
                               image((PImage)symbols.get(id),0,-50);
                                                               }
                          if((tuioObjectList[i].getSymbolID()==2)&&((String)rotation.get(2)=="FALSE")){
                          PImage lamp2=loadImage("Red_Lampopt2.png");
                          symbols.put(2, lamp2);
                          image((PImage)symbols.get(id),0,-50);
                          }  
                         }
                         

                     if (409<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=449
                     && 320<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=360){     
                       times.timereset();
                          if(id==3){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(3)=="TRUE")&&((String)rotation.get(3)=="TRUE")){
                                              PImage table=loadImage("GreenTable.png");
                                              symbols.put(3, table);
                                              image((PImage)symbols.get(id),-60,0);
                                              placed.put(3,"TRUE");
                                              
                                              if (audio.get(3)!="1"){
                                              click.play(0);
                                              audio.put(3,"1");
                                               }
                                            }
                                   else if((String)rotation.get(3)=="TRUE"){
                                            PImage table=loadImage("Tableopt2.png");
                                            symbols.put(3, table);
                                            image((PImage)symbols.get(id),-60,0);
                                       } 
                                  else{
                                              PImage table=loadImage("Red_Tableopt2.png");
                                              symbols.put(3, table);
                                              image((PImage)symbols.get(id),-60,0);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==3){
                                PImage table=loadImage("Tableopt2.png");
                                symbols.put(3, table);
                                image((PImage)symbols.get(id),-60,0);
                                                               }                                    
                          if((tuioObjectList[i].getSymbolID()==3)&&((String)rotation.get(3)=="FALSE")){
                                PImage table=loadImage("Red_Tableopt2.png");
                                symbols.put(3, table);
                                image((PImage)symbols.get(id),-60,0);
                          }
                         }
                     
                     if (735<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=775
                     && 273<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=313){     
                       times.timereset();
                          if(id==4){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(4)=="TRUE")&&((String)rotation.get(4)=="TRUE")){
                                              PImage wardrobe=loadImage("GreenWardrobe.png");
                                              symbols.put(4, wardrobe);
                                              image((PImage)symbols.get(id),-20,-150);
                                              placed.put(4,"TRUE");
                                            
                                             if (audio.get(4)!="1"){
                                             click.play(0);
                                             audio.put(4,"1");
                                             }
                                          
                                        }
                                       else if((String)rotation.get(4)=="TRUE"){
                                            PImage wardrobe=loadImage("Wardrobeopt2.png");
                                              symbols.put(4, wardrobe);
                                              image((PImage)symbols.get(id),-20,-150);
                                       } 
                                  else{
                                              PImage wardrobe=loadImage("Red_Wardrobeopt2.png");
                                              symbols.put(4, wardrobe);
                                              image((PImage)symbols.get(id),-20,-150);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==4){
                               PImage wardrobe=loadImage("Wardrobeopt2.png");
                               symbols.put(4, wardrobe);
                               image((PImage)symbols.get(id),-20,-150);
                                                               }
                          if((tuioObjectList[i].getSymbolID()==4)&&((String)rotation.get(4)=="FALSE")){
                                PImage wardrobe=loadImage("Red_Wardrobeopt2.png");
                                symbols.put(4, wardrobe);
                                image((PImage)symbols.get(id),-20,-150);
                          }  
                         }
                    if (583<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=624
                     && 393<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=433){     
                       times.timereset();
                          if(id==5){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(5)=="TRUE")&&((String)rotation.get(5)=="TRUE")){
                                               PImage bed=loadImage("GreenBedopt2.png");
                                               symbols.put(5, bed);
                                               image((PImage)symbols.get(id),-50,-50);
                                              placed.put(5,"TRUE");
                                            
                                              if (audio.get(5)!="1"){
                                              click.play(0);
                                              audio.put(5,"1");
                                               }
                                          
                                        }
                                       else if((String)rotation.get(5)=="TRUE"){
                                              PImage bed=loadImage("Bedopt2.png");
                                              symbols.put(5, bed);
                                              image((PImage)symbols.get(id),-50,-50);
                                       } 
                                  else{
                                               PImage bed=loadImage("Red_Bedopt2.png");
                                               symbols.put(5, bed);
                                               image((PImage)symbols.get(id),-50,-50);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==5){
                               PImage bed=loadImage("Bedopt2.png");
                               symbols.put(5, bed);
                               image((PImage)symbols.get(id),-50,-50);
                                                               }  
                          if((tuioObjectList[i].getSymbolID()==5)&&((String)rotation.get(5)=="FALSE")){
                                PImage bed=loadImage("Red_Bedopt2.png");
                                symbols.put(5, bed);
                                image((PImage)symbols.get(id),-50,-50);
                         }
                       }
                     if (195<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=235
                     && 467<=tuioObjectList[i].getScreenY(717)&&tuioObjectList[i].getScreenY(717)<=507){     
                       times.timereset();
                          if(id==6){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(6)=="TRUE")&&((String)rotation.get(6)=="TRUE")){
                                               PImage bench=loadImage("Greenbence.png");
                                               symbols.put(6, bench);
                                               image((PImage)symbols.get(id),-100,-90);
                                              placed.put(6,"TRUE");
                                              
                                              if (audio.get(6)!="1"){
                                              click.play(0);
                                              audio.put(6,"1");
                                                     }
                                            }
                                              else if((String)rotation.get(6)=="TRUE"){
                                              PImage bench=loadImage("benchopt2.png");
                                              symbols.put(6, bench);
                                              image((PImage)symbols.get(id),-100,-90);
                                       }
                                  else{
                                               PImage bench=loadImage("Red_benceopt2.png");
                                               symbols.put(6, bench);
                                               image((PImage)symbols.get(id),-100,-90);
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==6){
                               PImage bench=loadImage("benchopt2.png");
                               symbols.put(6, bench);
                               image((PImage)symbols.get(id),-100,-90);
                                                               }
                          if((tuioObjectList[i].getSymbolID()==6)&&((String)rotation.get(6)=="FALSE")){
                                PImage bench=loadImage("Red_benceopt2.png");
                                symbols.put(6, bench);
                                image((PImage)symbols.get(id),-100,-90);
                         }  
                         }
                     
                     if ((402<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=444)
                     && (293<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=333)){     
                       times.timereset();
                          if(id==7){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(7)=="TRUE")&&((String)rotation.get(7)=="TRUE")){
                                              PImage portrait1=loadImage("GreenPortrait1.png");
                                              symbols.put(7, portrait1);
                                             image((PImage)symbols.get(id),-23,-35); 
                                              placed.put(7,"TRUE");
                                            
                                        if (audio.get(7)!="1"){
                                     click.play(0);
                                     audio.put(7,"1");
                                     }
                                          
                                        }
                                        else if((String)rotation.get(7)=="TRUE"){
                                              PImage portrait1=loadImage("Portrait1opt2.png");
                                              symbols.put(7, portrait1);
                                              image((PImage)symbols.get(id),-23,-35); 
                                       } 
                                  else{
                                              PImage portrait1=loadImage("Red_Portraitopt2.png");
                                              image((PImage)symbols.get(id),-23,-35);
                                              symbols.put(7, portrait1); 
                                       }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==7){
                               PImage portrait1=loadImage("Portrait1opt2.png");
                               symbols.put(7, portrait1); 
                               image((PImage)symbols.get(id),-23,-35);
                                                               }
                          if((tuioObjectList[i].getSymbolID()==7)&&((String)rotation.get(7)=="FALSE")){
                               PImage portrait1=loadImage("Red_Portraitopt2.png");
                               symbols.put(7, portrait1); 
                               image((PImage)symbols.get(id),-23,-35);
                         }  
                         }

                     if ((184<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=224)
                     && (280<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=320)){     
                       times.timereset();
                          if(id==8){
                               times.timercont();
                                  if((sec>=2 || (String)placed.get(8)=="TRUE")&&((String)rotation.get(8)=="TRUE")){
                                               PImage portrait2=loadImage("Greenportrait2.png");
                                               symbols.put(8, portrait2);
                                               image((PImage)symbols.get(id),-40,-80);
                                              placed.put(8,"TRUE");
                                              
                                              if (audio.get(8)!="1"){
                                              click.play(0);
                                              audio.put(8,"1");
                                               }
                                            }
                                           else if((String)rotation.get(8)=="TRUE"){
                                              PImage portrait2=loadImage("portrait2opt2.png");
                                               symbols.put(8, portrait2); 
                                               image((PImage)symbols.get(id),-40,-80); 
                                               } 
                                          else{
                                               PImage portrait2=loadImage("Red_portraitopt2.png");
                                               symbols.put(8, portrait2); 
                                               image((PImage)symbols.get(id),-40,-80);
                                           }
                                  
                     }
                     }else{
                          if(tuioObjectList[i].getSymbolID()==8){
                               PImage portrait2=loadImage("portrait2opt2.png");
                               symbols.put(8, portrait2);  
                               image((PImage)symbols.get(id),-40,-80);
                                                               }
                          if((tuioObjectList[i].getSymbolID()==8)&&((String)rotation.get(8)=="FALSE")){
                               PImage portrait2=loadImage("Red_portraitopt2.png");
                               symbols.put(8, portrait2); 
                               image((PImage)symbols.get(id),-40,-80);
                         }
                       
                            // To place object if removed   &&((String)rotation.get(0)=="TRUE")
                  if (((String)placed.get(0)=="TRUE")){
                          if( id!=0||((481>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=591)
                                 || (342>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=438))){
                                  
                                PImage drawerc=loadImage("Deskopt2.png");
                                    symbols.put(22, drawerc);
                                  copy(drawerc,0,0, 51, 44, 525, 360, 51, 44);
                          }
                        }
                  if (((String)placed.get(1)=="TRUE")){
                          if( id!=1||((tuioObjectList[i].getScreenX(950)<=48||tuioObjectList[i].getScreenX(950)>=193)
                                 || (148>=tuioObjectList[i].getScreenY(717)))){
                                  
                                PImage lampt=loadImage("lampopt1t.png");
                                symbols.put(19, lampt);
                                copy(lampt,0,0, 77, 88, 61, 355, 77, 88);
                                PImage lampm=loadImage("lampopt1m.png");
                                symbols.put(20, lampm);
                                copy(lampm,0,0,24,191, 92, 425, 24, 191);
                                PImage lampb=loadImage("lampopt1b.png");
                                symbols.put(21, lampb);
                                copy(lampb,0,0,54,29, 83, 605, 54,29);
                          }
                        }
                  if (((String)placed.get(2)=="TRUE")){
                          if( id!=2||((506>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=564)
                                 || (323>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=414))){
                                  
                                PImage Lamp2opt2c=loadImage("Lamp2opt2c.png");
                                    symbols.put(18, Lamp2opt2c);
                                  copy(Lamp2opt2c,0,0, 30, 47, 538, 314, 30, 47);
                          }
                        }
                  if (((String)placed.get(3)=="TRUE")){
                          if( id!=3||((342>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=579)
                                 || (272>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=409))){
                                  
                                  PImage Tableopt2c=loadImage("Tableopt2c.png");
                                  symbols.put(17, Tableopt2c);
                                  copy(Tableopt2c,0,0, 148, 68, 364, 340, 148, 68);
                          }
                        }
                   
                   if (((String)placed.get(4)=="TRUE")){
                          if( id!=4||(579>=tuioObjectList[i].getScreenX(950))){
                                  
                                PImage wardrobec=loadImage("Wardrobeopt2c.png");
                                symbols.put(16, wardrobec);
                                 copy(wardrobec,0,0, 184, 544, 740, 138,184, 544);
                          }
                   } 
                   if (((String)placed.get(5)=="TRUE")){
                          if(( id!=5)||((462>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=751)
                                 || (327>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=497))){
                                  
                                PImage bedopt2r=loadImage("bedopt2r.png");
                                    symbols.put(14, bedopt2r);
                                  copy(bedopt2r,0,0, 123, 90, 579, 363, 123, 90);
                                  PImage bedopt2l=loadImage("bedopt2l.png");
                                    symbols.put(15, bedopt2l);
                                  copy(bedopt2l,0,0, 24, 47, 556, 402, 24, 47);
                          }
                        }
                   if (((String)placed.get(6)=="TRUE")){
                          if(( id!=6)||((tuioObjectList[i].getScreenX(950)>=383||tuioObjectList[i].getScreenY(717)<=303))){
                                  
                                PImage bengcht=loadImage("bencht.png");
                                    symbols.put(11, bengcht);
                                  copy(bengcht,0,0, 41, 23, 195, 400, 41, 23);
                                  PImage bengchm=loadImage("benchm.png");
                                    symbols.put(12, bengchm);
                                  copy(bengchm,0,0, 151, 195, 119, 416, 151, 195);
                                PImage bengchb=loadImage("benchb.png");
                                    symbols.put(13, bengchb);
                                  copy(bengchb,0,0, 28, 22, 145, 605, 28, 22);
                          }
                        }
                   if (((String)placed.get(7)=="TRUE")){
                          if( (id!=7)||((344>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=499)
                                 || (261>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=361))){
                                  
                                PImage potrait1c=loadImage("Portrait1opt2.png");
                                    symbols.put(10, potrait1c);
                                  copy(potrait1c,0,0, 74,50, 396, 275, 74, 50);
                          }
                        }
                    if (((String)placed.get(8)=="TRUE")){
                          if( (id!=8)||((116>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=292)
                                 || (181>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=414))){
                                  
                                PImage potraitc=loadImage("portrait2opt2r.png");
                                    symbols.put(9, potraitc);
                                  copy(potraitc,0,0, 90, 118, 164, 220, 90, 118);
                          }
                        }   
                       
                       
                         
                         }
               // if(x>347 && x<444 && y>251 && y<393){
               // PImage imgs=loadImage("sofa.png");
               // symbols.put(id,imgs);
               //image((PImage)symbols.get(id),0,0);
               //println("YOU ARE HOME "+ id);      
               //      }else{
               //           PImage imgs=loadImage("sofa.png");
               //         symbols.put(id,imgs);
               //image((PImage)symbols.get(id),0,0);
               //println("GO BACK HOME" + id);
              println(opt);
              // }
        
        }else if(opt==2){
              //txt = (String)symbols.get(id);
               println("X = "+tobj.getScreenX(950)+" Y = "+tobj.getScreenY(717));
        
               int x=tuioObjectList[i].getScreenX(950);
               int y=tuioObjectList[i].getScreenY(717);
               int sec= times.timer();
               times.timereset();
              println(sec);
               if (tuioObjectList[i].getSymbolID()==0&&351<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=391
                     && 520<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=560)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(0)=="TRUE")&&((String)rotation.get(0)=="TRUE"))
                  {
                         PImage bed=loadImage("GreenBed.png");
                         symbols.put(0, bed);
                         image((PImage)symbols.get(id),-320,-120);
                       placed.put(0,"TRUE");
                       
                                             if (audio.get(0)!="1"){
                                              click.play(0);
                                              audio.put(0,"1");
                                               }
                   }
                   else if((String)rotation.get(0)=="TRUE"){
                          PImage bed=loadImage("bedopt3.png");
                          symbols.put(0, bed);
                          image((PImage)symbols.get(id),-320,-120); 
                                               }
                   else{  PImage bed=loadImage("Red_Bedopt3.png");
                          symbols.put(0, bed);
                          image((PImage)symbols.get(id),-320,-120);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==0){
                                  PImage bed=loadImage("bedopt3.png");
                                  symbols.put(0, bed);
                                  image((PImage)symbols.get(id),-320,-120);
                                                                }
                          if((tuioObjectList[i].getSymbolID()==0)&&((String)rotation.get(0)=="FALSE")){
                               PImage bed=loadImage("Red_Bedopt3.png");
                               symbols.put(0, bed);
                               image((PImage)symbols.get(id),-320,-120);
                         }  
                         }
               if (tuioObjectList[i].getSymbolID()==1&&148<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=188 
                     && 421<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=461)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(1)=="TRUE")&&((String)rotation.get(1)=="TRUE"))
                  {
                           PImage desktop=loadImage("GreenDeskopt3.png");
                           symbols.put(1, desktop);
                           image((PImage)symbols.get(id),-20,-20);
                           placed.put(1,"TRUE");
                           
                           if (audio.get(1)!="1"){
                                      click.play(0);
                                      audio.put(1,"1");
                                               }
                   }else if((String)rotation.get(1)=="TRUE"){
                                              PImage desktop=loadImage("deskopt3.png");
                                              symbols.put(1, desktop);
                                              image((PImage)symbols.get(id),-20,-20); 
                                               }
                   else{    
                            PImage desktop=loadImage("Red_Deskopt3.png");
                            symbols.put(1, desktop);
                            image((PImage)symbols.get(id),-20,-20);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==1){
                                    PImage desktop=loadImage("deskopt3.png");
                                    symbols.put(1, desktop);
                                    image((PImage)symbols.get(id),-20,-20);
                                                                }
                           if((tuioObjectList[i].getSymbolID()==1)&&((String)rotation.get(1)=="FALSE")){
                               PImage desktop=loadImage("Red_Deskopt3.png");
                               symbols.put(1, desktop);
                               image((PImage)symbols.get(id),-20,-20);
                         }  
                         }
                         
               if (tuioObjectList[i].getSymbolID()==2&&105<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=198 
                     && 421<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=461)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(2)=="TRUE")&&((String)rotation.get(2)=="TRUE"))
                  {
                           PImage lamp=loadImage("GreenLampopt3.png");
                           symbols.put(2, lamp);
                           image((PImage)symbols.get(id),-15,-45);
                           placed.put(2,"TRUE");
                           
                           if (audio.get(2)!="1"){
                                              click.play(0);
                                              audio.put(2,"1");
                                               }
                   }
                   else if((String)rotation.get(2)=="TRUE"){
                            PImage lamp=loadImage("lampop3.png");
                            symbols.put(2, lamp);
                            image((PImage)symbols.get(id),-15,-45); 
                                               }
                   else{    PImage lamp=loadImage("Red_Lampopt3.png");
                            symbols.put(2, lamp);
                            image((PImage)symbols.get(id),-15,-45);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==2){
                                   PImage lamp=loadImage("lampop3.png");
                                   symbols.put(2, lamp);
                                   image((PImage)symbols.get(id),-15,-45);
                                                                }
                           if((tuioObjectList[i].getSymbolID()==2)&&((String)rotation.get(2)=="FALSE")){
                               PImage lamp=loadImage("Red_Lampopt3.png");
                               symbols.put(2, lamp);
                               image((PImage)symbols.get(id),-15,-45);
                         }  
                         }
                         
                if (tuioObjectList[i].getSymbolID()==3&&484<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=524 
                     && 257<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=297)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(3)=="TRUE")&&((String)rotation.get(3)=="TRUE"))
                  {
                           PImage portrait1=loadImage("GreenPortrait1opt3.png");
                           symbols.put(3, portrait1);
                           image((PImage)symbols.get(id),0,-60);
                           placed.put(3,"TRUE");
                           
                           if (audio.get(3)!="1"){
                                              click.play(0);
                                              audio.put(3,"1");
                                               }
                   }
                   else if((String)rotation.get(3)=="TRUE"){
                                              PImage portrait1=loadImage("Portrait1opt3.png");
                                              symbols.put(3, portrait1);
                                              image((PImage)symbols.get(id),0,-60); 
                                               }
                   else{     
                             PImage portrait1=loadImage("Red_Portrait1opt3.png");
                             symbols.put(3, portrait1);
                             image((PImage)symbols.get(id),0,-60);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==3){
                                    PImage portrait1=loadImage("Portrait1opt3.png");
                                    symbols.put(3, portrait1);
                                    image((PImage)symbols.get(id),0,-60);
                                                                }  
                         
                         if((tuioObjectList[i].getSymbolID()==3)&&((String)rotation.get(3)=="FALSE")){
                               PImage portrait1=loadImage("Red_Portrait1opt3.png");
                               symbols.put(3, portrait1);
                               image((PImage)symbols.get(id),0,-60);
                         }
               }
                         
                if (tuioObjectList[i].getSymbolID()==4&&379<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=399 
                     && 255<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=295)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(4)=="TRUE")&&((String)rotation.get(4)=="TRUE"))
                  {
                           PImage portrait2=loadImage("GreenPortrait2opt3.png");
                           symbols.put(4, portrait2);
                           image((PImage)symbols.get(id),-5,-60);
                           placed.put(4,"TRUE");
                           
                           if (audio.get(4)!="1"){
                                              click.play(0);
                                              audio.put(4,"1");
                                               }
                   }
                   else if((String)rotation.get(4)=="TRUE"){
                                              PImage portrait2=loadImage("Portrait2op3.png");
                                              symbols.put(4, portrait2);
                                              image((PImage)symbols.get(id),-5,-60); 
                                               }
                   else{      PImage portrait2=loadImage("Red_Portrait2opt3.png");
                              symbols.put(4, portrait2);
                              image((PImage)symbols.get(id),-5,-60);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==4){
                                     PImage portrait2=loadImage("Portrait2op3.png");
                                     symbols.put(4, portrait2);
                                     image((PImage)symbols.get(id),-5,-60);
                                                                }
                           if((tuioObjectList[i].getSymbolID()==4)&&((String)rotation.get(4)=="FALSE")){
                               PImage portrait2=loadImage("Red_Portrait2opt3.png");
                              symbols.put(4, portrait2);
                              image((PImage)symbols.get(id),-5,-60);
                         }    
                         }         
                if (tuioObjectList[i].getSymbolID()==5&&434<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=474 
                     && 340<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=380)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(5)=="TRUE")&&((String)rotation.get(5)=="TRUE"))
                  {
                           PImage sofa=loadImage("GreenSofaopt3.png");
                           symbols.put(5, sofa);
                           image((PImage)symbols.get(id),-90,-30);
                           placed.put(5,"TRUE");
                           
                           if (audio.get(5)!="1"){
                                              click.play(0);
                                              audio.put(5,"1");
                                               }
                   }
                   else if((String)rotation.get(5)=="TRUE"){
                                              PImage sofa=loadImage("Sofaopt3.png");
                                              symbols.put(5, sofa);
                                              image((PImage)symbols.get(id),-90,-30); 
                                               }
                   else{       PImage sofa=loadImage("Red_Sofaopt3.png");
                               symbols.put(5, sofa);
                               image((PImage)symbols.get(id),-90,-30);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==5){
                                      PImage sofa=loadImage("Sofaopt3.png");
                                      symbols.put(5, sofa);
                                      image((PImage)symbols.get(id),-90,-30);
                                                                }
                           if((tuioObjectList[i].getSymbolID()==5)&&((String)rotation.get(5)=="FALSE")){
                              PImage sofa=loadImage("Red_Sofaopt3.png");
                              symbols.put(5, sofa);
                              image((PImage)symbols.get(id),-90,-30); 
                         }  
                         }    
                    
                if (tuioObjectList[i].getSymbolID()==6&&751<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=791 
                     && 447<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=487)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(6)=="TRUE")&&((String)rotation.get(6)=="TRUE"))
                  {
                            PImage table=loadImage("GreenTableopt3.png");
                            symbols.put(6, table);
                            image((PImage)symbols.get(id),-100,-50);
                           placed.put(6,"TRUE");
                           
                           if (audio.get(6)!="1"){
                                              click.play(0);
                                              audio.put(6,"1");
                                               }
                   }else if((String)rotation.get(6)=="TRUE"){
                                PImage table=loadImage("Tableopt3.png");
                                symbols.put(6, table);
                                image((PImage)symbols.get(id),-100,-50); 
                                               }
                   else{        PImage table=loadImage("Red_Tableopt3.png");
                                symbols.put(6, table);
                                image((PImage)symbols.get(id),-100,-50);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==6){
                                PImage table=loadImage("Tableopt3.png");
                                symbols.put(6, table);
                                image((PImage)symbols.get(id),-100,-50);
                                                                }
                           if((tuioObjectList[i].getSymbolID()==6)&&((String)rotation.get(6)=="FALSE")){
                               PImage table=loadImage("Red_Tableopt3.png");
                               symbols.put(6, table);
                               image((PImage)symbols.get(id),-100,-50);
                         }  
                         }        
                       
               if (tuioObjectList[i].getSymbolID()==7&&226<=tuioObjectList[i].getScreenX(950)&&tuioObjectList[i].getScreenX(950)<=266 
                     && 291<=tuioObjectList[i].getScreenY(717) && tuioObjectList[i].getScreenY(717)<=331)
               {                       
                 times.timercont();
                  if((sec>=2 || (String)placed.get(7)=="TRUE")&&((String)rotation.get(7)=="TRUE"))
                  {
                              PImage wardrobeopt3=loadImage("GreenWardrobeopt3.png");
                              symbols.put(7, wardrobeopt3);
                              image((PImage)symbols.get(id),-60,-120);
                           placed.put(7,"TRUE");
                           
                           if (audio.get(7)!="1"){
                                              click.play(0);
                                              audio.put(7,"1");
                                               }
                   }
                   else if((String)rotation.get(7)=="TRUE"){
                                              PImage wardrobeopt3=loadImage("Wardrobeopt3.png");
                                              symbols.put(7, wardrobeopt3);
                                              image((PImage)symbols.get(id),-60,-120); 
                                               }
                   else{          PImage wardrobeopt3=loadImage("Red_Wardrobeopt3.png");
                                  symbols.put(7, wardrobeopt3);
                                  image((PImage)symbols.get(id),-60,-120);
                }
               }else {
                          if(tuioObjectList[i].getSymbolID()==7){
                                  PImage wardrobeopt3=loadImage("Wardrobeopt3.png");
                                  symbols.put(7, wardrobeopt3);
                                  image((PImage)symbols.get(id),-60,-120);
                                                                }
                          if((tuioObjectList[i].getSymbolID()==7)&&((String)rotation.get(7)=="FALSE")){
                               PImage wardrobeopt3=loadImage("Red_Wardrobeopt3.png");
                               symbols.put(7, wardrobeopt3);
                               image((PImage)symbols.get(id),-60,-120);
                         }  
                         }   
                         

          // To place object if removed   &&((String)rotation.get(0)=="TRUE")
                  if (((String)placed.get(0)=="TRUE")){
                          if( id!=0||((tuioObjectList[i].getScreenX(950)>=750)
                                 || (302>=tuioObjectList[i].getScreenY(717)))){
                                  
                                PImage drawerc=loadImage("bedopt3r.png");
                                    symbols.put(24, drawerc);
                                  copy(drawerc,0,0, 93, 249, 59, 411, 93, 249);
                                  PImage drawert=loadImage("bedopt3t.png");
                                    symbols.put(22, drawert);
                                  copy(drawert,0,0, 268, 118, 152, 530, 268, 118);
                                  PImage drawercm=loadImage("bedopt3a.png");
                                    symbols.put(23, drawercm);
                                  copy(drawercm,0,0, 52, 64, 373, 468, 52, 64);
                          }
                        }
                  if (((String)placed.get(1)=="TRUE")){
                          if( id!=1||((104>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=229)
                                 || (294>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=553))){
                                
                                PImage lampb=loadImage("deskopt3c.png");
                                symbols.put(21, lampb);
                                copy(lampb,0,0,63, 113,150, 424, 63, 113);
                          }
                        }
                  if (((String)placed.get(2)=="TRUE")){
                          if( id!=2||((132>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=218)
                                 || (382>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=490))){
                                  
                                PImage Lamp2opt2c=loadImage("lampopt3c.png");
                                    symbols.put(18, Lamp2opt2c);
                                  copy(Lamp2opt2c,0,0, 43, 44, 155, 389, 43, 46);
                          }
                        }
                  if (((String)placed.get(3)=="TRUE")){
                          if( id!=3||((457>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=549)
                                 || (193>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=339))){
                                  
                                  PImage Portrait1opt3=loadImage("Portrait1opt3.png");
                                  symbols.put(16, Portrait1opt3);
                                  copy(Portrait1opt3,0,0, 47, 61, 505, 215,47, 61);
                          }
                        }
                   
                   if (((String)placed.get(4)=="TRUE")){
                          if( id!=4||((337>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=430)
                                 || (211>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=333))){
                                  
                                PImage Portrait2op3=loadImage("Portrait2op3.png");
                                symbols.put(16, Portrait2op3);
                                 copy(Portrait2op3,0,0, 47, 61, 382, 217,47, 61);
                          }
                   } 
                   if (((String)placed.get(5)=="TRUE")){
                          if(( id!=5)||((235>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=462)
                                 || (267>=tuioObjectList[i].getScreenY(717) || tuioObjectList[i].getScreenY(717)>=447))){
                                  PImage Sofaopt3c=loadImage("Sofaopt3c.png");
                                    symbols.put(15, Sofaopt3c);
                                  copy(Sofaopt3c,0,0, 221, 92, 365, 327, 221, 92);
                          }
                        }
                   if (((String)placed.get(6)=="TRUE")){
                          if(( id!=6)||(132>=tuioObjectList[i].getScreenX(950)||(229>=tuioObjectList[i].getScreenY(717)))){
                                  
                                
                                PImage benchopt3c=loadImage("benchopt3c.png");
                                    symbols.put(13, benchopt3c);
                                  copy(benchopt3c,0,0, 191, 186, 675, 417, 191, 186);
                          }
                        }
                   if (((String)placed.get(7)=="TRUE")){
                          if( (id!=7)||((132>=tuioObjectList[i].getScreenX(950)||tuioObjectList[i].getScreenX(950)>=344)
                                 || (tuioObjectList[i].getScreenY(717)>=620))){
                                  
                                PImage potrait1c=loadImage("wardrobeopt3c.png");
                                    symbols.put(10, potrait1c);
                                  copy(potrait1c,0,0, 93,315, 197, 190, 93, 315);
                          }
                        }                         
               // if(x>347 && x<444 && y>251 && y<393){
               // PImage imgs=loadImage("sofa.png");
               // symbols.put(id,imgs);
               //image((PImage)symbols.get(id),0,0);
               //println("YOU ARE HOME "+ id);      
               //      }else{
               //           PImage imgs=loadImage("sofa.png");
               //         symbols.put(id,imgs);
               
               //image((PImage)symbols.get(id),0,0);
               //println("GO BACK HOME" + id);
               println(opt);
              // }
        
        }
    } 
    //else  { // otherwise, we'll just display the id numberif(symbols.get(id))
     // txt = ""+id+".";
   // }
   //text(txt, tobj.getScreenX(width)-txtSize/6, tobj.getScreenY(height)+txtSize/4);
   popMatrix();
   if(opt==0||opt==2){
   if(((String)placed.get(0)=="TRUE")&&((String)placed.get(1)=="TRUE")&&((String)placed.get(2)=="TRUE")&&((String)placed.get(3)=="TRUE")&&
                        ((String)placed.get(4)=="TRUE")&&((String)placed.get(5)=="TRUE")&&((String)placed.get(6)=="TRUE")&&((String)placed.get(7)=="TRUE")){
                                   player[r].pause();
                                   welldone.play();
                                   symbols.clear();
                                   PImage welldonepix=loadImage("well done.JPG");
                                   background(welldonepix);
                                   if (welldone.position()>=8000){
                                       welldone.pause();
                                       welldone.setGain(-50);
                                   }
                        }
   }else if(opt==1){
                 if(((String)placed.get(0)=="TRUE")&&((String)placed.get(1)=="TRUE")&&((String)placed.get(2)=="TRUE")&&((String)placed.get(3)=="TRUE")&&
                        ((String)placed.get(4)=="TRUE")&&((String)placed.get(5)=="TRUE")&&((String)placed.get(6)=="TRUE")&&((String)placed.get(7)=="TRUE")&&((String)placed.get(8)=="TRUE")){
                                   player[r].pause();
                                   welldone.play();
                                   symbols.clear();
                                   PImage welldonepix=loadImage("well done.JPG");
                                   background(welldonepix);
                                   if (welldone.position()>=8000){
                                       welldone.pause();
                                       welldone.setGain(-50);
                                       
                                   }
                        }
   }
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

/* TIMER
  Written by AdamTheNoob from Processing Forum
  http://processing.org/discourse/yabb2/YaBB.pl?num=1245105034
*/
/*
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
*/
// these callback methods are called whenever a TUIO event occurs

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
