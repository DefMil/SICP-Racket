#lang racket
(require rackunit)

;Church numerals representation
;numbers as functions
(define zero (lambda (func) (lambda (x) x)))
(define one (lambda (func) (lambda (x) (func x))))
(define two (lambda (func) (lambda (x) (func (func x)))))

;adding 1
(define (add-1 fnum)
  (lambda (func) (lambda (x) (func ((fnum func) x)))))
;addition
(define (+ fnum1 fnum2)
     (lambda (func) (lambda (x) ((fnum1 func) ((fnum2 func) x))))
)

;tests
(define three (+ one two))
(check-equal? ((three sqr) 2)      256 "Not equal");(((2)^2)^2)^2
(check-equal? ((two sqr) 2)         16 "Not equal");((2)^2)^2
(check-equal? (((add-1 one) sqr) 2) 16 "Not equal");((2)^2)^2
(check-equal? ((one sqr) 2)          4 "Not equal");(2)^2
(check-equal? ((zero sqr) 2)         2 "Not equal");(2)