(* Let's try to learn f(x) = x^2 *)

let () =
  (* learning data set *)
  let dataset = 
    [
      ([|-1.0|], [|1.0|]);
      ([|-0.8|], [|0.64|]);
      ([|-0.6|], [|0.36|]);
      ([|-0.4|], [|0.16|]);
      ([|-0.2|], [|0.04|]);
      ([|0.0|], [|0.0|]);
      ([|0.2|], [|0.04|]);
      ([|0.4|], [|0.16|]);
      ([|0.6|], [|0.36|]);
      ([|0.8|], [|0.64|]);
      ([|1.0|], [|1.0|]);
    ]
  in

  (* we will use neural network with one hidden layer of size 6 *)
  let net = Neuralnet.fit 
              ~layers:[6] 
              ~eps:1e-4 
              ~max_iter:100_000 
              ~rate:1.0 
              dataset 
  in
  
  (* let's see how it predicts: *)
  List.iter (fun x ->
             Printf.printf "f(%f) = %f\n" x (Neuralnet.predict net [|x|]).(0))
            [-1.0; 0.6; -0.4; 0.0; 0.1; 0.9; -0.5] 
 
