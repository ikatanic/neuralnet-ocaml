type t =
  { f  : float -> float
  ; df : float -> float
  }

let create ~f ~df = {f; df}
                      
let sigmoid =
  let f x = 1. /. (1. +. (exp (-.x))) in
  let df fx = fx *. (1. -. fx) in
  create ~f ~df


let tanh =
  (* let f = tanh in *)
  let f = tanh in
  let df fx = 1. -. fx *. fx in
  create ~f ~df

let f t = t.f

let df t = t.df

                    
