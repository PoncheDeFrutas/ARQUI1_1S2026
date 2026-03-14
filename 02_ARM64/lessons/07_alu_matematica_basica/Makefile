AS=aarch64-linux-gnu-as
LD=aarch64-linux-gnu-ld
QEMU=qemu-aarch64
BUILD=build

all: $(BUILD)/main

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/main.o: main.s | $(BUILD)
	$(AS) -g -o $@ $<

$(BUILD)/main: $(BUILD)/main.o
	$(LD) -o $@ $<

run: $(BUILD)/main
	$(QEMU) $(BUILD)/main

gdb: $(BUILD)/main
	$(QEMU) -g 1234 $(BUILD)/main

clean:
	rm -rf $(BUILD)
