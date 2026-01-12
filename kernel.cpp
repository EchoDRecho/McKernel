typedef unsigned char uint8_t;
typedef unsigned short uint16_t;


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




extern "C" void kernel_main() {
    // Pointer to the VGA text buffer
 //   unsigned short* video_memory = (unsigned short*)0xB8000;

    const char* str = "Hello Arch Linux! My kernel is alive.\n";
    const char* newstring = "And this is a new line.\n";
    const char* newline = "Ow look, a new line.\n";
/*
    for (int i = 0; i < 83; ++i) {
        // 0x0A is Light Green. 0x00 is Black background.
        // We pack the color (0x0A) and the letter (str[i])
        video_memory[i] = 'a' | (0x0A << 8); //(unsigned short)str[i] | (0x0A << 8);
    }
*/
    Terminal ter;
    ter.clear_scr();
    ter.write_text(str);
    ter.write_text(newstring);
    ter.write_text(newline);
    while(1); // Never let the kernel end
}
