{ inputs, config, pkgs, shared, ...}:

{
  home-manager.users.${shared.username} = {
    programs.firefox = {
      enable = true;

      profiles.default = {
        isDefault = true;

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          proton-pass
        ];

        search = {
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          engines = {
            "Google".metaData.hidden = true;
            "Bing".metaData.hidden = true;
          };
        };

        settings = {
          # Disable first-launch phase
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowser.checkCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.addedImportButton" = true;

          # Clean new tab page
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

          # Disable telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.search.serpEventTelemetryCategorization.regionEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.usage.uploadEnabled" = false;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # Enforce privacy
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "dom.security.https_only_mode" = true;
          "browser.contentblocking.category" = "strict";
          "places.history.enabled" = false;

          # Clean-up on shutdown
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.learHistory.cookiesAndStorage" = true;
          "privacy.clearHistory.HistoryFormDataAndDownloads" = true;
          "privacy.clearHistory.formdata" = true;
          "privacy.clearHistory.siteSettings" = true;
          "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
          "privacy.clearSiteData.formdata" = true;
          "privacy.clearSiteData.historyFormDataAndDownloads" = true;
          "privacy.clearSiteDataHeader.cache.enabled" = true;
          "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
          "privacy.clearOnShutdown_v2.formdata" = true;

          # Disable Normandy (Mozilla's firefox remote control)
          "app.normandy.first_run" = false;

          # Disable fx accounts
          "identity.fxaccounts.enabled" = false;
          # Disable "save password" prompt
          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "signon.firefoxRelay.feature" = "disabled";
          "signon.generation.enabled" = false;

          # Set dark theme
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "browser.theme.content-theme" = 0;
          "browser.theme.toolbar-theme" = 0;
          "layout.css.prefers-color-scheme.content-override" = 0;

          # Disable translation panel
          "browser.translations.panelShow" = false;

          # Remove unwanted suggestions and shortcuts from URL bar
          "browser.urlbar.suggest.recentsearches" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.suggests.topsites" = false;

          # Always show bookmarks toolbar
          "browser.toolbars.bookmarks.visibility" = "always";

          # Hide sidebar
          "sidebar.visibility" = "hide-sidebar";

          # Hide preview on hover
          "browser.tabs.hoverPreview.showThumbnails" = false;

          # Font
          "font.name.serif.x-western" = "JetbrainsMono Nerd Font";
          "font.size.variable.x-western" = 14;

          # Set default download directory
          "browser.download.dir" = "/home/${shared.username}/downloads";
          "browser.download.folderList" = 2;

          # Disable auto-fill on forms
          "dom.forms.autocomplete.formautofill" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "browser.formfill.enable" = false;
        };

        bookmarks = [
          {
            name = "Bookmarks";
            toolbar = true;
            bookmarks = [
              {
                name = "Perso";
                bookmarks = [
                  {
                    name = "Bluesky";
                    url = "https://bsky.app";
                  }
                  {
                    name = "LinkedIn";
                    url = "https://www.linkedin.com";
                  }
                ];
              }
              {
                name = "GitHub";
                bookmarks = [
                  {
                    name = "yozhgoor";
                    url = "https://github.com/yozhgoor";
                  }
                  {
                    name = "gists";
                    url = "https://gist.github.com/yozhgoor";
                  }
                  {
                    name = "Repos";
                    bookmarks = [
                      {
                        name = "yozhgoor/cargo-temp";
                        url = "https://github.com/yozhgoor/cargo-temp";
                      }
                    ];
                  }
                  {
                    name = "Forks";
                    bookmarks = [
                      {
                        name = "xtask-watch";
                        url = "https://github.com/yozhgoor/xtask-watch";
                      }
                    ];
                  }
                  {
                    name = "Actions";
                    bookmarks = [
                      {
                        name = "actions/checkout";
                        url = "https://github.com/actions/checkout";
                      }
                      {
                        name = "Swatinem/rust-cache";
                        url = "https://github.com/Swatinem/rust-cache";
                      }
                    ];
                  }
                ];
              }
              {
                name = "Rust";
                bookmarks = [
                  {
                    name = "rustup";
                    url = "https://rustup.rs";
                  }
                  {
                    name = "The Rust Book";
                    url = "https://doc.rust-lang.org/stable/book";
                  }
                  {
                    name = "Docs";
                    bookmarks = [
                      {
                        name = "std";
                        bookmarks = [
                          {
                            name = "process";
                            url = "https://doc.rust-lang.org/std/process/index.html";
                          }
                          {
                            name = "vec::Vec";
                            url = "https://doc.rust-lang.org/std/vec/struct.Vec.html";

                          }
                        ];
                      }
                      {
                        name = "libraries";
                        bookmarks = [
                          {
                            name = "anyhow";
                            url = "https://docs.rs/anyhow/latest/anyhow";
                          }
                          {
                            name = "clap";
                            url = "https://docs.rs/clap/latest/clap";
                          }
                          {
                            name = "cargo-metadata";
                            url = "https://docs.rs/cargo_metadata/latest/cargo_metadata";
                          }
                          {
                            name = "directories";
                            url = "https://docs.rs/directories/latest/directories";
                          }
                          {
                            name = "implicit-clone";
                            url = "https://docs.rs/implicit-clone/latest/implicit_clone";
                          }
                          {
                            name = "ctrlc";
                            url = "https://docs.rs/ctrlc/latest/ctrlc";
                          }
                        ];
                      }
                      {
                        name = "frameworks";
                        bookmarks = [
                          {
                            name = "bevy";
                            bookmarks = [
                              {
                                name = "Homepage";
                                url = "https://bevyengine.org";
                              }
                              {
                                name = "GitHub";
                                url = "https://github.com/bevyengine/bevy";
                              }
                              {
                                name = "Documentation";
                                url = "https://docs.rs/bevy/latest/bevy";
                              }
                            ];
                          }
                          {
                            name = "serde";
                            bookmarks = [
                               {
                                name = "Homepage";
                                url = "https://serde.rs";
                              }
                              {
                                name = "GitHub";
                                url = "https://github.com/serde-rs/serde";
                              }
                              {
                                name = "Documentation";
                                url = "https://docs.rs/serde/latest/serde";
                              }
                            ];
                          }
                          {
                            name = "tokio";
                            bookmarks = [
                               {
                                name = "Homepage";
                                url = "https://tokio.rs";
                              }
                              {
                                name = "GitHub";
                                url = "https://github.com/tokio-rs/tokio";
                              }
                              {
                                name = "Documentation";
                                url = "https://docs.rs/tokio/latest/tokio";
                              }
                              {
                                name = "hyper";
                                url = "https://docs.rs/hyper/latest/hyper";
                              }
                              {
                                name = "tower";
                                url = "https://docs.rs/tower/latest/tower";
                              }
                            ];
                          }
                          {
                            name = "log";
                            bookmarks = [
                              {
                                name = "Documentation";
                                url = "https://docs.rs/log/latest/log";
                              }
                              {
                                name = "env-logger";
                                url =
                                "https://docs.rs/env_logger/latest/env_logger";
                              }
                            ];
                          }
                        ];
                      }
                    ];
                  }
                  {
                    name = "Examples";
                    bookmarks = [
                      {
                        name = "Display";
                        url = "https://doc.rust-lang.org/rust-by-example/hello/print/print_display.html";
                      }
                    ];
                  }
                  {
                    name = "Tools";
                    bookmarks = [
                      {
                        name = "Trunk";
                        url = "https://trunkrs.dev";
                      }
                    ];
                  }
                ];
              }
              {
                name = "Tools";
                bookmarks = [
                  {
                    name = "Mermaid";
                    bookmarks = [
                      {
                        name = "Homepage";
                        url = "https://mermaid.js.org";
                      }
                      {
                        name = "Editor";
                        url = "https://mermaid.live";
                      }
                    ];
                  }
                ];
              }
              {
                name = "Linux";
                bookmarks = [
                  {
                    name = "Arch";
                    bookmarks = [
                      {
                        name = "Homepage";
                        url = "https://archlinux.org";
                      }
                      {
                        name = "Downloads";
                        url = "https://archlinux.org/downloads";
                      }
                      {
                        name = "Wiki";
                        url = "https://wiki.archlinux.org";
                      }
                    ];
                  }
                  {
                    name = "NixOS";
                    bookmarks = [
                      {
                        name = "Manual";
                        url = "https://nixos.org/manual/nixos/stable";
                      }
                      {
                        name = "NixOS Search";
                        url = "https://search.nixos.org";
                      }
                      {
                        name = "MyNixos";
                        url = "https://mynixos.com";
                      }
                      {
                        name = "nixvim";
                        url = "https://github.com/nix-community/nixvim";
                      }
                      {
                        name = "NixOS on ARM";
                        url = "https://nixos.wiki/wiki/NixOS_on_ARM";
                      }
                    ];
                  }
                ];
              }
              {
                name = "Tricks";
                bookmarks = [
                  {
                    name = "PDF dark mode";
                    url = "javascript:(function(){var el = typeof viewer !== 'undefined' ? viewer : document.body; el.style.filter = 'grayscale(1) invert(1) sepia(1) contrast(75%)';})()";
                  }
                  {
                    name = "Generating a new SSH key";
                    url =
                    "https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
