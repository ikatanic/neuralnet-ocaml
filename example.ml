(* Let's try to learn f(x) = x^2 *)

let () =
  (* 1. create a dataset *)
  let xs = [-1.0; -0.8; -0.6; -0.4; -0.2; 0.0; 0.2; 0.4; 0.6; 0.8; 1.0] in
  let dataset = List.map (fun x -> [x], [x*.x]) xs in

  (* 2. train a network with one hidden layer of size 6 *)
  let net = Neuralnet.fit 
              ~layers:[6] 
              ~eps:1e-5
              ~max_iter:100_000 
              ~rate:0.2
              ~activation:Activation.sigmoid
              dataset 
  in

  (* 3. profit *)
  let xs = [-1.0; 0.6; -0.4; 0.0; 0.1; 0.9; -0.5] in
  List.iter
    (fun x -> Printf.printf "f(%f) = %f\n" x ((Neuralnet.predict net [x]) |> List.hd))
    xs
