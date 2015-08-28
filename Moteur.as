package  {

	//Classe main, le moteur du jeu
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.ui.MouseCursor;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	
	public class Moteur extends MovieClip  {
		//Variables pour le fond et les ennemis
		private var nbetoiles:int = 60;
		public static var ennemis:Array = new Array();
		public static var asteroides:Array = new Array();
		
		//Variables des objets appelés
		private var LordBritish:Vaisseau;
		private var Barre_Vie:HpBar;
		private var Seq_Intro:Introduction;
		private var start_logo:Start;
		private var Nb_Points:Score;
		private var Nb_Combo:Combo;
		private var Nb_Grenades:Compteur_Grenade;
		private var Nb_Boucliers:Compteur_Bouclier;
		private var menu_1:Menu_Principal;
		private var GO_LOGO:Game_Over_Logo;
				
		//Variables statiques, utilisées par les classes appelées par le main
		public static var game_over:Boolean;
		public static var pause:Boolean;
		public static var fin_menu:Boolean;
		public static var debut_intro:Boolean=false;
		
		//variables pour la gestion de sons
		public static var Sounds:Sons = new Sons();
		private var conteneurSon:Sound = new Sound();
		private var conteneurSon_GO:Sound = new Sound();
		
		//Varaibles pour gestion des passages
		private var compteur_rejouer=0;
		private var rejouer:Boolean;
		private var signal:String;
		private var score_final:int;
		private var pausePosition:int
		private var combo:Number;
		private var debut_jeu:Boolean=false;

		//Variables de récupération des données du vaisseau
		private var Vie_LB:int;
		private var Grenades_LB:int;
		private var Boucliers_LB:int;
		
		//Constructeur, qui gère le menu principal et le passage à l'intro
		public function Moteur() {
				menu_1=new Menu_Principal(stage);
				stage.addChild(menu_1);
				addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
				game_over=false;
				gotoAndStop(1);
		}
		
		//Fonction loop principale :
		//Elle gère la pause, l'apparation des ennemis et des astéroides, le passage de l'intro au jeu en lui-même
		//Il gère aussi le score, les combos, le game over, la barre de vie, l'apparition des upgrades
		private function loop(e:Event) : void
		{
			if (game_over==false){
				rejouer=false;
				if((fin_menu)&&(!debut_intro)&&(!Seq_Intro)){
					introduction_debut();
				}
				if ((Seq_Intro)&&(Seq_Intro.getFini()==true)&&(!debut_jeu)){
					Seq_Intro.supprimer();
					init();
				}
				if (debut_jeu){
					Vie_LB=LordBritish.getVie();
					Grenades_LB=LordBritish.getGrenades();
					Nb_Grenades.Compteur(Grenades_LB);
					Boucliers_LB=LordBritish.getBoucliers();
					Nb_Boucliers.Compteur(Boucliers_LB);
					if( Nb_Combo.points==1)
						combo=1
					if (Moteur.pause==false){
						if (Math.floor(Math.random() * 650) == 5){ 
							var upgrade_gray:Up_Gray = new Up_Gray(stage,LordBritish);
							stage.addChild(upgrade_gray);
						}
						if (Math.floor(Math.random() * 650) == 5){ 
						    var upgrade_blue:Up_Blue = new Up_Blue(stage,LordBritish);
							stage.addChild(upgrade_blue);
						}
						if (Math.floor(Math.random() * 650) == 5){ 
						    var upgrade_yellow:Up_Yellow = new Up_Yellow(stage,LordBritish);
							stage.addChild(upgrade_yellow);
						}	
						if (Math.floor(Math.random() * 650) == 5){ 
						    var upgrade_red:Up_Red = new Up_Red(stage,LordBritish);
							stage.addChild(upgrade_red);
						}	
						if (Math.floor(Math.random() * 100) == 5){ 
							var ennemi:Falchion = new Falchion(stage, LordBritish);
							ennemi.addEventListener(Event.REMOVED_FROM_STAGE, ennemi_retire, false, 0, true);
							ennemi.addEventListener("meurt", ennemi_detruit, false, 0, true);
							ennemis.push(ennemi);
							stage.addChild(ennemi);
	
						}
						if (Math.floor(Math.random() * 100) == 5)
						{
							var asteroide:Asteroide_M = new Asteroide_M(stage, LordBritish);
							asteroide.addEventListener(Event.REMOVED_FROM_STAGE, asteroide_retire, false, 0, true);
							asteroide.addEventListener("detruit", asteroide_detruit, false, 0, true);
							asteroides.push(asteroide);
							stage.addChild(asteroide);

							}
						}
						if (LordBritish.getSignal()=="Vie Up"){
								if (Vie_LB==5){
									Barre_Vie.Barre_To_100();
									LordBritish.Change_Signal("Vide");
								}
								if (Vie_LB==4){
									Barre_Vie.Barre_To_75();
									LordBritish.Change_Signal("Vide");
								}
								if (Vie_LB==3){
									Barre_Vie.Barre_To_50();
									LordBritish.Change_Signal("Vide");
								}
									
								if (Vie_LB==2){
									Barre_Vie.Barre_To_25();
									LordBritish.Change_Signal("Vide");
								}
								
						}
						if (Vie_LB==4){
							Barre_Vie.Barre_75();
						}
						if (Vie_LB==3){
							Barre_Vie.Barre_50();
						}
						if (Vie_LB==2){
							Barre_Vie.Barre_25();
						}
						if (Vie_LB==1){
							Barre_Vie.Barre_5();
						}
						if (Vie_LB==0){
							Barre_Vie.Barre_0();
							Game_Over();
							stage.addEventListener(MouseEvent.MOUSE_DOWN , click_rejouer);
						}
					}
				
			}
		}
		
		//Fonction clavier, pour gerer la pause
		private function keyDownHandler(e:KeyboardEvent):void{
			if(game_over==false){
				if (e.keyCode==80){
					if (pause==false){
						pause=true;
						pausePosition= Sounds.return_position();
						trace(pausePosition);
						Sounds.stop_bg_music();
						
					}
					else{
						pause=false;
						Sounds.pause_bg_music(pausePosition);
					}
				}
			}
			else{
				if (e.keyCode==82){
					rejouer=true;
					game_over=false;
					demarrer();
				}
			}
			
		}
		
		//Ennemis qu'on retire de la liste des ennemis
		private function ennemi_retire(e:Event){
			ennemis.splice(ennemis.indexOf(e.currentTarget), 1);
		}
		
		//Fonction quand un ennemi est detruit
		private function ennemi_detruit(e:Event) : void{	
			combo +=0.2;
			Nb_Combo.changement(combo);
			Nb_Points.Compte(e.currentTarget.points,combo); 
		}
		
		//Asteroide qu'on retire de la liste des asteroides
		private function asteroide_retire(e:Event){
			asteroides.splice(asteroides.indexOf(e.currentTarget), 1);
		}
		
		//Fonction quand un asteroide est detruit
		private function asteroide_detruit(e:Event) : void{
			Nb_Points.Compte(e.currentTarget.points,combo); 
		}
		
		// Fonction de game over : on retire des elements, on coupe le loop, et on fait apparaitre des objets pour le game over
		private function Game_Over(){
			Sounds.stop_bg_music()
			Sounds.jouer_game_over();
			game_over=true;
			fond_hud.alpha=0;
			stage.removeChild(LordBritish);
			LordBritish=null;
			stage.removeChild(Barre_Vie);
			stage.removeChild(Nb_Points);
			stage.removeChild(Nb_Grenades);
			stage.removeChild(Nb_Boucliers);
			stage.removeChild(Nb_Combo);
			stage.addChild(GO_LOGO);	
			score_final=Nb_Points.points
			GO_LOGO.score.text = "score :" + String(score_final);
			removeEventListener(Event.ENTER_FRAME, loop);
		}
		
		//Fonction qui gère la souris durant le game over
		public function click_rejouer(e:MouseEvent){
			compteur_rejouer++;
			Sounds.stop_game_over();
			game_over=false;
			fond_hud.alpha=0.5;
			stage.removeChild(GO_LOGO);
			rejouer_init();
		}
		
		//Fonction qui reset le combo
		public function change_combo(){
			combo=1;
			Nb_Combo.changement(1);
		}
		
		//fonction qui gère les étoiles du fond 
		private function background(){
			if (game_over==false){
				if(compteur_rejouer==0){
					for (var i:int = 0; i < nbetoiles; i++)
					{
						stage.addChildAt(new Etoile(stage), stage.getChildIndex(LordBritish));
					}
				}
				addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			}
		}
		
		//Fonction d'initialisation des objets
		private function init(){
			Nb_Combo = new Combo(stage); 
			LordBritish = new Vaisseau(stage,Nb_Combo);
			fond_hud.alpha=0.5;
			Barre_Vie = new HpBar();
			LordBritish.x = stage.stageWidth / 2;
			LordBritish.y = stage.stageHeight / 2;
			Nb_Points = new Score(stage); 
			Nb_Grenades = new Compteur_Grenade(stage); 
			Nb_Boucliers = new Compteur_Bouclier(stage); 
			start_logo=new Start(stage);
			GO_LOGO= new Game_Over_Logo(stage);
			demarrer();
		}
		
		// Fonction d'ajout des objets au stage
		private function demarrer(){
			Sounds.jouer_bg_music();
			stage.addChild(Nb_Combo);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler,false,0,true);
			stage.addChild(LordBritish);
			stage.addChild(start_logo);
			stage.addChild(Barre_Vie);
			Barre_Vie.x = 20;
			Barre_Vie.y = 153;
			background();
			combo=1;
			stage.addChild(Nb_Points);
			stage.addChild(Nb_Grenades); 
			stage.addChild(Nb_Boucliers); 
			debut_jeu=true;
			
		}
		
		//Fonction combinant init et demarrer lorsqu'on relance une partie
		public function rejouer_init(){
			stage.removeEventListener(MouseEvent.MOUSE_DOWN , click_rejouer);
			LordBritish = new Vaisseau(stage,Nb_Combo);
			LordBritish.x = stage.stageWidth / 2;
			LordBritish.y = stage.stageHeight / 2;
			LordBritish.reset();
			stage.addChild(LordBritish);
			Nb_Combo = new Combo(stage); 
			Nb_Points = new Score(stage); 
			Nb_Grenades = new Compteur_Grenade(stage); 
			Nb_Boucliers = new Compteur_Bouclier(stage); 
			start_logo=new Start(stage);
			Sounds.jouer_bg_music();
			stage.addChild(Nb_Combo);
			stage.addChild(start_logo);
			stage.addChild(Barre_Vie);
			Barre_Vie.x = 20;
			Barre_Vie.y = 153;
			Barre_Vie.reset();
			background();
			combo=1;
			stage.addChild(Nb_Points);
			stage.addChild(Nb_Grenades); 
			stage.addChild(Nb_Boucliers); 
			debut_jeu=true;
		}
		
		//Fonction qui lance l'intro apres le menu
		private function introduction_debut(){
			if(fin_menu){
				Seq_Intro=new Introduction(stage);
				stage.addChild(Seq_Intro);
				fin_menu=false
			}
		}
	
}
}