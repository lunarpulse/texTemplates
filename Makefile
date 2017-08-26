LATEX = latexmk
#latex --output-format=pdf main.tex

DVIPS = dvips

PDFFLAGS = -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
           -dCompressPages=true -dUseFlateCompression=true  \
           -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100

LATEXMKFLAGS	= -pdf -view=pdf -quiet


%.dvi: %.tex
	$(LATEX) -dvi $<

%.ps: %.dvi
	$(DVIPS) -o $@ $<

%.pdf: %.ps
	ps2pdf $(PDFFLAGS) $<

all:	main.tex
	$(LATEX) $(LATEXMKFLAGS) $<
	mv main.pdf output.pdf
	evince output.pdf

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
