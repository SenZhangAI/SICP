#lang racket

(define (double x) (+ x x))

(define (halve x) (/ x 2))

(define (mult a b)
  (define (iter res a b)
    (cond ((= b 0) res)
          ((even? b) (iter res (double a) (halve b)))
          (else (iter (+ res a) a (- b 1)))))
  (iter 0 a b))

(mult 2 4)
(mult 3 5)
(mult 2 5)
(mult 7 8)
(mult 9 10)
(mult 15 15)
