typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

class Terminal{
		
	public:	
		uint16_t* screen_mem;
		int offset;
		int timer = 0;		

		void init(){
			screen_mem = (unsigned short*)0xB8000;
			offset = 2;

			for (int i = 0; i <= 80*25; ++i){
				screen_mem[i] = ' ';
			}
		}
		
		void print_char(char c){
			screen_mem[offset] = (0x0F << 8) | c;
		}

		void printHex(unsigned int hex){
			screen_mem[0] = (0x0F << 8) | '0';
			screen_mem[1] = (0x0F << 8) | 'x';
			const char* hexChars = "0123456789ABCDEF";

			for ( int i = 0; i < 8; i++){
				int digit = (hex >> (28 - i * 4) & 0xF);

				char c = hexChars[digit];
				print_char(c);
			}
		}
};

Terminal T;

void flicker_char(char c){
	T.print_char(c);
	T.timer++;
	if (T.offset >= 80*25){
		T.offset = 0;
	}
	if (T.timer == 1000){
		T.print_char(' ');
		T.offset++;
		T.timer = 0;
	}
}
extern "C" void kernel_main() {
	T.init();
	T.offset = 0;
	int i = 0;



	
/*
    for (int i = 0; i < 83; ++i) {
        // 0x0A is Light Green. 0x00 is Black background.
        // We pack the color (0x0A) and the letter (str[i])
        video_memory[i] = 'a' | (0x0A << 8); //(unsigned short)str[i] | (0x0A << 8);
    }
*/
    
	const char* chars = "lsdkhpowefi23423589203490-12*&^#%$$!^#&$+=";
   while(1){
	
	flicker_char(chars[i]);
	i++;
	if ( i == 42){
		i = 0;
	}
   }
	
}












