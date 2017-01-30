#lang racket

;此题很巧妙，通过构造一个变换Tpq 作用于对偶，使得两次变换的
;这个变换 Tpq选用 a <- bq + aq + ap; b <- bp + aq
;证明很简单，作用两次变换，并因式分解与合并得到：
; a2 <- b0(2pq + qq) + a0(2pq + qq) + a0(pp + qq)
; b2 <- b0(pp + qq) + a0(2pq + qq)
; 证明容易，难点在为什么会选取这样一个Tpq使得此式子恰好成立，而此题已给出了本式

(define (fib n)
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count) (fib-iter a b
                                   (+ (* p p) (* q q))
                                   (+ (* 2 p q) (* q q))
                                   (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
  (fib-iter 1 0 0 1 n))

(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
(fib 9)
