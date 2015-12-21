open Util

let sigm x = 1. /. (1. +. (exp (-.x)))

let rec forward_propagation net x =
  match net with
  | hd :: tl -> x :: forward_propagation tl (Array.map sigm (mul_vec_mat x hd))
  | [] -> [x]
                 
let rec backward_propagation net (x, y) =
  let grad x = x *. (1.0 -. x) in
  let rec propagate net out y =
    match net, out with
    | [], [o] -> ((y -- o) ** (Array.map grad o), [])
    | w :: wtl, o :: otl ->
       let d, dwtl = propagate wtl otl y in
       let d' = (mul_mat_vec w d) ** (Array.map grad o) in
       let dw = mul_vec_vec o d in
       (d', dw::dwtl)
    | _ -> assert false
  in
  snd (propagate net (forward_propagation net x) y)

let rec init_net layers =
  match layers with
  | hd1 :: hd2 :: tl -> 
     let w = init hd1 hd2 (fun i j -> -1.0 +. (Random.float 2.0)) in
     w :: (init_net (hd2::tl))
  | _ -> []

let error_single net (x, y) =
  let diff = (last (forward_propagation net x)) -- y in
  sum (diff ** diff)

let error net dataset =
  let total = sum (Array.map (error_single net) dataset) in
  total /. float_of_int (Array.length dataset)


type algorithm_type = Batch | Stohastic | MiniBatch
                                              
let fit ?(alg_type=Batch) 
        ?(layers=[])
        ?(max_iter=10_000)
        ?(eps=1e-3)
        ?(rate=0.2)
        ?(verbose=false)
        dataset =
  assert (List.length dataset > 0);

  let dataset = List.map (fun (x, y) -> (Array.append [|1.0|] x, y)) dataset in
  let dataset = Array.of_list dataset in
  let n = Array.length dataset in

  let g = match alg_type with Batch -> n | Stohastic -> 1 | MiniBatch -> 2 in

  let ins = Array.length (fst dataset.(0)) in
  let outs = Array.length (snd dataset.(0)) in
  let layers = ins :: layers @ [outs] in

  let net = ref (init_net layers) in
  let iter = ref 0 in
  let cur = ref 0 in
  while !iter < max_iter && error !net dataset > eps; do
    if verbose then Printf.eprintf "iter = %d, E = %f\n%!" !iter (error !net dataset);

    let add_nets a b = List.map2 add_mat_mat a b in
    let net' = ref !net in
    for i = 1 to g do
      let dw = backward_propagation !net dataset.(!cur) in
      net' := add_nets !net' (List.map (scale_mat rate) dw);
      cur := (!cur + 1) mod n
    done;
    net := !net';
    iter := !iter + 1
  done;
  !net

let predict net x = last (forward_propagation net (Array.append [|1.0|] x))
