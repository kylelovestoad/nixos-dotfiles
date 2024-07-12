{ stdenv
, lib 
, libusb
, fetchFromGitHub
, pkg-config
}: stdenv.mkDerivation {
  name = "mouse_m908";
  version = "3.4";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libusb.dev ];

  installPhase = ''
    mkdir -p $out/bin \
            $out/share/doc \
            $out/share/man/man1 \
            $out/share/doc/mouse_m908 \
            $out/lib/udev/rules.d

    cp mouse_m908 $out/bin/mouse_m908 && \
    cp mouse_m908.rules $out/lib/udev/rules.d && \
    cp examples/* $out/share/doc/mouse_m908 && \
    cp README.md $out/share/doc/mouse_m908 && \
    cp keymap.md $out/share/doc/mouse_m908 && \
    cp mouse_m908.1 $out/share/man/man1
  '';

  src = fetchFromGitHub {
    owner = "dokutan";
    repo = "mouse_m908";
    rev = "6e48ff76cfe2e199215e4c9a916fbc34619ab227";
    sha256 = "sha256-sCAvjNpJYkp4G0KkDJtHOBR1vc80DZJtWR2W9gakkzQ=";
  };

  meta = with lib; {
    homepage = "https://github.com/dokutan/mouse_m908";
    description = "Control various Redragon gaming mice from Linux, BSD and Haiku";
    mainProgram = "mouse_m908";
    license = with licenses; [ gpl3Only ];
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ kylelovestoad ];
  };
}