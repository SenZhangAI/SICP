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

;以上算法时间复杂度为O(sqrt(n))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;以下是基于费马定理，时间复杂度为O(log(n))，主要在求幂上，费马检查为O(1)
; 如n是素数， 对于任意 a < n, a^n 与 a模n 同余

(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ;这里迭代首先是用快速方法获得 a ^n 最后取余，但看上去有些怪，看上去执行顺序是一步求幂一步取余。。
        ;或者有可能恰好一步求幂一步取余也成立
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (runtime) (current-milliseconds)) ;see http://community.schemewiki.org/?SICP

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  ; when 是没有else的if
  (when (prime? n)
    ;(when (fast-prime? n 5) ; when 是没有else的if
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes first last)
  (define (search-iter cur last)
    (when (<= cur last) (timed-prime-test cur))
    (when (<= cur last) (search-iter (+ cur 2) last)))
  (search-iter (if (even? first) (+ first 1) first)
               (if (even? last) (- last 1) last)))

(search-for-primes 1000000000 1000000021)       ; 1e9
(search-for-primes 10000000000 10000000061)     ; 1e10
(search-for-primes 100000000000 100000000057)   ; 1e11
(search-for-primes 1000000000000 1000000000063) ; 1e12
