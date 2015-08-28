package
{
	//Classe des Asteroïdes
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.filters.*;
 
	public class Asteroide_M extends MovieClip
	{
 
		private var stageRef:Stage;
		private var vitesse:Number = 3; //y velocity
		private var cible:Vaisseau;
		private var Delai:Timer; 
		public var Mort:Boolean=false;
		public var points:Number;
		private var vie:Number;
		public var score:Number;
		private var taille:Number = 0;
		public static var compte:Number=0;
		private var Lueur:GlowFilter = new GlowFilter(); 
		
		//Fonction Constructeur
		public function Asteroide_M(stageRef:Stage, cible:Vaisseau) : void
		{
			this.stageRef = stageRef;
			this.cible = cible;
			taille=Math.floor(Math.random() * 3 + 1);
			gotoAndStop(taille);
			//On choisit aléatoirement une taille d'asteroïde
			switch(taille){
				 case 1:
				 vie=3;
				 points=15;
				 break;
				 case 3:
				 vie=4;
				  points=20;
				 break;
				 case 2:
				 vie=5;
				 points=25;
				 break;
			}
			y = Math.random() * stageRef.stageHeight;
			x = stageRef.stageWidth+50;
			
			Lueur.inner=true; 
			Lueur.color = 0xFF0000; 
			Lueur.blurX = 10; 
			Lueur.blurY = 10;
			
			Delai = new Timer(130, 1);
			Delai.addEventListener(TimerEvent.TIMER, DelaiHandler, false, 0, true);
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 
		//Fonction Loop qui definit le déplacement et si l'asteroïde est touché, ou sort du cadre, et son niveau de vie est indiqué par un glow 
		private function loop(e:Event) : void
		{	
			if (Moteur.pause==false){
				x = x- vitesse;
				this.rotation-=0.45
				
						
				if ((hitTestObject(cible.hit))&&(cible.getInvincible()==false)&&(Mort==false)&&(!Moteur.game_over))
				{
					stageRef.addChild(new Explosion_LB(stageRef, x, y));
					vie=0
					cible.touched();
					touche(0);
				}
				
				if (x == -50)
					detruire();
				
				if ( x < 0)
						detruire();
				switch(vie)
					{
					 case 2:
					 this.filters=[Lueur];
					 break;
					 case 1:
					 Lueur.blurX = 20; 
					 Lueur.blurY = 20;
					 this.filters=[Lueur];
					 break;
					 case 0:
					 this.filters=[];
					 break;
					}
			}
		}
		//fonction de destruction, et de libération de mémoire
		private function detruire() : void {

			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
			
		}

		//Fonction qui gère si l'astéroide a été touché par un missile du vaisseau
		public function touche(degats:Number) :void
		{	vie-=degats;
			if (vie<=0)
			{	
			 this.filters=[];
				dispatchEvent(new Event("detruit"))
				Mort=true;
				gotoAndPlay(5);
				Moteur.Sounds.jouer_mort_asteroide();
				Delai.start();
			}
		}
		//Fonction de Délai pour la mort de l'astéroide
 		private function DelaiHandler(e:TimerEvent) : void
		{
			Mort=false;
			detruire();
		}
	}
 
}