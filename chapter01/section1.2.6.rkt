#lang racket

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square n) (* n n))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(prime? 1)
(prime? 2)
(prime? 3)
(prime? 4)
(prime? 5)
(prime? 7)
(prime? 9)
(prime? 11)
(prime? 13)
(prime? 15)
(prime? 17)

;以上算法时间复杂度为O(sqrt(n))

;以下是基于费马定理，时间复杂度为O(log(n))，主要在求幂上，费马检查为O(1)
; 如n是素数， 对于任意 a < n, a^n 与 a模n 同余

(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ;这里迭代首先是用快速方法获得 a ^n 最后取余，但看上去有些怪，看上去执行顺序是一步求幂一步取余。。
        ;或者有可能恰好一步求幂一步取余也成立
        ;答：这里边求幂边取余是为了使得运算数更小，更大的数求解更耗时
        ((even? exp) (remainder (square (expmod base (/ exp 2) n))
                                n))
        (else (remainder (* base (expmod base (- exp 1) n))
                         n))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (random n))) ; 生成1 到 n 的随机数并测试

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1))) ;如果测试成立，在进行一轮测试，同times次测试
        (else #f)))

(fast-prime? 1 5)
(fast-prime? 2 5)
(fast-prime? 3 5)
(fast-prime? 4 5)
(fast-prime? 5 5)
(fast-prime? 7 5)
(fast-prime? 9 5)
(fast-prime? 11 5)
(fast-prime? 13 5)
(fast-prime? 15 5)
(fast-prime? 17 5)
