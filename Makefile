RESULT=przeloty.pdf
IMAGES=

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

rebuild: clean all

all: $(RESULT)

clean:
	rm -f *~
	rm -f *.ps *.pdf
	rm -f *.dvi *.aux *.log *.toc
	rm -f *.epsi

