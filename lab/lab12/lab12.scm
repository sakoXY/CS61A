(define (tail-replicate x n) 
  (define (tail-replicate-recursion x n lst)
    (cond ((= n 0) lst)
          (else (tail-replicate-recursion x (- n 1) (cons x lst)))
    )
  )
  (tail-replicate-recursion x n nil)
)

(define-macro (def func args body)
  `(define ,func (lambda ,args ,body)))

(define (repeatedly-cube n x)
  (if (zero? n)
      x
      (let ((y (repeatedly-cube (- n 1) x)))
        (* y y y))))
