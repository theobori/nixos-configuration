{ inputs, ... }:

_final: prev: { fast-anime = inputs.fast-anime.packages.${prev.system}.default; }
