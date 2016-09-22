#lang plai

;; Tipo de dato abstracto FWAE para representar el árbol de sintaxis abstracta.
;; El lenguaje FWAE reconoce expresiones numéricas, operaciones binarias,
;; asignaciones locales, identificadores, funciones anónimas (lambdas) y 
;; aplicación de funciones.
(define-type FWAE
   [num (n number?)]
   [binop (f procedure?) (l FWAE?) (r FWAE?)]
   [with (name-value (listof Binding?)) (body FWAE?)] ; modificar este constructor
   [id (name symbol?)]
   [fun (param (listof symbol?)) (body FWAE?)] ; modificar este constructor
   [app (fun-expr FWAE?) (arg-expr (listof FWAE?))])

(define-type Binding
  [binding (name symbol?) (value FWAE?)])