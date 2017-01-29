#lang racket

(define (fib n)
  (fib-iter 1 0 n))

; 此过程为迭代过程，可以尾递归优化
(define (fib-iter a b count)
  (if (= count 0)
    b
    (fib-iter (+ a b) a (- count 1))))
