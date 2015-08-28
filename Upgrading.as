package  {
	
		import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.filters.*;
	
	public class Upgrading extends MovieClip {
		private var stageRef:Stage;
		private var Lueur:GlowFilter = new GlowFilter(); 
		public function Upgrading(stageRef:Stage, type:String) {
			this.stageRef = stageRef;
			
			Lueur.inner=false; 
			Lueur.blurX = 5; 
			Lueur.blurY = 5;
			gotoAndPlay(1);
			
			switch(type)
				{
				 case "Green":
				 x=200;
				 y=380;
				 affichage.text = "Life";
				 Lueur.color = 0x00FF00;
				 affichage.filters=[Lueur]
				 break;
				 case "Red":
				 x=100;
				 y=380;
				 affichage.text ="BOMB";
				 Lueur.color = 0xFF0000;
				 affichage.filters=[Lueur]
				 break;
				 case "Gray":
				 x=300;
				 y=380;
				 affichage.text = "Shield";
				 Lueur.color = 0xFFFFFF;
				 affichage.filters=[Lueur]
				 break;
				}
		}
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		public function supprimer() : void
		{
			this.parent.removeChild(this);
		}
	}
	
}
