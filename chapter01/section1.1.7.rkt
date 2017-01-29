#lang racket

(define (sqrt x)
  (sqrt-iter 1 x))


(define (sqrt-iter guess x)
   (if (good-enough? guess x)
      guess
      (sqrt-iter (better-guess guess x) x)))

(define (good-enough? guess aim)
  (< (abs(- (square guess) aim )) 0.001))

(define (abs x) ((new-if (< x 0) - +) x))

(define (better-guess x y) (average x (/ y x)))

(define (average x y) (/ (+ x y) 2.0))

(define (square x) (* x x))


;如果用new-if代替if，则遇到迭代会无限循环
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(better-guess 4.0 1.0)
(abs -10)
(good-enough? 1.09999999 1.21)
(sqrt 1.21)

;极小数有问题
(sqrt 0.000000001)
;极大数貌似可以
(sqrt (* 987654321987654321.0 987654321987654321.0))

