#lang plai

(require "FWAE.rkt")

;; Análisis sintáctico del lenguaje. En analizador sintáctico se encarga de
;; construir el árbol de sintaxis abstracta.

;; Función elige auxiliar.
;; Permite elegir el operador correspondiente en Racket para las operaciones
;; binarias.
;; elige: symbol -> procedure
(define (elige s)
   (case s
      [(+) +]
      [(-) -]
      [(*) *]
      [(/) /]
      [(%) modulo]
      [(max) max]
      [(min) min]
      [(pow) expt]))

;; Analizador sintáctico para FWAE.
;; Dada una expresión en sintaxis concreta, regresa el árbol de sintaxis
;; abstractca correspondiente. Es decir, construye expresiones del tipo de
;; dato abstracto definido anteriormente.
;; parse: symbol -> FWAE
(define (parse sexp)
   (cond
      [(symbol? sexp) (id sexp)] ; para identificadores
      [(number? sexp) (num sexp)] ; para números
     
      [(list? sexp)
          (if (number? (car sexp))
              (map(lambda (x) (parse x)) sexp)
         (case (car sexp)
            [(+ - * - / % max min pow) ; para operaciones binarias
               (binop
                  (elige (car sexp))
                  (parse (cadr sexp))
                  (parse (caddr sexp)))]
            [(with) ; para asignaciones locales MODIFICAR ESTE CASO
               (with
                (if (list? (first (second sexp)))
                  (map (lambda (x) (binding (first x)  (num (second x)))) (second sexp) )
                  (list (binding (first (second sexp))  (num (second (second sexp)))))
                  )
                  (parse (third sexp)))]
            [(fun) ; para lambdas MODIFICAR ESTE CASO
               (fun
                  (second sexp)
                  (parse (caddr sexp)))]
           
            [(number) (map(lambda (x) (parse x)) sexp)]
            [else ; para aplicación de funciones
               (app
                  (parse (first sexp))
                  (parse (rest sexp)))])
         )]))
