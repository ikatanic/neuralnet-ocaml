Artificial neural network library for OCaml
===========================================

This is a basic artificial neural network library written as a part of (Fuzzy, evolutionary and neuro-computing) course assignment at my university.

Technical details
-----------------

It's a feedforward multilayer fullyconnected artificial neural network.
Network learning is implemented as gradient descent by backpropagation algorithm.

How to use
----------

You have two methods at your disposal:

```Neuralnet.fit``` which returns trained neural network and expects following arguments:
* ```dataset``` - list of tuples (input, output) where input/output are float arrays
* ```alg_type``` - optional. Specifies gradient descent type, ```Batch```, ```Stohastic``` or ```MiniBatch```. Defaults to ```Batch```
* ```layers``` - optional. Specifies sizes of hidden layers in neural network. Defaults to ```[]``` (no hidden layers)
* ```activation``` - optional. Activation function to be used. Defaults to ```Activation.sigmoid```.
* ```max_iter``` - optional. Gradient descent will do at most ```max_iter``` iterations. Defaults to ```10000```
* ```eps``` - optional. Gradient descent will stop after learning error reaches ```eps```. Defaults to ```1e-3```
* ```rate``` - optional. Coefficient to multiply gradients with when updating the weights. Defaults to ```0.2```
* ```verbose``` - optional. Learning errors through iterations will be printed to ```stderr``` if set to ```true```. Defaults to ```false```

```Neuralnet.predict``` which returns predicted output and expects following arguments:
* ```net``` - trained neural network. Thing ```Neuralnet.fit``` returns
* ```x``` - input for which we want to know the prediction


Example
-------

You can see basic usage in ```example.ml```.
To run it do:

```
   make
   ./example
```