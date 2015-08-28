package  {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	
	public class Up_Red extends MovieClip {
		private var stageRef:Stage;
		private var cible:Vaisseau;
		private var used:Boolean =false;
 
		private var vitesse:Number;
		
		// Constructeur
		public function Up_Red(stageRef:Stage, cible:Vaisseau) {
			this.stageRef = stageRef;
			this.cible = cible;
			this.x = stageRef.stageWidth+10;
			this.y = Math.floor(Math.random() * 370)+10;
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
					cible.upgrade_red();
	
	
				}
			}
			else
				stop();
		}
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		public function supprimer() : void
		{
			used=true;
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
			
		}
	}
	
}