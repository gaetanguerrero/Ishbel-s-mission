package
{
	//Classe Etoile qui gère les étoiles du fond d'écran
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Etoile extends MovieClip
	{
 
		private var stageRef:Stage;
		private var vitesse:Number;
		private var couleur:Number = 0;
		private var echelle:Number;
 
		//Construteur
		public function Etoile(stageRef:Stage)
		{
			this.stageRef = stageRef;
			Generation_Etoile(true);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		//Fonction de generation des étoiles pour le fond d'écran
		public function Generation_Etoile(randomizeX:Boolean = false) : void
		{
			if (Moteur.game_over==false){
				//On gère la couleur, la taille et la vitesse de l'étoile aléatoirement
				couleur=Math.floor(Math.random() * 3 + 1);
				gotoAndStop(couleur);
				x = randomizeX ? Math.random()*stageRef.stageWidth : stageRef.stageWidth;
				y = Math.random()*stageRef.stageHeight;
				alpha = Math.random();
				echelle=Math.random();
				scaleX = echelle;
				scaleY = echelle;
				vitesse = 2 + Math.random()*2;
		}
		}
		//Fonction loop qui gère le déplacement des étoiles dans le stage
		public function loop(e:Event) : void
		{
			if (Moteur.pause==false){
				x = x-vitesse;
	 
				if (x < 0)
					Generation_Etoile();
			}
 
		}
 
	}
}