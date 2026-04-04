AS=aarch64-linux-gnu-as
LD=aarch64-linux-gnu-ld
QEMU=qemu-aarch64
BUILD=build
MAIN_SRC=main.s
AUX_SRCS=$(filter-out $(MAIN_SRC),$(wildcard *.s))
SRCS=$(MAIN_SRC) $(AUX_SRCS)
OBJS=$(patsubst %.s,$(BUILD)/%.o,$(SRCS))

all: $(BUILD)/main
$(BUILD):
	mkdir -p $(BUILD)
$(BUILD)/%.o: %.s | $(BUILD)
	$(AS) -g -o $@ $<
$(BUILD)/main: $(OBJS)
	$(LD) -o $@ $(OBJS)
run: $(BUILD)/main
	$(QEMU) $(BUILD)/main
gdb: $(BUILD)/main
	$(QEMU) -g 1234 $(BUILD)/main
clean:
	rm -rf $(BUILD)
