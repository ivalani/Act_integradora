#|
Andrea Serrano Diego - A01028728
Iwalani Amador Piaga - A01732251
Daniel Sanchez Sanchez - A0178575
|#

#lang racket

; Find tokens and replace them with what's necessary
(define (replace-match in-path)
  ; Store the content in lines (string list)
  (define lines (file->lines in-path))
  (let loop
    ([lines lines] [res empty])
    (if (null? lines)
        ; if empty, return res
        res
        ; if not empty, do this        
        (let* 
          ([dis-line (car lines)]
            ; Find all chars with regex and replace them with html format
            [dis-line (regexp-replace* #px"'[\\w\\W]'" dis-line "<span class='chars'>&</span>")]
            ; Find all booleans with regex and replace them with html format
            [dis-line (regexp-replace* #px"\\b(?:true|false|null)\\b(?=([^\"]*\"[^\"]*\")*[^\"]*$)" dis-line "<span class='bool'>&</span>")]
            ; Find all strings with regex and replace them with html format
            [dis-line (regexp-replace* #px"\"(.*?)\"" dis-line "<span class='string'>&</span>")]
            ; Find all keys with regex and replace them with html format
            [dis-line (regexp-replace* #px"(<span class='strings'>)(.*?)(<\\/span>)([\\s]*:)" dis-line "<span class='object-key'>\\2</span>\\4")]
            ; Find all the reserved words with regex and replace them with html format
            [dis-line (regexp-replace* #px"((?<![\\w])[:])(?=([^\"]*\"[^\"]*\")*[^\"]*$)|[,\\[\\]{}](?=([^\"]*\"[^\"]*\")*[^\"]*$)" dis-line "<span class='reserved_word'>&</span>")]
            ; Find all numbers with regex and replace them with html format
            [dis-line (regexp-replace* #px"((?<= )-?(?:0|[1-9]\\d*)(?:\\.\\d+)?(?:[eE][+\\-]?\\d+)?)(?=([^\"]*\"[^\"]*\")*[^\"]*$)" dis-line "<span class='number'>&</span>")]
            ; changes tabs to spaces, so we don't have indentation problems
            [dis-line (regexp-replace* #rx"[\t]" dis-line "    ")])
          ; go to the next line of the document
          (loop (cdr lines) (append res (list dis-line))) ))))

; Create highlighted syntax HTML file for one JSON file
(define (write-file in-path)
  (define out-path
    (regexp-replace #px"(?<=\\/)(.*?).json" in-path "../results/\\1.html"))
  ; Add HTML to the top
  (call-with-output-file out-path #:exists 'truncate
    (lambda (out)
      (display "<!DOCTYPE html>
        <html lang=\"en\">
        <head>
            <meta charset=\"UTF-8\">
            <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
            <title>JSON Highlighter</title>
            <link rel=\"stylesheet\" href=\"./token_colors.css\">
        </head>
        <body> 
        <h1>JSON Highlighter Racket version </h1>" 
        out)))
  
  ; Add highlighted syntax
  (display-lines-to-file (replace-match in-path) out-path #:exists 'append))

; Create highlighted syntax HTML file given a directory with JSON files
(define (write-files dir-path)
  ; Create results directory (if it doesn't exist)
  (if (not (directory-exists? "results"))
    (make-directory "results")
    #f)
  
  (let loop
    ; Get all files from directory
    ([files (map path->string (directory-list dir-path))] [dir dir-path])
    (cond
      [(empty? files)]
      [else
        (write-file (string-append dir "/" (car files)))
        (loop (cdr files) dir)])))

(define (make-threads files dir-path)
  (list (future (lambda ()
    ; Iterate files and call write-file
    (let loop
      ([lst files])
        (cond
          [(empty? lst)]
          [else
            (write-file (string-append dir-path "/" (car lst)))
            (loop (cdr lst))]))))))
; Concurrent execution
(define (write-files-parallel dir-path threads)
  ; Create results directory (if it doesn't exist)
  (if (not (directory-exists? "results"))
    (make-directory "results")
    #f)
  ; Get all filenames
  (define files (map path->string (directory-list dir-path)))
  ; Distribute files among files user indicated
  (let loop 
    ( [files files] [futures empty] [counter 1] [total-files (length files)])
    (cond
      [(empty? files) 
        (for-each touch futures)]
      ; Add all groups of files that are the same size
      [(< counter threads)
        (let-values ([(head tail)  (split-at files (- (length files) (floor (/ total-files threads))))]) 
          (loop head (append futures (make-threads tail dir-path)) (add1 counter) total-files))]
      ; Add final group of files
      [(= counter threads)
        (loop empty (append futures (make-threads files dir-path)) counter total-files)])))


  ; Measure execution time for the whole algorithm, takes in "<filename>.json"
(define (timer doc)
  (define begin (current-inexact-milliseconds))
  (write-file doc "result.html")
  (- (current-inexact-milliseconds) begin))

; Measure execution time for the replace-match function, takes in "<filename>.json"
(define (timer2 doc)
  (define begin (current-inexact-milliseconds))
  (replace-match doc)
  (- (current-inexact-milliseconds) begin))
