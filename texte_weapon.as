package  {
	
	//Classe qui gère le texte et les munitions du vaisseau
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class texte_weapon extends MovieClip {
		private var stageRef:Stage;
		public var points:Number = 5;
		public var texte:String ="Normal";
		
		//Constructeur
		public function texte_weapon(stageRef:Stage) {
			this.stageRef = stageRef;
			weapon.text = "Normal";
			ammo.text = "Infinite";
			x = 670;
			y = 20;
		}
		
		//Fonction qui change le texte (pour savoir quelle arme est utilisée)
		public function Change_Text(value:String) : void{	
		switch(value){
			 case "Normal":
			 weapon.textColor=0xFFFFFF
			 break;
			 case "Laser":
			 weapon.textColor=0x00FFFF
			 break;
			 case "Missile":
			  weapon.textColor=0xFFFF00
			 break;
			}
			texte = value;
			weapon.text = texte ;
		}
		
		//Fonction qui change les munitions
		public function Change_ammo(value:int) : void
		{
			if (texte!="Normal") {
				points = value;
				ammo.text = "x"+ String(points);
			}
			else{
				ammo.text = "Infinite";
			}
		}
	}
	
}
