package
{
	//Class générale pour les vaisseaux ennemis
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
 
	public class Falchion extends MovieClip
	{
 
		private var stageRef:Stage;
		private var vitesse:Number = 5; //y velocity
		private var cible:Vaisseau;
		private var tir:Boolean=true;
		private var Auth_Tir:Boolean=true;
		private var Delai:Timer; 
		private var Delai_Tir:Timer; 
		public var Mort:Boolean=false;
		public var points:Number = 50;
		public var score:Number;
		public static var compte:Number=0;
		
		//Constructeur
		public function Falchion(stageRef:Stage, cible:Vaisseau) : void
		{
			this.stageRef = stageRef;
			this.cible = cible;
 			gotoAndStop(1);
			
			y = Math.random() * stageRef.stageHeight;
			x = stageRef.stageWidth+30;
			
			Delai = new Timer(130, 1);
			Delai.addEventListener(TimerEvent.TIMER, DelaiHandler, false, 0, true);
			Delai_Tir = new Timer(300, 1);
			Delai_Tir.addEventListener(TimerEvent.TIMER, Delai_TirHandler, false, 0, true);
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		//Fonction loop qui gère le mouvement, et les tirs
		private function loop(e:Event) : void
		{
			if (Moteur.pause==false){//vitesse += acceleration;
				x = x- vitesse;
				if (x == -50)
					detruire();
				//score=Moteur.Nb_Points.points;
				//if (game_over==false){
				if ((Math.floor(Math.random() * 30) == 5)&&(Auth_Tir)){
						Tirer();
						Auth_Tir=false;
						Delai_Tir.start();
				}
			}
		}
		
		//Fonction detruire qui supprime la boucle et remove l'objet du stage
		private function detruire() : void {

			
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
		}
		
		
		//Fonction de tir du vaisseau ennemi
		private function Tirer() : void
		{
			if (tir=true)
				stageRef.addChild(new Missile_F(stageRef, cible, x, y, 10));
		}
		
		//Fonction d'un vaisseau touché, qui meurt
		public function touche() :void
		{
			dispatchEvent(new Event("meurt"))
			tir=false;
			Mort=true;
			gotoAndPlay(2);
			Moteur.Sounds.jouer_mort_falchion();
			compte +=1;
			trace(compte);
			if (compte==10){
				stageRef.addChild(new Up_Green(stageRef,cible,x,y));
				compte=0;
			}
			Delai.start();
		}
		
		//fonction de délai pour l'animation
 		private function DelaiHandler(e:TimerEvent) : void
		{
			tir=true;
			Mort=false;
			detruire();
		}
		
		//Fonction de délai pour le tir (Eviter que 2 tirs se suivent )
		private function Delai_TirHandler(e:TimerEvent) : void
		{
			Auth_Tir=true;
		}
	}
 
}