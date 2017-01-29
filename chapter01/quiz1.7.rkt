#lang racket

(define (new-sqrt x)
  (sqrt-iter 1 x))


(define (sqrt-iter guess x)
   (if (good-enough? guess x)
      guess
      (sqrt-iter (better-guess guess x) x)))

;未解决更好的判断，用guess*0.001比较容易，但题中比较旧值与新值较难
(define (good-enough? guess aim)
  (< (abs(- (square guess) aim )) 0.001))

(define (abs x) ((new-if (< x 0) - +) x))

(define (better-guess x y) (average x (/ y x)))

(define (average x y) (/ (+ x y) 2.0))

(define (square x) (* x x))


;如果用new-if代替if,则遇到迭代会无限循环
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(better-guess 4.0 1.0)
(abs -10)
(good-enough? 1.09999999 1.21)
(new-sqrt 1.21)

;极小数
(new-sqrt 0.000000001)
;极大数
(new-sqrt (* 98765432198765.0 98765432198765.0))

;极大值 13个零 会导致无限循环
(new-sqrt 10000000000000)



