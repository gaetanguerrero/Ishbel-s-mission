package  {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	
	
	public class Score extends MovieClip {
		private var stageRef:Stage;
		public var points:Number = 0;
		
		//Constructeur
		public function Score(stageRef:Stage)
		{ 
			this.stageRef = stageRef;
			affichage.text = "0";
			x = 740;
			y = 400;
 
		}
		
		//Fonction qui compte le score du joueur
		public function Compte(value:Number,combo:Number) : void
		{
			points += value*(combo);
			affichage.text = String(points);
		}
		
	}
	
}
