package  {
	// Classe du texte pour gerer le nombre de boucliers
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class Compteur_Bouclier extends MovieClip {
		private var stageRef:Stage;
		public var points:Number = 5;
		
		//Constructeur
		public function Compteur_Bouclier(stageRef:Stage) {
			this.stageRef = stageRef;
			affichage.text = "5";
			x = 21;
			y = 342;
		}
		//Fonction de changement du texte du nb de boucliers
		public function Compteur(value:Number) : void
		{
			points = value;
			affichage.text = String(points);
		}
	}
	
}
