{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation (finalAttrs: {
  pname = "acer-predator";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "JafarAkhondali";
    repo = "acer-predator-turbo-and-rgb-keyboard-linux-module";
    rev = "5d4a850b67b5923e3eb5acb514de0a40dc800d84";
    hash = "sha256-8Wa01nB3Peor0GkstetPf8pljY6chYp+GyoA/pqbpuM=";
  };

  hardeningDisable = [ "pic" ];                                             # 1
  nativeBuildInputs = kernel.moduleBuildDependencies;                       # 2

  makeFlags = [                                # 3
    "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"    # 4
    "INSTALL_MOD_PATH=$(out)"                                               # 5
  ];

  meta = {
    description = "Linux kernel module to support Turbo mode and RGB Keyboard for Acer Predator notebook series ";
    homepage = "https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ kylelovestoad ];
    platforms = [ "x86_64-linux" "" ];
  };
})