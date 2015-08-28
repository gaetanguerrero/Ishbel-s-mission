package 
{
	//Classe qui gère l'explosion quand le vaisseau est touché
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class Explosion_LB extends MovieClip
	{
		private var stageRef:Stage;
 
		//Constructeur
		public function Explosion_LB(stageRef:Stage, x:Number, y:Number)
		{
			this.stageRef = stageRef;
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);

		}
		//Loop qui gère l'animation
		private function loop(e:Event)
		{
			if (currentFrame == totalFrames){
				Moteur.Sounds.jouer_explosion_lb();
				supprimer();
			}
		}
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		private function supprimer() : void
		{	
			
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
		}
 
	}
 
}