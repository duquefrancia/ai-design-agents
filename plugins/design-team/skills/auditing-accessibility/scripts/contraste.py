#!/usr/bin/env python3
"""Ratio de contraste WCAG entre dos colores hex.

Uso: python3 scripts/contraste.py "#767676" "#ffffff"
"""
import sys


def _canal(c: float) -> float:
    c = c / 255
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def luminancia(hex_color: str) -> float:
    h = hex_color.strip().lstrip("#")
    if len(h) == 3:
        h = "".join(ch * 2 for ch in h)
    if len(h) != 6:
        raise ValueError(f"Color no válido: {hex_color}")
    r, g, b = (int(h[i:i + 2], 16) for i in (0, 2, 4))
    return 0.2126 * _canal(r) + 0.7152 * _canal(g) + 0.0722 * _canal(b)


def ratio(a: str, b: str) -> float:
    la, lb = sorted((luminancia(a), luminancia(b)), reverse=True)
    return (la + 0.05) / (lb + 0.05)


def main() -> None:
    if len(sys.argv) != 3:
        sys.exit('Uso: contraste.py "#primerplano" "#fondo"')
    r = ratio(sys.argv[1], sys.argv[2])
    ok = lambda umbral: "pasa" if r >= umbral else "no pasa"
    print(f"Ratio: {r:.2f}:1")
    print(f"Texto normal (4,5:1): {ok(4.5)}")
    print(f"Texto grande / componentes (3:1): {ok(3.0)}")


if __name__ == "__main__":
    main()
