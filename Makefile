LATEXMK = latexmk
#latex --output-format=pdf main.tex

DVIPS = dvips

PDFFLAGS = -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
           -dCompressPages=true -dUseFlateCompression=true  \
           -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100

LATEXMKFLAGS	= -pdf -view=pdf -quiet

md_source = main.md
tex_source = $(md_source:%.md=%.tex)
pdf_output = $(tex_source:%.tex=%.pdf)
html_output = $(tex_source:%.tex=%.html)

%.dvi: %.tex
	$(LATEXMK) -dvi $<

%.ps: %.dvi
	$(DVIPS) -o $@ $<

%.pdf: %.ps
	ps2pdf $(PDFFLAGS) $<

%.tex: %.md
	pandoc -s $< -o $@

all: main.tex
	$(LATEXMK) $(LATEXMKFLAGS) $<
	mv main.pdf output.pdf
	evince output.pdf

STYLE = --csl /home/lunarpulse/Documents/Repos/texTemplates/styles/
HARVARD = elsevier-harvard2.csl
IEEE = ieee.csl
BIB = --bibliography main.bib

pandoc_ieee_html: main.tex
	pandoc -s -S $(BIB) $(STYLE)$(IEEE) $< -o $(html_output)

pandoc_harvard_html: main.tex
	pandoc -s -S $(BIB) $(STYLE)$(HARVARD) $< -o $(html_output)

pandoc_ieee_pdf: main.tex
	pandoc -s -S $(BIB) $(STYLE)$(IEEE) $< -o $(pdf_output)

pandoc_harvard_pdf: main.tex
	pandoc -s -S $(BIB) $(STYLE)$(HARVARD) $< -o $(pdf_output)

xelatex: main.tex
	$(LATEXMK) -xelatex $<
	mv main.pdf output.pdf
	evince output.pdf

htlatex: main.tex
	htlatex main.tex
#main.tex: main.md
#	pandoc -s $< -o $@
#	$(LATEXMK) $(LATEXMKFLAGS) $@

hevea:
	sed 's/\(figs\/[^.]*\).\(pdf\|png\)/\1.eps/' main.tex > output.tex
	rm -rf html
	mkdir html
	hevea -O -e latexonly htmlonly output
	imagen -png output
	hacha output.html
	cp up.png next.png back.png html
	mv index.html output.css output*.html output*.png *motif.gif html

clean:
	latexmk -C
	rm -f *~ *.aux *.log *.dvi *.idx *.ilg *.ind *.toc *.lof *.lot *.out *.run* *.pdf *.paux *.bbl *blx* *.ptc
