package  {

	//Classe qui gère le menu 
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.MouseCursor;
	import flash.ui.Mouse;
	
	
	public class Menu_Principal extends MovieClip {
		private var stageRef:Stage;
		private var commencer:Commencer=new Commencer();
		private var how:how_to_play=new how_to_play();
		private var cred:credits=new credits();
		private var menu_how:Menu_HTP=new Menu_HTP();
		private var menu_cred:Menu_CREDITS=new Menu_CREDITS();
		private var sub_menu:Boolean=false;
		private var sub_menu_htp:Boolean=false;
		private var sub_menu_cred:Boolean=false;
		
		//Constructeur
		public function Menu_Principal(stageRef:Stage) {
			this.stageRef = stageRef;			
			x = stageRef.stageWidth/2;
			y = stageRef.stageHeight/2;
			Moteur.Sounds.jouer_menu_princ();
			addEventListener(MouseEvent.MOUSE_DOWN , click_menu);
		}
		
		//Fonction qui gère le click souris au sein du menu
		public function click_menu(e:MouseEvent){
			trace(sub_menu);
			if(sub_menu==true){
				if(sub_menu_htp==true){
					trace('lol')
					if(menu_how.hitTestObject(menu_how.hit)){
						trace('lolclikc');
						sub_menu=false;
						sub_menu_htp=false;
						supprimer_htp();
					}
				}
				if(sub_menu_cred==true){
					trace('lol')
					if(menu_cred.hitTestObject(menu_how.hit)){
						trace('lolclikc');
						sub_menu=false;
						sub_menu_cred=false;
						supprimer_cred();
					}
				}
			}
			else{
				if (commencer.hitTestPoint(mouseX,mouseY)){	
					Moteur.fin_menu=true;
					supprimer();
				}
				if (how.hitTestPoint(mouseX,mouseY)){
					sub_menu=true;
					sub_menu_htp=true;
					this.addChild(menu_how);
					
				}
				if (cred.hitTestPoint(mouseX,mouseY)){	
					sub_menu=true;
					sub_menu_cred=true;
					this.addChild(menu_cred);
				}
				
			}
					
		}
		
		/*public function ajout_boutons(){

		}*/
		
		//Fonction supprimer qui supprime la boucle et remove l'objet du stage
		public function supprimer() : void {
			Moteur.Sounds.stop_menu_princ();
			
			removeEventListener(MouseEvent.MOUSE_DOWN , click_menu);

			this.parent.removeChild(this);
			
		}
		
		//Fonction qui retire le menu how to play pour revenir au menu principal
		public function supprimer_htp() : void {
			this.removeChild(menu_how);
			
		}
		//Fonction qui retire le menu credits pour revenir au menu principal
		public function supprimer_cred() : void {
			this.removeChild(menu_cred);
			
		}
	
	}
}
