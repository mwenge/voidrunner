# Voidrunner by Jeff Minter
<img src="https://user-images.githubusercontent.com/58846/103489314-9b2daa00-4e0b-11eb-8ba1-3206607f8c19.png" height=300><img src="https://user-images.githubusercontent.com/58846/103489278-4c801000-4e0b-11eb-92e2-db6386d1d4b5.gif" height=300>



This is the disassembled and [commented source code] for the 1987 Commodore 16/Plus 4 game Voidrunner by Jeff Minter. 


## Requirements

* [64tass][64tass], tested with v1.54, r1900
* [VICE][vice]

[64tass]: http://tass64.sourceforge.net/
[vice]: http://vice-emu.sourceforge.net/
[https://voidrunner.xyz]: https://mwenge.github.io/voidrunner.xyz
[commented source code]:https://github.com/mwenge/voidrunner/blob/master/src/voidrunner.asm

To compile and run it do:

```sh
$ make
```
The compiled game is written to the `bin` folder. 

To just compile the game and get a binary (`voidrunner.prg`) do:

```sh
$ make voidrunner
```

