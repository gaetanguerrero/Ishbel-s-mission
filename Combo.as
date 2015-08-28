package  {
	//Classe du texte de combo, pour le multiplicateur de points
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	
	
	public class Combo extends MovieClip {
		private var stageRef:Stage;
		public var points:Number = 0;
		
		//Fonction Constructeur
		public function Combo(stageRef:Stage)
		{ 
			this.stageRef = stageRef;
			affichage.text = "x1";
			x = 680;
			y = 365;
 
		}
		//Fonction de changement du texte de combo
		public function changement(combo:Number) : void
		{
			affichage.text = "x"+ combo.toFixed(1);
			points=combo;
		}
		
		
		
	}
	
}