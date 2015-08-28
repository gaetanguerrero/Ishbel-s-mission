package  {

	//Classe qui gère tout les sons du jeu
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class Sons {
		private var conteneurSon_intro:Sound = new Sound();
		private var fichierMP3_intro:URLRequest = new URLRequest("sons/intro.mp3");
		private var canal_intro:SoundChannel = new SoundChannel();
		
		private var conteneurSon_mort_asteroide:Sound = new Sound();
		private var fichierMP3_mort_asteroide:URLRequest = new URLRequest("sons/Mort Falchion.mp3");
		private var canal_mort_asteroide:SoundChannel = new SoundChannel();
		
		private var conteneurSon_explosion_lb:Sound = new Sound();
		private var fichierMP3_explosion_lb:URLRequest = new URLRequest("sons/Blesse.mp3");
		private var canal_explosion_lb:SoundChannel = new SoundChannel();
		
		private var conteneurSon_mort_falchion:Sound = new Sound();
		private var fichierMP3_mort_falchion:URLRequest = new URLRequest("sons/Mort Falchion.mp3");
		private var canal_mort_falchion:SoundChannel = new SoundChannel();
		
		private var conteneurSon_grenade:Sound = new Sound();
		private var fichierMP3_grenade:URLRequest = new URLRequest("sons/BOMB_1.mp3");
		private var canal_grenade:SoundChannel = new SoundChannel();
		
		private var conteneurSon_menu_princ:Sound = new Sound();
		private var fichierMP3_menu_princ:URLRequest = new URLRequest("sons/menu.mp3");
		private var canal_menu_princ:SoundChannel = new SoundChannel();
		
		private var conteneurSon_missile_1:Sound = new Sound();
		private var fichierMP3_missile_1:URLRequest = new URLRequest("sons/Missile_1.mp3");
		private var canal_missile_1:SoundChannel = new SoundChannel();
		
		private var conteneurSon_missile_b:Sound = new Sound();
		private var fichierMP3_missile_b:URLRequest = new URLRequest("sons/Missile_1.mp3");
		private var canal_missile_b:SoundChannel = new SoundChannel();
		
		private var conteneurSon_missile_f:Sound = new Sound();
		private var fichierMP3_missile_f:URLRequest = new URLRequest("sons/Missile_1.mp3");
		private var canal_missile_f:SoundChannel = new SoundChannel();
		
		private var conteneurSon_missile_l:Sound = new Sound();
		private var fichierMP3_missile_l:URLRequest = new URLRequest("sons/Missile_1.mp3");
		private var canal_missile_l:SoundChannel = new SoundChannel();
		
		private var conteneurSon_bg_music:Sound = new Sound();
		private var fichierMP3_bg_music:URLRequest = new URLRequest("musique.mp3");
		private var canal_bg_music:SoundChannel = new SoundChannel();
		
		private var conteneurSon_game_over:Sound = new Sound();
		private var fichierMP3_game_over:URLRequest = new URLRequest("gameover.mp3");
		private var canal_game_over:SoundChannel = new SoundChannel();
			
		private var conteneurSon_mort_lb:Sound = new Sound();
		private var fichierMP3_mort_lb:URLRequest = new URLRequest("sons/Mort.mp3");
		private var canal_mort_lb:SoundChannel = new SoundChannel();
		
		private var conteneurSon_upgrade:Sound = new Sound();
		private var fichierMP3_upgrade:URLRequest = new URLRequest("sons/Missile_1.mp3");
		private var canal_upgrade:SoundChannel = new SoundChannel();
		
		//Constructeur, qui charge tout les sons
		public function Sons() {
			conteneurSon_intro.load(fichierMP3_intro);
			conteneurSon_mort_asteroide.load(fichierMP3_mort_asteroide);
			conteneurSon_explosion_lb.load(fichierMP3_explosion_lb);
			conteneurSon_mort_falchion.load(fichierMP3_mort_falchion);
			conteneurSon_grenade.load(fichierMP3_grenade);
			conteneurSon_menu_princ.load(fichierMP3_menu_princ);
			conteneurSon_missile_1.load(fichierMP3_missile_1);
			conteneurSon_missile_b.load(fichierMP3_missile_b);
			conteneurSon_missile_f.load(fichierMP3_missile_f);
			conteneurSon_missile_l.load(fichierMP3_missile_l);
			conteneurSon_bg_music.load(fichierMP3_bg_music);
			conteneurSon_game_over.load(fichierMP3_game_over);
			conteneurSon_mort_lb.load(fichierMP3_mort_lb);
			conteneurSon_upgrade.load(fichierMP3_upgrade);
		}
		public function jouer_intro(){
			canal_intro = conteneurSon_intro.play();
		}
		public function jouer_mort_asteroide(){
			canal_mort_asteroide = conteneurSon_mort_asteroide.play();
		}
		public function jouer_explosion_lb(){
			canal_explosion_lb = conteneurSon_explosion_lb.play();
		}
		public function jouer_mort_falchion(){
			canal_mort_falchion = conteneurSon_mort_falchion.play();
		}
		public function jouer_grenade(){
			canal_grenade = conteneurSon_grenade.play();
		}
		public function jouer_menu_princ(){
			canal_menu_princ = conteneurSon_menu_princ.play(0,999);
		}
		public function jouer_missile_1(){
			canal_missile_1 = conteneurSon_missile_1.play();
		}
		public function jouer_missile_b(){
			canal_missile_b = conteneurSon_missile_b.play();
		}
		public function jouer_missile_f(){
			canal_missile_f = conteneurSon_missile_f.play();
		}
		public function jouer_missile_l(){
			canal_missile_l = conteneurSon_missile_l.play();
		}
		public function jouer_bg_music(){
			canal_bg_music = conteneurSon_bg_music.play(0,999);
		}
		public function jouer_game_over(){
			canal_game_over = conteneurSon_game_over.play();
		}
		public function jouer_mort_lb(){
			canal_mort_lb = conteneurSon_mort_lb.play();
		}
		public function jouer_upgrade(){
			canal_upgrade = conteneurSon_upgrade.play();
		}
		
		public function stop_bg_music(){
			canal_bg_music.stop();
		}
		public function stop_game_over(){
			canal_game_over.stop();
		}
		public function stop_menu_princ(){
			canal_menu_princ.stop();
		}
		//Pour la pause du son
		public function return_position():int{
			trace(canal_bg_music.position);
			return canal_bg_music.position;
		}
		public function pause_bg_music(position:int){
			canal_bg_music = conteneurSon_bg_music.play(position);
		}

	}
	
}
