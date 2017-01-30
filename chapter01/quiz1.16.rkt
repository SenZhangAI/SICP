#lang racket

(define (fast-expt x n)
  (define (fast-expt-iter res x n)
    (cond ((= n 1) (* res x))
          ((even? n) (fast-expt-iter res (* x x) (/ n 2)))
          (else (fast-expt-iter (* res x) x (- n 1)))))
  (fast-expt-iter 1 x n))

(fast-expt 2 2)
(fast-expt 2 3)
(fast-expt 2 4)
(fast-expt 2 5)
(fast-expt 2 8)
(fast-expt 2 10)
(fast-expt 2 32)
(fast-expt 3 2)
(fast-expt 3 3)
