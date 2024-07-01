{ lib
, libarchive
, buildDotnetModule
, buildLuarocksPackage
, luaOlder
, luaAtLeast
, fetchfossil
, fetchFromGitHub
, curl
, love
, luajitPackages
}: buildDotnetModule rec {

  pname = "olympus";
  version = "24.06.12.02";
  commit = "33861a4d5867150d23e340b9fa05990794c25481";

  lsqlite3 = buildLuarocksPackage {
    pname = "lsqlite3";
    version = "0.9.6-1";

    buildInputs = [ 
    ]; 

    disabled = (luaOlder "5.1") || (luaAtLeast "5.5");

    src = fetchfossil {
      url = "http://lua.sqlite.org/index.cgi/zip/fc2c936875/LuaSQLite3-fc2c936875.zip";
      rev = "fc2c936875fe1cfa";
      sha256 = "sha256-Mq409A3X9/OS7IPI/KlULR6ZihqnYKk/mS/W/2yrGBg=";
    };


    meta = {
      homepage = "lua.sqlite.org/";
      longDescription = ''
        lsqlite3 is a thin wrapper around the public domain SQLite3 database engine.
        The lsqlite3 module supports the creation and manipulation of SQLite3 databases.
        After a require('lsqlite3') the exported functions are called with prefix sqlite3.
        However, most sqlite3 functions are called via an object-oriented interface to
        either database or SQL statement objects.
      '';
      maintainers = with lib.maintainers; [ kylelovestoad ];
      license.fullName = "MIT/X11";
    };
  };

  nativeBuildInputs = [
    libarchive
  ];

  buildInputs = [
    curl
    love
    luajitPackages.nfd
    luajitPackages.lua-subprocess
    lsqlite3
  ];

  projectFile = "sharp/Olympus.Sharp.sln";

  executables = [];

  nugetDeps = ./deps.nix;

  preBuild = ''
    echo "${version}" > src/version.txt
  '';

  installPhase = ''
    lib="$out/lib/olympus"
    bin="$out/bin"
    mkdir -p $lib
    mkdir -p $bin

    ln -s $lib/olympus "$bin/olympus"

    find src -type f -exec install -Dm755 "{}" "$lib/{}" \;
    install -Dm755 sharp/bin/Release/net452/* -t "$lib/sharp"

    install -Dm755 olympus.sh "$lib/olympus"
    install -Dm755 find-love.sh "$lib/find-love"

    bsdtar --format zip --strip-components 1 -cf "$lib/olympus.love" src

    # install -Dm644 lib-linux/olympus.desktop "$out/usr/share/applications/olympus.desktop"
    # install -Dm644 src/data/icon.png "$out/usr/share/icons/hicolor/128x128/apps/olympus.png"

    # install -Dm644 LICENSE "$out/usr/share/licenses/${pname}/LICENSE"
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