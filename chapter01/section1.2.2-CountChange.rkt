#lang racket

;这一题分治的思想很巧妙
;具体参见原题 P26
;有许多1美分，5美分，10美分，25美分，50美分，有多少种方式将1美元(100美分)找零
;方法是分治，分成两组
;   一组是所有含1美分的换零方式，那等于余下4种币值组合成99美分的方式，最后递归必有一个终止条件
;   另一组所有不含1美分的换零方式，依然递归进行，将余下币种作为考虑对象
(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)

;以上解法问题在于树形递归，时间复杂度，空间复杂度都很高
;尝试改为尾递归
;TODO
