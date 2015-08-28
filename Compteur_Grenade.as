package  {
	// Classe du texte pour gerer le nombre de grenades
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class Compteur_Grenade extends MovieClip {
		private var stageRef:Stage;
		public var points:Number = 3;
		
		public function Compteur_Grenade(stageRef:Stage) {
			this.stageRef = stageRef;
			affichage.text = "3";
			x = 21;
			y = 380;
		}
		
		public function Compteur(value:Number) : void
		{
			points = value;
			affichage.text = String(points);
		}
	}
	
}
