(declare-sort Nat)
(declare-sort NatSeq)
(declare-sort Map)
(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)
(declare-fun one () Nat)
(declare-fun two () Nat)
(declare-fun three () Nat)
(declare-fun four () Nat)
(declare-fun five () Nat)
(declare-fun six () Nat)
(declare-fun seven () Nat)
(declare-fun eight () Nat)
(declare-fun nine () Nat)
(declare-fun ten () Nat)
(declare-fun epsilon () NatSeq)
(declare-fun cncat (Nat NatSeq) NatSeq)
(declare-fun emp () Map)
(declare-fun total_mapsto (Nat Nat) Map)
(declare-fun total_merge (Map Map) Map)
(declare-fun total_mapstoseq (Nat NatSeq) Map)
(declare-fun delta_mapsto (Nat Nat) Bool)
(declare-fun delta_merge (Map Map) Bool)
(declare-fun delta_mapstoseq (Nat NatSeq) Bool)
(declare-fun pi_list (Nat NatSeq Map) Bool)
(assert (= one (succ zero)))
(assert (= two (succ one)))
(assert (= three (succ two)))
(assert (= four (succ three)))
(assert (= five (succ four)))
(assert (= six (succ five)))
(assert (= seven (succ six)))
(assert (= eight (succ seven)))
(assert (= nine (succ eight)))
(assert (= ten (succ nine)))
(assert (forall ((x Nat) (y Nat)) (= (= (succ x) (succ y)) (= x y))))
(assert (forall ((x Nat)) (not (= (succ x) x))))
(assert (forall ((x Nat) (s NatSeq)) (not (= (cncat x s) s))))
(assert (forall ((x1 Nat) (x2 Nat) (s1 NatSeq) (s2 NatSeq)) (= (= (cncat x1 s1) (cncat x2 s2)) (and (= x1 x2) (= s1 s2)))))
(assert (forall ((y Nat)) (not (delta_mapsto zero y))))
(assert (forall ((x Nat) (y Nat)) (delta_mapsto (succ x) y)))
(assert (forall ((x1 Nat) (x2 Nat) (y1 Nat) (y2 Nat)) (= (and (= (delta_mapsto (succ x1) y1) (delta_mapsto (succ x2) y2)) (=> (or (delta_mapsto (succ x1) y1) (delta_mapsto (succ x2) y2)) (= (total_mapsto (succ x1) y1) (total_mapsto (succ x2) y2)))) (and (= x1 x2) (= y1 y2)))))
(assert (forall ((h1 Map) (h2 Map)) (= (delta_merge h1 h2) (delta_merge h2 h1))))
(assert (forall ((h1 Map) (h2 Map)) (=> (or (delta_merge h1 h2) (delta_merge h2 h1)) (= (total_merge h1 h2) (total_merge h2 h1)))))
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) (= (and (delta_merge (total_merge h1 h2) h3) (delta_merge h1 h2)) (and (delta_merge h1 (total_merge h2 h3)) (delta_merge h2 h3)))))
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) (=> (or (and (delta_merge (total_merge h1 h2) h3) (delta_merge h1 h2)) (and (delta_merge h1 (total_merge h2 h3)) (delta_merge h2 h3))) (= (total_merge (total_merge h1 h2) h3) (total_merge h1 (total_merge h2 h3))))))
(assert (forall ((h Map) ($89 Map)) (= (= $89 h) (and (delta_merge h emp) (= $89 (total_merge h emp))))))
(assert (forall ((x Nat) (y Nat) (z Nat)) (not (and (delta_merge (total_mapsto x y) (total_mapsto x z)) (delta_mapsto x y) (delta_mapsto x z)))))
(assert (forall ((x Nat) ($100 Map)) (= (and (delta_mapstoseq x epsilon) (= $100 (total_mapstoseq x epsilon))) (= $100 emp))))
(assert (forall ((x Nat) (y Nat) (s NatSeq)) (= (delta_mapstoseq x (cncat y s)) (and (delta_merge (total_mapsto x y) (total_mapstoseq (succ x) s)) (delta_mapsto x y) (delta_mapstoseq (succ x) s)))))
(assert (forall ((x Nat) (y Nat) (s NatSeq)) (=> (or (delta_mapstoseq x (cncat y s)) (and (delta_merge (total_mapsto x y) (total_mapstoseq (succ x) s)) (delta_mapsto x y) (delta_mapstoseq (succ x) s))) (= (total_mapstoseq x (cncat y s)) (total_merge (total_mapsto x y) (total_mapstoseq (succ x) s))))))
(assert (forall ((x Nat) ($117 Map)) (= (pi_list x epsilon $117) (and (= $117 emp) (= x zero)))))
(assert (forall ((x Nat) (y Nat) (s NatSeq) ($122 Map)) 
  (= (pi_list x (cncat y s) $122) 
     (exists ((z Nat) ($128 Map)) 
       (and (delta_merge (total_mapstoseq x (cncat y (cncat z epsilon))) $128) 
            (= $122 (total_merge (total_mapstoseq x (cncat y (cncat z epsilon))) $128)
            (delta_mapstoseq x (cncat y (cncat z epsilon))) 
            (pi_list z s $128))))))
(assert (forall (($137 Map)) (not (=> (and (delta_merge (total_mapsto seven nine) (total_merge (total_mapsto eight one) (total_merge (total_mapsto two zero) (total_mapsto one five)))) (= $137 (total_merge (total_mapsto seven nine) (total_merge (total_mapsto eight one) (total_merge (total_mapsto two zero) (total_mapsto one five))))) (delta_mapsto seven nine) (delta_merge (total_mapsto eight one) (total_merge (total_mapsto two zero) (total_mapsto one five))) (delta_mapsto eight one) (delta_merge (total_mapsto two zero) (total_mapsto one five)) (delta_mapsto two zero) (delta_mapsto one five)) (pi_list seven (cncat nine (cncat five epsilon)) $137)))))
(check-sat)

