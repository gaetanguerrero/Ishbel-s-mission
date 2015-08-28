package
{
	//Classe qui gère les missiles ennemis
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

 
	public class Missile_F extends MovieClip
	{
 
		private var stageRef:Stage;
		private var cible:Vaisseau; 
		private var vitesse:Number;
 
		//Constructeur
		public function Missile_F(stageRef:Stage, cible:Vaisseau, x:Number, y:Number, vitesse:Number) : void
		{
			this.stageRef = stageRef;
			this.cible = cible;
			this.x = x-20;
			this.y = y;
			this.vitesse = vitesse;
			Moteur.Sounds.jouer_missile_f();
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 
		// Fonction loop qui gère le déplacement et si le missile ennemi touche le vaisseau
		private function loop(e:Event) : void
		{
			if (Moteur.pause==false){
				x -= vitesse;
	 
				if (x > stageRef.stageWidth || x < 0)
					supprimer();
					
				if ((hitTestObject(cible.hit))&&(cible.getInvincible()==false))
				{
					trace("hitME");
					stageRef.addChild(new Explosion_LB(stageRef, x, y));
					supprimer();
					cible.touched();	
				}
			}
		}
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		public function supprimer() : void
		{
			removeEventListener(Event.ENTER_FRAME, loop)
			this.parent.removeChild(this);
		}
 
	}
 
}