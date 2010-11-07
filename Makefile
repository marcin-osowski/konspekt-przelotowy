RESULT=przeloty.pdf
IMAGES=

$(RESULT): $(IMAGES)

%.dvi: %.tex
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



clean:
	rm -f *~
	rm -f *.ps *.pdf
	rm -f *.dvi *.aux *.log
	rm -f *.epsi

