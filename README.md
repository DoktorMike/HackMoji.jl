# HackMoji 

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://DoktorMike.github.io/HackMoji.jl/stable) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://DoktorMike.github.io/HackMoji.jl/dev) [![Build Status](https://github.com/DoktorMike/HackMoji.jl/workflows/CI/badge.svg)](https://github.com/DoktorMike/HackMoji.jl/actions) [![Build Status](https://travis-ci.org/DoktorMike/HackMoji.jl.svg?branch=master)](https://travis-ci.org/DoktorMike/HackMoji.jl)

## Introduction

The purpose behind Hack-Moji is to use a fun a stimulating way of learning
computer programming for my children Hamiltonian and Valerian.

I will add fun and useful examples here as I go.

## Examples

These examples are taken from the [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck#Examples) wikipedia article.

### Hello World!

This is the classic "Hello World!" example from so many programming languages.

```julia
runme("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")
```

### Add two input numbers together

```julia
addtwo = """
,                                                     Input first number
------------------------------------------------      Make the number character into a real number
>                                                     Move to cell 1
,                                                     Input second number
------------------------------------------------      Remove 48 from character
<                                                     Move to cell 0
[>+<-]                                                Loop where we decrease the number in cell 0 and increase in cell 1
>                                                     Move to cell 1
++++++++++++++++++++++++++++++++++++++++++++++++      Convert the number to a character number
.                                                     Print the result
"""
runme(addtwo)
```

### Add 5 + 2

This example produces 7 by adding 5 + 2.

```julia
addme = """
++       Cell c0 = 2
> +++++  Cell c1 = 5
[        Start your loops with your cell pointer on the loop counter (c1 in our case)
< +      Add 1 to c0
> -      Subtract 1 from c1
]        End your loops with the cell pointer on the loop counter
At this point our program has added 5 to 2 leaving 7 in c0 and 0 in c1
but we cannot output this value to the terminal since it is not ASCII encoded!
To display the ASCII character "7" we must add 48 to the value 7
48 = 6 * 8 so let's use another loop to help us!
++++ ++++  c1 = 8 and this will be our loop counter again
[
< +++ +++  Add 6 to c0
> -        Subtract 1 from c1
]
< .        Print out c0 which has the value 55 which translates to "7"!
"""
runme(addme)
```

### ROT13 encryption

```julia
mycode = """
-,+[                         Read first character and start outer character reading loop
    -[                       Skip forward if character is 0
        >>++++[>++++++++<-]  Set up divisor (32) for division loop
                               (MEMORY LAYOUT: dividend copy remainder divisor quotient zero zero)
        <+<-[                Set up dividend (x minus 1) and enter division loop
            >+>+>-[>>>]      Increase copy and remainder / reduce divisor / Normal case: skip forward
            <[[>+<-]>>+>]    Special case: move remainder back to divisor and increase quotient
            <<<<<-           Decrement dividend
        ]                    End division loop
    ]>>>[-]+                 End skip loop; zero former divisor and reuse space for a flag
    >--[-[<->+++[-]]]<[         Zero that flag unless quotient was 2 or 3; zero quotient; check flag
        ++++++++++++<[       If flag then set up divisor (13) for second division loop
                               (MEMORY LAYOUT: zero copy dividend divisor remainder quotient zero zero)
            >-[>+>>]         Reduce divisor; Normal case: increase remainder
            >[+[<+>-]>+>>]   Special case: increase remainder / move it back to divisor / increase quotient
            <<<<<-           Decrease dividend
        ]                    End division loop
        >>[<+>-]             Add remainder back to divisor to get a useful 13
        >[                   Skip forward if quotient was 0
            -[               Decrement quotient and skip forward if quotient was 1
                -<<[-]>>     Zero quotient and divisor if quotient was 2
            ]<<[<<->>-]>>    Zero divisor and subtract 13 from copy if quotient was 1
        ]<<[<<+>>-]          Zero divisor and add 13 to copy if quotient was 0
    ]                        End outer skip loop (jump to here if ((character minus 1)/32) was not 2 or 3)
    <[-]                     Clear remainder from first division if second division was skipped
    <.[-]                    Output ROT13ed character from copy and clear it
    <-,+                     Read next character
]                            End character reading loop
"""
runme(mycode)
```
