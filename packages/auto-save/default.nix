{
  lib,
  fetchFromGitHub,
  emacsPackages,
}:
emacsPackages.melpaBuild {
  pname = "auto-save";
  version = "0-unstable-2023-10-25";

  src = fetchFromGitHub {
    owner = "manateelazycat";
    repo = "auto-save";
    rev = "0fb3c0f38191c0e74f00bae6adaa342de3750e83";
    hash = "sha256-MCa28kGMBKLA/WqcDgJVtbul//R80nwWuI757wc12KI=";
  };

  meta = {
    homepage = "https://github.com/manateelazycat/auto-save";
    description = "Automatically save files without temporary files to protect your finger";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ theobori ];
  };
}
