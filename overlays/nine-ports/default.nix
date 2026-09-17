{ inputs, ... }:

_final: prev: { nine-ports = inputs.nine-ports.packages.${prev.system}.all; }
