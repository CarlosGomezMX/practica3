#lang plai

;; Tipo de dato abstracto FWAE para representar el árbol de sintaxis abstracta.
;; El lenguaje FWAE reconoce expresiones numéricas, operaciones binarias,
;; asignaciones locales, identificadores, funciones anónimas (lambdas) y 
;; aplicación de funciones.
(define-type FWAE
   [num (n number?)]
   [binop (f procedure?) (l FWAE?) (r FWAE?)]
   [with (name symbol?) (named-expr FWAE?) (body FWAE?)] ; modificar este constructor
   [id (name symbol?)]
   [fun (param symbol?) (body FWAE?)] ; modificar este constructor
   [app (fun-expr FWAE?) (arg-expr FWAE?)])
