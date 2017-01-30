#lang racket

(define (expt b n)
  (define (expt-iter b n p)
    (if (= n 0)
      p
      (expt-iter b (- n 1) (* p b))))
  (expt-iter b n 1))

(expt 2 2)
(expt 2 3)
(expt 2 4)
(expt 2 5)
(expt 2 6)
(expt 3 2)
;以上迭代算法，时间复杂度O(n) 空间复杂度O(1), 但可以进一步优化

;例如2的8次方可以 2*2=4 4*4=16 16*16=256，最快只需O(log2(n))步

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x) (* x x))

(fast-expt 2 2)
(fast-expt 2 3)
(fast-expt 2 4)
(fast-expt 2 5)
(fast-expt 2 6)
(fast-expt 3 2)
