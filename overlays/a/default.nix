{ inputs, ... }:

_final: prev: { a = inputs.a.packages.${prev.system}.default; }
