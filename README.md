# Simple neural network in OCaml

Train and run a neural network in OCaml.

## Technical details

This implements a feed-forward, multi-layered and fully-connected network.
Network learning is implemented as gradient descent using backpropagation algorithm.

## How to use

Two methods are exposed (`neuralnet.mli`):

`Neuralnet.fit` - returns a trained neural network and expects the following arguments:

- `dataset` - list of tuples `(input, output)` where input/output are `float` arrays
- `alg_type` - optional. Gradient descent type: `Batch`, `Stohastic` or `MiniBatch`. Defaults to `Batch`.
- `layers` - optional. List of sizes of hidden layers in the network. Defaults to `[]` (no hidden layers).
- `activation` - optional. Activation function to be used. Defaults to `Activation.sigmoid`.
- `max_iter` - optional. Run the gradient descent up to `max_iter` iterations. Defaults to `10000`.
- `eps` - optional. Run the gradient descent until learning error reaches `eps`. Defaults to `1e-3`.
- `rate` - optional. Coefficient to multiply gradients with when updating weights. Defaults to `0.2`.
- `verbose` - optional. Learning errors through iterations will be printed to `stderr` if set to `true`. Defaults to `false`.

`Neuralnet.predict` - runs the input through the network and returns the output. Expects following arguments:

- `net` - trained neural network. The thing `Neuralnet.fit` returns.
- `x` - an input to the network.

## Example

See `example.ml`.

To run it do:

```bash
   make
   ./example
```
