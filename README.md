<div align="center">
    <h1>SokobanMASM32</h1>
    <p><em>Sokoban written in x86 assembly</em></p>
    <img src="screenshot.png">
</div>

## Compile

Install [MASM32 SDK](https://www.masm32.com/) to `C:\masm32`, then run

```sh
ml /coff sokoban.asm /link /subsystem:console
```

## Run

Run `sokoban.exe` in an ANSI terminal such as [Windows Terminal](https://aka.ms/terminal), [Fluent Terminal](https://apps.microsoft.com/store/detail/fluent-terminal/9P2KRLMFXF9T) or [ConEmu](https://conemu.github.io/). The default Console Window Host (`conhost.exe`) is not supported.

## License

SokobanMASM32 is licensed under the [MIT license](https://opensource.org/licenses/MIT).
