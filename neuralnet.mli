type t

type algorithm_type = Batch | Stohastic | MiniBatch

val fit :
  ?alg_type:algorithm_type ->
  ?layers:int list ->
  ?activation:Activation.t ->
  ?max_iter:int ->
  ?eps:float ->
  ?rate:float ->
  ?verbose:bool ->
  (float list * float list) list ->
  t
              
val predict : t -> float list -> float list
