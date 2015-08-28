package  {
	//Classe qui gère les genades
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class Grenade_1 extends MovieClip {
		
		private var LB:Vaisseau;
		private var speed:Number=2;
		public var explosion:Boolean=false;

		//Constructeur
		public function Grenade_1(LB:Vaisseau) {
			this.LB = LB;
			x = LB.x;
			y = LB.y;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);

			// Lecture du son et stockage dans le canal
		}
		
		//Fonction boucle qui gère le mouvement et la destruction des ennemis et astéroides
		public function loop(e:Event) : void{	
			if (Moteur.pause==false){
						play();
						this.x +=speed;
						if (currentLabel=='end'){
							Moteur.Sounds.jouer_grenade();
							for (var i:int = 0; i < Moteur.ennemis.length; i++){
								Moteur.ennemis[i].touche();
							}
							for (var j:int = 0; j < Moteur.asteroides.length; j++){
								Moteur.asteroides[j].touche(5);
							}
							supprimer()
						}
					}
					else
							stop();
		}
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		private function supprimer():void{
			removeEventListener(Event.ENTER_FRAME, loop);
			this.parent.removeChild(this);
			

		}
	}

}
	