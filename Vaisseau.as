package  {
	
	//Classe du Vaisseau du joueur
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.filters.*;
	
	
	public class Vaisseau extends MovieClip {
		
		//Variables concernant le vaisseau
		private var stageRef:Stage;
		private var vitesse:Number = 1;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var frottement:Number = 0.90;
		private var frottement_x:Boolean=false;
		private var frottement_y:Boolean=false;
		private var vitesse_max:Number = 5;
		private var combo:Combo;
		
		//Variables pour la gestion des armes
		private var Texte_WP:texte_weapon;
		private var arme:int=1;
		private var sw_wp:Boolean=false;
		private var Type_Missile:String;
		private var Laser:Boolean=false;
		private var Big:Boolean=false;
		
		//Booleens pour la gestion des touches
		private var Touche_haut:Boolean;
		private var Touche_bas:Boolean;
		private var Touche_gauche:Boolean;
		private var Touche_droite:Boolean;
		private var Touche_espace:Boolean;
		private var Touche_ctrl:Boolean;
		private var Touche_shift:Boolean;
		private var Touche_X:Boolean;
		
		//Timers pour les objets et les propriétés du vaisseau
		private var Delai:Timer;
		private var Delai_Mort:Timer;
		private var Delai_Invincible:Timer; 
		private var Delai_Bouclier:Timer;
		private var Delai_Bombe:Timer;	
		
		//Booleens associés aux timers
		private var Tir:Boolean = true;
		private var Shield:Boolean = true;
		private var Invincible:Boolean=false;

		//Variables pour les compteurs des accesoires du vaisseau		
		private var vie:Number ;
		private var grenades:Number=3;
		private var boucliers:Number=5;
		private var lasers:Number=0;
		private var missiles:Number=0;
		
		// Variables pour la grenade
		private var Bombe:Grenade_1;
		private var cree_bombe:Boolean=false;
		private var Fin_Bombe:Boolean=false;
		
		//Signal pour envoyer des messages au moteur
		private var Signal_Vaisseau:String;
		
		//Booleen pour la mort du vaisseau
		private var Mort:Boolean=false;
		
		//Glow Filter pour gerer des lueurs pour le bouclier du vaisseau
		private var Lueur:GlowFilter = new GlowFilter(); 
		
		
		//Constructeur
		public function Vaisseau(stageRef:Stage,combo:Combo)
		{
			gotoAndStop("default");
			vie=5;
			Lueur.inner=false; 
			Lueur.color = 0xFFFFFF; 
			Lueur.blurX = 20; 
			Lueur.blurY = 20;
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN,Key_Down);
			stageRef.addEventListener(KeyboardEvent.KEY_UP,Key_Up);
			this.combo=combo;
			
			
			this.stageRef = stageRef;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
			
			Delai = new Timer(200, 1);
			Delai.addEventListener(TimerEvent.TIMER, DelaiHandler, false, 0, true);
			
			Delai_Mort = new Timer(400, 1);
			Delai_Mort.addEventListener(TimerEvent.TIMER, Delai_MortHandler, false, 0, true);
			
			Delai_Invincible = new Timer(2000, 1);
			Delai_Invincible.addEventListener(TimerEvent.TIMER, Delai_InvincibleHandler, false, 0, true);
			
			Delai_Bouclier = new Timer(2500, 1);
			Delai_Bouclier.addEventListener(TimerEvent.TIMER, Delai_BouclierHandler, false, 0, true);
			
			Delai_Bombe = new Timer(1500, 1);
			Delai_Bombe.addEventListener(TimerEvent.TIMER, Delai_BombeHandler, false, 0, true);
			Texte_WP= new texte_weapon(stageRef);
			stageRef.addChild(Texte_WP);
			
		}
		
		//Fonction qui retoune vie
		public function getVie():int 
		{
			return vie;
		}
		//Fonction de reset des compteurs
		public function reset()
		{
			vie=5;
			grenades=3;
			boucliers=5;
			lasers=0;
			missiles=0;
		}
		
		//Fonction qui retoune le nombre de grenades
		public function getGrenades():int 
		{
			return grenades;
		}
		
		//Fonction qui retoune le nombre de boucliers
		public function getBoucliers():int 
		{
			return boucliers;
		}
		
		//Fonction qui retoune le signal du vaisseau
		public function getSignal():String
		{
			return Signal_Vaisseau;
		}
		
		//Fonction qui retoune Laser
		public function getLaser():Boolean
		{
				return Laser;
		}
		//Fonction qui retoune Big
		public function getBig():Boolean
		{
				return Big;
		}
		
		//Fonction loop où on gère les actions claviers (deplacement, tir, switch d'arme, bouclier, grenades) et le déplacement du vaisseau dans un cadre fini
		public function loop(e:Event) : void
		{
			if(!Moteur.game_over){
				
				if (Moteur.pause==false){
						
					if (lasers==0){
						Laser=false;
						Texte_WP.Change_Text("Normal");
					}
						
					if (missiles==0){
						Big=false;
						Texte_WP.Change_Text("Normal");
					}
					if (Mort==true)
						meurs();
						
					if (Fin_Bombe==true)
						Fin_Grenade();
				
					if (Touche_gauche==true)
						vx -= vitesse;
					
					if (Touche_droite==true)
						vx += vitesse;
					
		 
					if (Touche_haut==true)
						vy -= vitesse;
					
					if (Touche_bas==true)
						vy += vitesse;
					
					if (Touche_X==true){
						sw_wp=true;
						switch_weapon();
					}
					if (Touche_espace==true)
						Tirer();	
					if (Touche_ctrl==true)
						Bouclier();
					
					if(Touche_shift==true){
						
						if ((Fin_Bombe==false)&&(!Mort)&&(grenades!=0)){
								if ((Fin_Bombe==false)&&(cree_bombe==false)){
									Bombe = new Grenade_1(this);
									this.addChild(Bombe);
									cree_bombe=true;
									grenades -=1;
									Grenade();
								}
						}
					}
				
				if((!Touche_haut)&&(!Touche_bas))
					vx *= frottement;
					
				if((!Touche_gauche)&&(!Touche_droite))
					vy *= frottement;
				x += vx;
				y += vy;
				if (vx > vitesse_max)
					vx = vitesse_max;
				else if (vx < -vitesse_max)
					vx = -vitesse_max;
	 
				if (vy > vitesse_max)
					vy = vitesse_max;
				else if (vy < -vitesse_max)
					vy = -vitesse_max;
				
				if (x > stageRef.stageWidth/3)
					x = (stageRef.stageWidth/3)-1;
				else if (x < 80)
					x = 81;
	 				if (y > stageRef.stageHeight-10)
					y = stageRef.stageHeight-9;
				else if (y < 10)
					y = 11;
				}
			}
		}
		
		//Fonction pour gerer le changement d'arme
		private function switch_weapon(){
				if(sw_wp==true){
					if(arme==1){ 
					   if(lasers!=0){
						 trace('1->2')
						 Changement_Arme("Laser");
						 arme=2;
						 sw_wp=false;
						 Touche_X=false;
						 Texte_WP.Change_Text("Laser");
						 Texte_WP.Change_ammo(lasers);
					   }
					   else if(missiles!=0){
						   trace('1->3')
						 Changement_Arme("Big");
						 arme=3;
						 sw_wp=false;
						 Touche_X=false;
						  Texte_WP.Change_Text("Missile");
						 Texte_WP.Change_ammo(missiles);
					   }
					  sw_wp=false;
					  Touche_X=false;
					}
					else if(arme==2){ 
					   if(missiles!=0){
						   trace('2->3')
						 Changement_Arme("Big");
						 arme=3;
						 sw_wp=false;
						 Touche_X=false;
						 Texte_WP.Change_Text("Missile");
						 Texte_WP.Change_ammo(missiles);
					   }
					   
					   else{
						   trace('2->1')
						 Changement_Arme("Normal");
						 arme=1;
						 sw_wp=false;
						 Touche_X=false;
						 Texte_WP.Change_Text("Normal");
						 Texte_WP.Change_ammo(0);
					   }
					   sw_wp=false;
					   Touche_X=false;
					}
					else if(arme==3){ 
						trace('3->1')
					  	Changement_Arme("Normal");
						 arme=1;
						 sw_wp=false;
						 Touche_X=false;
						 Texte_WP.Change_Text("Normal");
						 Texte_WP.Change_ammo(0);
					}
					sw_wp=false;
					Touche_X=false;
				}
		}
		
		//Fonction du tir, en fonction de l'arme choisie
		private function Tirer() : void
		{
			if (Tir && !Mort &&!Laser &&!Big)
			{
				stageRef.addChild(new Missile_1(stageRef, x + vx, y - 10));
				Tir = false;
				Delai.start();
			}
			if (Tir && !Mort && Laser)
			{
				stageRef.addChild(new Missile_Laser(stageRef, x + vx, y - 10));
				Tir = false;
				lasers = lasers -1;
				Texte_WP.Change_ammo(lasers);
				trace(lasers);
				Delai.start();
			}
			if (Tir && !Mort && Big)
			{
				stageRef.addChild(new Missile_Big(stageRef, x + vx, y - 10));
				Tir = false;
				missiles = missiles -1;
				Texte_WP.Change_ammo(missiles);
				trace(missiles);
				Delai.start();
			}
 
		}
		
		//Fonction du changement d'arme, des booleens associés
		public function Changement_Arme(chaine:String)
		{
			switch(chaine)
				{
					case "Laser" :
					   Laser=true;
					   Big=false;
					   break;
					case "Big" :
					   Big=true;
					   Laser=false;
					   break;
					case "Normal" :
					   Laser=false;
					   Big=false;
					   break;
				}
		}
		
		//Fonction Key_up, quand la touche est relevée, le booleen est faux
		private function Key_Up(e:KeyboardEvent){
			if (Moteur.pause==false){
				if (e.keyCode==37){
					Touche_gauche=false;
				}
				 if (e.keyCode==39){
					Touche_droite=false;
				}
	 
				if (e.keyCode==38){
					Touche_haut=false;
				}
				if (e.keyCode==40){
					Touche_bas=false;
				}
				
				if (e.keyCode==32){
					Touche_espace=false;
				}		
				if (e.keyCode==17)
					Touche_ctrl=false;
				
				if(e.keyCode==16){
					Touche_shift=false
				
				if(e.keyCode==88)
					Touche_X=false
				}
			}
		}
		//Fonction Key_up, quand la touche est appuyée, le booleen est vrai
		private function Key_Down(e:KeyboardEvent)
		{
			if (Moteur.pause==false){
				if (e.keyCode==37){
					Touche_gauche=true
				}
				if (e.keyCode==39){
					Touche_droite=true
				}
	 
				if (e.keyCode==38){
					Touche_haut=true
				}
				 if (e.keyCode==40){
					Touche_bas=true
				}
				
				if (e.keyCode==32){
					Touche_espace=true
				}
				if (e.keyCode==17)
					Touche_ctrl=true
				
				if(e.keyCode==16)
					Touche_shift=true
					
				if(e.keyCode==88)
					Touche_X=true
			}
		}

		//Fonction du délai de tir, pour eviter d'avoir un tir en continu
		private function DelaiHandler(e:TimerEvent) : void
		{
			Tir = true;
		}
		
		// Fonction qui s'execute quand un vaisseau est touché
		public function touched(){
			vie -=1;
			combo.changement(1);
			if (vie!=0){
				Invincible=true;
				this.alpha=0.5;
				this.filters=[Lueur];
				Delai_Invincible.start();
			}
			else{
				animation_meurs();
			}
			
			
		}
		
		//Delai de l'invincibilité
		private function Delai_InvincibleHandler(e:TimerEvent) : void
		{
			Invincible=false;
			this.alpha=1;
			this.filters=[];
		}
		
		//Retourne invincible
		public function getInvincible():Boolean{
			return Invincible
		}
		
		//Fonction qui gère l'animation de la mort
		private function animation_meurs(){
				gotoAndPlay(2);
				Moteur.Sounds.jouer_mort_lb();
				stageRef.removeChild(Texte_WP);
				Delai_Mort.start();
			
		}
		
		//fonction qui gère la mort du vaisseau
		public function meurs(){
			
			removeEventListener(Event.ENTER_FRAME, loop);

			if (stageRef.contains(this))
				stageRef.removeChild(this);
		}
		
		//Delai de la mort
		private function Delai_MortHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
			Mort = true;
		}
		
		//Fonction qui gère quand un bouclier est utilisé
		private function Bouclier(){
			if (Moteur.pause==false){
				if ((boucliers!=0)&&(Invincible==false)){
					boucliers -=1;
					Shield = true ;
					Invincible=true;
					this.filters=[Lueur];
					Delai_Bouclier.start();
					if (Moteur.pause==true){
						Delai_Bombe.stop();
					}
				}
			}
		}
		
		//Delai du bouclier
		private function Delai_BouclierHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
				Shield = false ;
				Invincible=false;
				this.filters=[];
		}
		
		//Foction qui gère quand une grenade est lancée
		private function Grenade(){
			if (Moteur.pause==false){
				stageRef.addChild(Bombe);
				Delai_Bombe.start();
				if (Moteur.pause==true){
					Delai_Bombe.stop();
				}
			}
		}
		
		//Fonction de la fin de grenade, pour ne pas spammer
		private function Fin_Grenade(){
		if (Fin_Bombe==true){
				Fin_Bombe=false;
				cree_bombe=false;
			}
		}
		
		//Delai de la grenade
		private function Delai_BombeHandler(e:TimerEvent) : void
		{
			Bombe.explosion=true;
			Fin_Bombe=true;
		}
		
		//Fonction quand on touche un upgrade vert
		public function upgrade_green()
		{	
			if(vie<5)
				{
				vie = vie+1;
				trace('lol2');
				if (vie<=5){
					trace('Vie Up!');
					Signal_Vaisseau="Vie Up";
				}
			}

		}
		
		//Fonction quand on touche un upgrade gris
		public function upgrade_gray()
		{	
			if(boucliers<9)
				{
				boucliers = boucliers+1;
				trace('Bouclier+1');
			}
		}
		
		//Fonction quand on touche un upgrade rouge
		public function upgrade_red()
		{	
				if(grenades<5)
					{
						grenades = grenades+1;
						trace('grenade+1');
					}
		}
		
		//Fonction quand on touche un upgrade bleu
		public function upgrade_blue()
		{	
				if(lasers<60)
					{
						lasers = lasers+20;
						if(lasers>60)
							lasers=60
						Texte_WP.Change_ammo(lasers);
						trace('laser+20');
					}
		}
		
		//Fonction quand on touche un upgrade jaune
		public function upgrade_yellow()
		{	
				if(missiles<60)
					{
						missiles = missiles+20;
						if(missiles>60)
							missiles=60
						Texte_WP.Change_ammo(missiles);
						trace('missiles+20');
					}
		}
		
		//Fonction pour changer le signal du vaisseau
		public function Change_Signal(chaine:String){
			Signal_Vaisseau=chaine;
		}
	}
}
