package
{
	//Classe qui gère les missiles lasers bleus
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class Missile_Laser extends MovieClip
	{
 
		private var stageRef:Stage;
		private var vitesse:Number = 12;
 
		//Constructeur
		public function Missile_Laser (stageRef:Stage, x:Number, y:Number) : void
		{
			this.stageRef = stageRef;
			this.x = x+50;
			this.y = y+10;
 			Moteur.Sounds.jouer_missile_l();
 
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
	
		//Fonction loop qui gère le déplacement, et la rencontre avec un ennemi/asteroide
		private function loop(e:Event) : void
		{
			if (Moteur.pause==false){//move bullet up
				x += vitesse;
	 
				
				for (var i:int = 0; i < Moteur.ennemis.length; i++)
				{
					if ((hitTestObject(Moteur.ennemis[i].hit))&&(Moteur.ennemis[i].Mort==false))
						{
							Moteur.ennemis[i].touche();
							supprimer();
						}
				}
				for (var j:int = 0; j < Moteur.asteroides.length; j++)
				{
					if ((hitTestObject(Moteur.asteroides[j].hit))&&(Moteur.asteroides[j].Mort==false))
						{
							Moteur.asteroides[j].touche(2);
							supprimer();
						}
				}
				
				if (x > 800){
					supprimer();
				}
			}
		}
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		private function supprimer() : void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
		}
 
	}
 
}