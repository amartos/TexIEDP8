WORKDIR=build
MAIN=main
PDF=$(MAIN).pdf
TEX=$(MAIN).tex
ENGINE=xelatex
OPTS=-output-directory=$(WORKDIR) --jobname="$(MAIN)"

SRC=src
CONTENT=$(SRC)/content.tex
DOC=document
IMG=images

META=metadata.tex
TEMPLATE=template.tex

.Phony: all
all: pdf

.Phony: full
full: clean content triple

.Phony: content
content:
	@rm $(CONTENT)
	@touch $(CONTENT)
	@echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" > $(CONTENT)
	@echo "% THIS DOCUMENT IS AUTOMATICALLY GENERATED" >> $(CONTENT)
	@echo "% ALL MODIFICATIONS WILL BE ERASED EACH \"FULL\" RUN" >> $(CONTENT)
	@echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" >> $(CONTENT)
	@echo "" >> $(CONTENT)
	@for i in $$(ls $(DOC)); do echo "\input{$(DOC)/$$i}" >> $(CONTENT); done

.Phony: triple
triple:
	@mkdir -p $(WORKDIR)
	$(ENGINE) $(OPTS) $(TEX)
	biber $(WORKDIR)/$(MAIN)
	$(ENGINE) $(OPTS) $(TEX)
	$(ENGINE) $(OPTS) $(TEX)

.Phony: pdf
pdf:
	@mkdir -p $(WORKDIR)
	$(ENGINE) $(OPTS) $(TEX)

.Phony: clean
clean:
	@rm -rf $(WORKDIR)

.Phony: remove-remote
remove-remote:
	@git remote rm origin
