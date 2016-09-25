type t

val create : f:(float -> float) -> df:(float -> float) -> t
                      
val sigmoid : t

val tanh : t

val f : t -> float -> float

val df : t -> float -> float
