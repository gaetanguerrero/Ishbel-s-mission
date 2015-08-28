package  {
	
	//Classe de la gestion de la barre de vie du vaisseau
	import flash.display.MovieClip;
	
	
	public class HpBar extends MovieClip {
	private var effet:Boolean;
	
		//Constructeur
		public function HpBar() {

			gotoAndStop("default");
			effet=false;
		}
		
		//Fonction de remise au départ 
		public function reset(){
			gotoAndStop("default");
			effet=false;
		}
		
		//fonction qui descend la barre de vie a 75%
		public function Barre_75(){
			if (currentLabel != "vie_75"&&currentLabel != "vie_50"){
				gotoAndPlay("vie_75");
			}
			if(currentLabel == "vie_50")
				gotoAndStop(9);
			
		}
		
		//fonction qui descend la barre de vie a 50%
		public function Barre_50(){
			if (currentFrame ==9 &&currentLabel != "vie_25"){
				gotoAndPlay("vie_50");
			}
			if(currentLabel == "vie_25")
				gotoAndStop(16);
		}
		
		//fonction qui descend la barre de vie a 25%
		public function Barre_25(){
			if (currentFrame ==16 &&currentLabel != "vie_5"){
				gotoAndPlay("vie_25");
			}
			if(currentLabel == "vie_5")
				gotoAndStop(23);
		}
		
		//fonction qui descend la barre de vie a 5%
		public function Barre_5(){
			if (currentFrame ==23 &&currentLabel != "vie_0"){
				gotoAndPlay("vie_5");
			}
			if(currentLabel == "vie_0")
				gotoAndStop(30);
			
			
		}
		
		//fonction qui remonte la barre de vie a 0%
		public function Barre_0(){
			gotoAndStop(31);
			
		}
		
		//fonction qui remonte la barre de vie a 75%
		public function Barre_To_75(){
			gotoAndStop(9);
		}
		
		//fonction qui remonte la barre de vie a 50%
		public function Barre_To_50(){
			gotoAndStop(16);
		}
		
		//fonction qui remonte la barre de vie a 25%
		public function Barre_To_25(){
			gotoAndStop(23);
		}
		
		//fonction qui remonte la barre de vie a 100%
		public function Barre_To_100(){
			gotoAndStop(1);
			
		}
		
	}
	
}
