package  {
	
	//Classe qui gère l'affichage de start au début du jeu
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	
	public class Start extends MovieClip {
		private var stageRef:Stage;
		
		//Constructeur
		public function Start(stageRef:Stage) {
			this.stageRef = stageRef;
			x = stageRef.stageWidth/2;
			y = stageRef.stageHeight/2;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		//Fonction qui gère l'animation
		public function loop(e:Event) : void
		{
			if (currentLabel== "end"){
				stop();
				supprimer();
			}
			
				
		}
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		private function supprimer() : void {
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
		}
	}
	
}
