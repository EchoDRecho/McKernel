
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;


#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64


extern "C" unsigned char inb(unsigned short port);


class Terminal{
	private:
		uint16_t* buffer;
		int cursor_x;
		int cursor_y;
		uint8_t color;

	public:
		Terminal(){
			buffer = (uint16_t*)0xB8000;
			cursor_x = 0;
			cursor_y = 0;
			color = 0x0A;

		}

		void clear_scr(){
			for(int i = 0; i < 80 * 25; ++i){   //80 columns 25 rows
				buffer[i] = (uint16_t)' ' | (color << 8);  //shift left by 8 bites
			}
		}

		void put_char(char c){
			if( c == '\n'){
				cursor_x = 0;
				cursor_y++;
			}else{
				int index = cursor_y * 80 + cursor_x;
				buffer[index] = (uint16_t)c | (color << 8);
				cursor_x++;
			}
			if (cursor_x >= 80){
				cursor_x = 0;
				cursor_y++;
			}
		}

		void write_text(const char* word){
			for ( int i = 0; word[i] != '\0'; ++i ){
				put_char(word[i]);
			}
		}
};


Terminal ter;
void keyboard_driver_write();

extern "C" void kernel_main() {
    // Pointer to the VGA text buffer
 //   unsigned short* video_memory = (unsigned short*)0xB8000;
	const char* kernel_message = "I/O Driver initialized!\t Type something \n";
	ter = Terminal();
/*
    for (int i = 0; i < 83; ++i) {
        // 0x0A is Light Green. 0x00 is Black background.
        // We pack the color (0x0A) and the letter (str[i])
        video_memory[i] = 'a' | (0x0A << 8); //(unsigned short)str[i] | (0x0A << 8);
    }
*/
    
    ter.clear_scr();
    ter.write_text(kernel_message);
    while(1) {
	keyboard_driver_write();
	
    }

}


unsigned char keyboard_map[128] = {0,  27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b','\t','q', 'w', 'e', 'r','t', 'y', 'u', 'i', 'o', 'p', '[',']','\n', 0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', 0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, '*', 0, ' ', 0};	



void keyboard_driver_write(){


	if(inb(KEYBOARD_STATUS_PORT) & 0x01){
		uint8_t scanned_code = inb(KEYBOARD_DATA_PORT);
		if (!(scanned_code & 0x80)){
			ter.put_char(keyboard_map[scanned_code]);
		}	
	}
}















