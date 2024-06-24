{ lib
, stdenv
, libarchive
, buildDotnetModule
, fetchFromGitHub
, makeDesktopItem
, curl
, love
, luajitPackages
, dotnet-sdk
, dotnetPackages
}: buildDotnetModule rec {

  pname = "olympus";
  version = "24.06.12.02";
  commit = "33861a4d5867150d23e340b9fa05990794c25481";


  nativeBuildInputs = [
    dotnet-sdk
    dotnetPackages.Nuget
    libarchive
  ];

  buildInputs = [
    curl
    love
    luajitPackages.nfd
    luajitPackages.lua-subprocess
    luajitPackages.luasql-sqlite3
  ];

  projectFile = "sharp/Olympus.Sharp.sln";

  nugetDeps = ./deps.nix;

  preBuild = ''
    echo "${version}" > src/version.txt
  '';

  installPhase = ''
    lib="$out/usr/lib/olympus"
    bin="$out/usr/bin"
    mkdir -p $lib

    mkdir -p $out/usr/bin
    ln -s $lib/olympus "$bin/olympus"

    find src -type f -exec install -Dm755 "{}" "$lib/{}" \;
    install -Dm755 sharp/bin/Release/net452/* -t "$lib/sharp"

    install -Dm755 olympus.sh "$lib/olympus"
    install -Dm755 find-love.sh "$lib/find-love"

    bsdtar --format zip --strip-components 1 -cf "$lib/olympus.love" src

    install -Dm644 lib-linux/olympus.desktop "$out/usr/share/applications/olympus.desktop"
    install -Dm644 src/data/icon.png "$out/usr/share/icons/hicolor/128x128/apps/olympus.png"

    install -Dm644 LICENSE "$out/usr/share/licenses/${pname}/LICENSE"
  '';

  src = fetchFromGitHub {
    owner = "EverestAPI";
    repo = "Olympus";
    rev = commit;
    sha256 = "sha256-+QCvvUjscBh8IYnLmbmzGvyBHehxMS4vxpwi+KXWs0s=";
    # Required to get OlympUI, moonshine and luajit-request
    fetchSubmodules = true;
  };

  meta = with lib; {
    homepage = "https://github.com/EverestAPI/Olympus";
    description = "New Everest installer / manager, powered by LÖVE / love2d.";
    mainProgram = "olympus";
    license = with licenses; [ mit ];
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ kylelovestoad ];
  };
}