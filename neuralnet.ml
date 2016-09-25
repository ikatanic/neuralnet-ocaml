open Util

type t =
  { w : matrix list
  ; act : Activation.t
  }

let forward_propagation t x =
  let activate = Array.map (Activation.f t.act) in
  let rec propagate w x =
    match w with
    | hd :: tl -> x :: propagate tl (activate (mul_vec_mat x hd))
    | [] -> [x]
  in
  propagate t.w x

let backward_propagation t (x, y) =
  let gradient = Array.map (Activation.df t.act) in
  let rec propagate w out y =
    match w, out with
    | [], [o] -> ((y -- o) ** (gradient o), [])
    | w :: wtl, o :: otl ->
       let d, dwtl = propagate wtl otl y in
       let d' = (mul_mat_vec w d) ** (gradient o) in
       let dw = mul_vec_vec o d in
       (d', dw::dwtl)
    | _ -> assert false
  in
  snd (propagate t.w (forward_propagation t x) y)

let rec init_weights layers =
  match layers with
  | hd1 :: hd2 :: tl ->
     let w = init hd1 hd2 (fun i j -> -1.0 +. (Random.float 2.0)) in
     w :: (init_weights (hd2::tl))
  | _ -> []

let error_single t (x, y) =
  let diff = (last (forward_propagation t x)) -- y in
  sum (diff ** diff)

let error t dataset =
  let total = sum (Array.map (error_single t) dataset) in
  total /. float_of_int (Array.length dataset)


type algorithm_type = Batch | Stohastic | MiniBatch

let fit ?(alg_type=Batch)
        ?(layers=[])
        ?(activation=Activation.sigmoid)
        ?(max_iter=10_000)
        ?(eps=1e-3)
        ?(rate=0.2)
        ?(verbose=false)
        dataset =
  assert (List.length dataset > 0);

  let dataset = List.map (fun (x, y) -> Array.of_list (1.0::x), Array.of_list y) dataset in
  let dataset = Array.of_list dataset in
  let n = Array.length dataset in

  let g =
    match alg_type with
    | Batch -> n
    | Stohastic -> 1
    | MiniBatch -> 2
  in

  let ins = Array.length (fst dataset.(0)) in
  let outs = Array.length (snd dataset.(0)) in
  let layers = ins :: layers @ [outs] in

  let rec loop t iters cur =
    if iters <= 0 || error t dataset <= eps
    then t
    else
      let rec batch_loop rem cur acc =
        if rem <= 0
        then acc
        else
          let add_weights w1 w2 = List.map2 add_mat_mat w1 w2 in
          let dw = backward_propagation t dataset.(cur) in
          let acc = add_weights acc (List.map (scale_mat rate) dw) in
          batch_loop (rem - 1) ((cur + 1) mod n) acc
      in
      let t = {t with w = batch_loop g cur t.w} in
      loop t (iters - 1) ((cur + g) mod n)
  in

  let t = {w = init_weights layers; act = activation} in
  loop t max_iter 0

let predict t x =
  1.0::x
  |> Array.of_list
  |> forward_propagation t
  |> last
  |> Array.to_list
