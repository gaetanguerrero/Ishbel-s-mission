package  {

	//Classe pour l'animation de l'introduction
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	public class Introduction extends MovieClip {
	
		private var stageRef:Stage;
		private var fini:Boolean=false;
		
		//Constructeur
		public function Introduction(stageRef:Stage) {
			
			this.stageRef = stageRef;
			x = stageRef.stageWidth/2;
			y = stageRef.stageHeight/2;
			Moteur.Sounds.jouer_intro();
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		//Fonction loop qui gère la lecture et l'arrêt de l'animation
		public function loop(e:Event) : void
		{	
			if (currentLabel== "end"){
				fini=true;
				Moteur.debut_intro=true;
				stop();
				supprimer();
			}
				
		}
		
		//Fonction qui renvoie la variable fini
		public function getFini():Boolean
		{
			return fini;
		}
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		public function supprimer() : void {

			
			removeEventListener(Event.ENTER_FRAME, loop);

			if (stageRef.contains(this))
				stageRef.removeChild(this);
			
		}
	}
	
}