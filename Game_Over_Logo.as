package  {

	//Classe du Logo de Game Over
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	
	public class Game_Over_Logo extends MovieClip {
		private var stageRef:Stage;
		
		//Constructeur
		public function Game_Over_Logo(stageRef:Stage) {
			this.stageRef = stageRef;
			x = stageRef.width/2;
			y = stageRef.height/2;
			
			
		}

	}
	
}
