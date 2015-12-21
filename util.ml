type vector = float array
type matrix = { r : int; c : int; data : float array }

let last l = List.nth l ((List.length l) - 1)
let sum = Array.fold_left (+.) 0.0

let ($) m (r, c) = m.data.(r*m.c + c)

let init r c f = 
  { r=r; c=c; data=Array.init (r*c) (fun i -> f (i/c) (i mod c)) }

let mul_vec_mat vec mat =
  assert ((Array.length vec) = mat.r);
  Array.init mat.c (fun j -> sum (Array.mapi (fun i x -> (mat$(i,j)) *. x) vec))
    
let mul_mat_vec mat vec =
  assert ((Array.length vec) = mat.c);
  Array.init mat.r (fun i -> sum (Array.mapi (fun j x -> (mat$(i,j)) *. x) vec))
    
let mul_vec_vec a b = 
  init (Array.length a) (Array.length b) (fun i j -> a.(i) *. b.(j))

let add_mat_mat a b = 
  assert (a.r = b.r && a.c = b.c);
  init a.r a.c (fun i j -> (a$(i,j)) +. (b$(i,j)))

let scale_mat k a = init a.r a.c (fun i j -> k *. (a$(i,j)))

let map2 f a b = 
  assert ((Array.length a) = (Array.length b));
  Array.init (Array.length a) (fun i -> f a.(i) b.(i))

let ( -- ) a b = map2 ( -. ) a b
let ( ++ ) a b = map2 ( +. ) a b
let ( ** ) a b = map2 ( *. ) a b
