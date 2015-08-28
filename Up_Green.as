package
{
 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class Up_Green extends MovieClip
	{
		private var stageRef:Stage;
		private var cible:Vaisseau;
		private var vitesse:Number;
		private var used:Boolean =false;
 
		// Constructeur
		public function  Up_Green(stageRef:Stage, cible:Vaisseau, x:Number, y:Number) : void
		{
			this.stageRef = stageRef;
			this.cible = cible;
			this.x = x;
			this.y = y;
			vitesse=2;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
 		
		//Boucle qui gère le mouvement et si l'upgrade est touchée par le vaisseau
		private function loop(e:Event) : void
		{
			if (Moteur.pause==false){
				play();
				x -= vitesse;
	 
				if (x < 0)
					supprimer();
					
				if ((hitTestObject(cible.hit))&&(used==false))
				{
					supprimer();
					cible.upgrade_green();
	
	
				}
			}
			else
				stop();
		}
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		public function supprimer() : void
		{	used=true;
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
			
		}
 
	}
}