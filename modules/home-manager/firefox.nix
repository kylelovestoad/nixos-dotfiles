{kylib, config, lib, pkgs, inputs, ...}: (cfg: { 
  config = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-beta;

      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
      };

      profiles.${config.home.username} = {

        search.force = true;

        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          
          # adblocking heals the soul
          ublock-origin

          # theming
          stylus
          firefox-color
          darkreader
          nighttab

          # userscripts
          violentmonkey
          
          # youtube
          dearrow
          sponsorblock
          youtube-shorts-block
        ];

        bookmarks = [
          {
            name = "Nix Sites";
            toolbar = true;
            bookmarks = [
              {
                name = "nixos";
                tags = [ "nix" ];
                url = "https://nixos.org/";
              }
              {
                name = "nixos wiki";
                tags = [ "wiki" "nix" ];
                url = "https://wiki.nixos.org/";
              }
              {
                name = "nixos forum";
                tags = [ "forum" "nix" ];
                url = "https://discourse.nixos.org/";
              }
              {
                name = "nixpkgs manual";
                tags = [ "wiki" "nix" ];
                url = "https://nixos.org/manual/nixpkgs/stable/";
              }
              {
                name = "nixpkgs github";
                tags = [ "repo" "nix" ];
                url = "https://github.com/NixOS/nixpkgs/";
              }
            ];
          }
          {
            name = "nix firefox extensions";
            tags = [ "repo" "nix" "firefox" ];
            url = "https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/";
          }
          {
            name = "Catppuccin";
            toolbar = true;
            bookmarks = [
              {
                name = "catppuccin";
                tags = [ "theming" "catppuccin" ];
                url = "https://catppuccin.com/";
              }
              {
                name = "catppuccin github";
                tags = [ "theming" "catppuccin" "repo" ];
                url = "https://github.com/catppuccin";
              }
              {
                name = "catppuccin nix";
                tags = [ "theming" "catppuccin" "repo" "nix" ];
                url = "https://github.com/catppuccin/nix";
              }
            ];
          }
          {
            name = "Email";
            toolbar = false;
            bookmarks = [
              {
                # Trying to transition away from this
                name = "gmail";
                tags = [ "email" ];
                url = "https://mail.google.com";
              }
              {
                name = "protonmail";
                tags = [ "email" ];
                url = "https://mail.proton.me";
              }
            ];
          }
        ];

        search.default = "DuckDuckGo";

        # Nix search engines are very useful when making nix code for this config/nixpkgs
        search.engines = let 
          nix-icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        in {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nix-icon;
            definedAliases = ["@np"];
          };

          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "options";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nix-icon;
            definedAliases = ["@no"];
          };


          "NixOS Forum" = {
            urls = [
              {
                template = "https://discourse.nixos.org/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nf"];
          };

          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "release";
                    value = "master";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];
          };

          "Catppuccin Ports" = {
            urls = [
              {
                template = "https://catppuccin.com/ports";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@c"];
          };

          "Github" = {
            urls = [
              {
                template = "https://github.com/search?q=test&type=repositories";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "type";
                    value = "repositories";
                  }
                ];
              }
            ];
            definedAliases = ["@gh"];
          };

        };

        settings = {
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          # "browser.startup.homepage" = "https://start.duckduckgo.com";

          # taken from Misterio77's config
          "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
          "dom.security.https_only_mode" = true;
          "identity.fxaccounts.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          "signon.rememberSignons" = false;
        };
      };
    };
  };
})