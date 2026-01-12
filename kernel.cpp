extern "C" void kernel_main() {
    // Pointer to the VGA text buffer
    unsigned short* video_memory = (unsigned short*)0xB8000;

    const char* str = "Hello Arch Linux! My kernel is alive.";

    for (int i = 0; str[i] != '\0'; ++i) {
        // 0x0A is Light Green. 0x00 is Black background.
        // We pack the color (0x0A) and the letter (str[i])
        video_memory[i] = (unsigned short)str[i] | (0x0A << 8);
    }

    while(1); // Never let the kernel end
}
