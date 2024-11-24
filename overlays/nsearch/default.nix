{ inputs, ... }:

_final: prev: { nsearch = inputs.nsearch.packages.${prev.system}.default; }
