#lang racket

;; see http://www.yinwang.org/blog-cn/2012/08/01/interpreter

;; empty environment
(define env0 '())

;; bind x to v
(define ext-env
  (lambda (x v env)
    (cons `(,x . ,v) env)))

;; search x's value in env
(define lookup
  (lambda (x env)
    (let ([p (assq x env)])
      (cond
        [(not p) #f]
        [else (cdr p)]))))

;; define Closure
(struct Closure (f env))

;; interp's Definition
(define interp
  (lambda (exp env)
    (match exp
      [(? symbol? x)                                      ;Case1 Variable
       (let ([v (lookup x env)])
         (cond
           [(not v)
            (error "undefine variable" x)]
           [else v]))]
      [(? number? x) x]                                   ;Case2 Number
      [(? string? x) x]                                   ;Case3 String
      [`(lambda (,x) ,e)                                  ;Case4 Function
       (Closure exp env)]
      [`(let ([,x ,e1]) ,e2)                              ;Case5 Binding
       (let ([v1 (interp e1 env)])
         (interp e2 (ext-env x v1 env)))]
      [`(,e1 ,e2)                                         ;Case6 Calling
       (let ([v1 (interp e1 env)]
             [v2 (interp e2 env)])
         (match v1
           [(Closure `(lambda (,x) ,e) env-save)
            (interp e (ext-env x v2 env-save))]))]
      [`(,op ,e1 ,e2)                                     ;Case7 Expression
       (let ([v1 (interp e1 env)]
             [v2 (interp e2 env)])
         (match op
         ['+ (+ v1 v2)]
         ['- (- v1 v2)]
         ['* (* v1 v2)]
         ['/ (/ v1 v2)]))])))

(define r2
  (lambda (exp)
    (interp exp env0)))

(r2 '(let ([output "Hello World"]) output))
(r2 '(let ([square (lambda (x) (* x x))]) (square 9)))
