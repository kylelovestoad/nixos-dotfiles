{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}: buildNpmPackage (finalAttrs: {
  pname = "twinejs";
  version = "2.9.2";

  src = fetchFromGitHub {
    owner = "klembot";
    repo = finalAttrs.pname;
    rev = "v${finalAttrs.version}";
    hash = "sha256-BR+ZGkBBfd0dSQqAvujsbgsEPFYw/ThrylxUbOksYxM=";
  };

  meta = {
    description = "A modern web UI for various torrent clients with a Node.js backend and React frontend";
    homepage = "https://twinery.org/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ kylelovestoad ];
  };
})