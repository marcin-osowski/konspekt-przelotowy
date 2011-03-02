# Generic makefile for rendering LaTeX documents with
# embedded images. Generates .eps LaTeX compliant images
# from .ps files and from .jpg files
#
# (C) 2010 Osowski Marcin
#

#
# Requires (for generating .eps files):
#   o bin/jpeg2eps
#   o bin/jpeg2eps.ps
#   o bin/viewjpeg.ps
#
#

RESULT=przeloty-konspekt.pdf
IMAGES=mapa_punkty_zwrotne.eps \
	   mapa_przelotowa.eps \
	   toptherm_przyklad.eps \
	   montaz_skrzydel_pirat.eps \
	   montaz_usterzenia_wysokosci_pirat.eps \
	   montaz_skrzydel_junior.eps \
	   montaz_usterzenia_wysokosci_junior.eps \
	   linia_startu_mety.eps \
	   przyklad_foto_sektora.eps \
	   przyklad_cylindra.eps


#
# You should not need to change anything below this line
#

$(RESULT): $(IMAGES)

%.dvi: %.tex
	# create table of contents
	latex $<
	# create document
	latex $<

%.ps: %.dvi
	dvips $<

%.pdf: %.ps
	ps2pdf $<

evince: $(RESULT)
	evince $(RESULT)

%.epsi: %.ps
	ps2epsi $<

%.eps: %.epsi
	cp $< $@

%.eps: images/%.jpg
	cd bin/; ./jpeg2eps ../$<
	cp images/$@ .

rebuild: clean all

all: $(RESULT)

remove_garbage:
	rm -f *~
	rm -f *.ps
	rm -f *.dvi *.aux *.log *.toc *.out
	rm -f *.epsi *.eps
	cd images; make remove_garbage


clean: remove_garbage
	rm -f *.pdf

