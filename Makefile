C = ocamlopt
SRC = util.ml neuralnet.ml example.ml
EXE = example

all: $(EXE)

example: util.ml neuralnet.ml example.ml
	$(C) $^ -o $@

clean:
	rm -f $(EXE) *.cmx *.cmi *.cmo *.cma *.o
