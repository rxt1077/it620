TYPST := typst compile --root .
SRCS := $(wildcard slides/*.typ) $(wildcard labs/*.typ)
OUTPUT_DIR := ../docs
OUTPUT := $(SRCS:%.typ=$(OUTPUT_DIR)/%.pdf)
DEPDIR := .deps

all: $(OUTPUT)

clean:
ifeq ($(OS),Windows_NT)
	powershell 'Remove-Item "$(OUTPUT)".Split()'
else
	rm $(OUTPUT)
endif

$(OUTPUT_DIR)/%.pdf: %.typ
	$(TYPST) --deps $(DEPDIR)/$*.d --deps-format make $< $@

DEPFILES := $(SRCS:%.typ=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))
