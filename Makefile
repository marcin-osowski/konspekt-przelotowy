RESULT=przeloty.pdf
IMAGES=mapa_punkty_zwrotne.eps

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

%.evince: %.pdf
	evince $< &> /dev/null
	
evince: $(RESULT)
	evince $(RESULT)

%.epsi: %.ps
	ps2epsi $<

%.eps: %.epsi
	cp $< $@

%.eps: %.jpg
	cd bin/; ./jpeg2eps ../$<

rebuild: clean all

all: $(RESULT)

clean:
	rm -f *~
	rm -f *.ps
	rm -f *.dvi *.aux *.log *.toc *.out
	rm -f *.epsi *.eps

