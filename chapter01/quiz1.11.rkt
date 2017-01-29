#lang racket

(define (func n)
  (func-iter n))

(define (func-iter n)
  (if (< n 3)
    n
    (+ (func-iter (- n 1))
       (* 2 (func-iter (- n 2)))
       (* 3 (func-iter (- n 3))))))

(func 2)
(func 3)
(func 4)
(func 5)
;以上递归求解时间空间复杂度较高

(define (better-iter n0 n1 n2 count)
  (cond ((= 0 count) n0)
        ((= 1 count) n1)
        ((= 2 count) n2)
        (else (better-iter n1 n2 (+ (* 3 n0) (* 2 n1) n2) (- count 1)))))

(define (better-func n)
  (better-iter 0 1 2 n))

(better-func 2)
(better-func 3)
(better-func 4)
(better-func 5)

;以下为习题解答
(define (f n)
  (define (iter a b c count)
    (if (= count 0)
      a
      (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  (iter 0 1 2 n))

(f 0)
(f 1)
(f 2)
(f 3)
(f 4)
(f 5)
