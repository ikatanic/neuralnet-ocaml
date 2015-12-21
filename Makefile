C = ocamlopt str.cmxa 
GL = -I +glMLite GL.cmxa Glu.cmxa Glut.cmxa
SRC = util.ml neuralnet.ml example.ml
EXE = example

all: $(EXE) $(OBJ)

example: util.ml neuralnet.ml example.ml
	$(C) $(GL) $^ -o $@

clean:
	rm -f $(EXE) *.cmx *.cmi *.cmo *.cma *.o
