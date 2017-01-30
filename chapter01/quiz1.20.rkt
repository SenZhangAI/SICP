; 正则序
; (gcd 206 40)
; (gcd 40 (remainder 40 206))
; (gcd (remainder 40 206) (remainder (remainder 40 206) 206))
; ...
; 无限循环
;
; 错误，实际是在if那里展开，结果为remainder调用18次

; 应用序
; (gcd 206 40)
; (gcd 40 (remainder 40 206))
; (gcd 40 6)
; (gcd 6 (remainder 6 40))
; (gcd 6 4)
; (gcd 4 (remainder 4 6))
; (gcd 4 2)
; (gcd 2 (remainder 2 4))
; (gcd 2 0)
; 四次remainder调用
