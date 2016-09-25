C = ocamlopt
SRC = util.ml neuralnet.mli neuralnet.ml example.ml activation.mli activation.ml
EXE = example

all: $(EXE)

example: util.ml activation.mli activation.ml neuralnet.mli neuralnet.ml example.ml 
	$(C) $^ -o $@

clean:
	rm -f $(EXE) *.cmx *.cmi *.cmo *.cma *.o
