{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  engines = {
    "Wikipedia (en)".metaData.alias = "@wiki";
    "Google".metaData.hidden = true;
    "Amazon.com".metaData.hidden = true;
    "Amazon.co.jp".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "eBay".metaData.hidden = true;
    "Wikipedia (en)".metaData.hidden = true;

    "Noogle" = {
      urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
      iconUpdateURL = "https://noogle.dev/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = [ "@ng" ];
    };
    "MyNixOS" = {
      urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
      iconUpdateURL = "https://mynixos.com/favicon-dark.svg";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = [ "@mno" ];
    };
    "Home Manager Options" = {
      urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
      iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = [ "@hm" ];
    };
    "SearX" = {
      urls = [ { template = "https://searxng.site/searxng/search?q={searchTerms}"; } ];
      iconUpdateURL = "https://searxng.site/searxng/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = [ "!searx" ];
    };
    "Invidious (yewtu.be)" = {
      urls = [ { template = "https://yewtu.be/search?q={searchTerms}"; } ];
      iconUpdateURL = "https://vid.puffyan.us/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "!vid" ];
    };

    "Brave" = {
      urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
      icon = "${pkgs.brave}/share/icons/hicolor/64x64/apps/brave-browser.png";
      definedAliases = "!b";
    };
  };
  userChrome = ''
    @import "${inputs.edgyarc-fr}/chrome/userChrome.css";

    :root {
       --af-content-border: 0px;
    }

    @-moz-document regexp("^moz-extension://.*?/sidebar/sidebar.html") {
      #root.root {--border: rgba(0,0,0,0);}
      #root.root {--tabs-margin: 12px;}
    }

    .tab-background[selected] {
      border: 0;
      outline: 0;

      /* Fractional scaling adjustments (150%, 175%, etc.) */
      @media (1dppx < resolution < 2dppx) {
        outline-width: 1.5px !important;
      }
    }

  '';
  userContent = ''
    @import "${inputs.edgyarc-fr}/chrome/userContent.css";
  '';
  search = {
    force = true;
    default = "SearX";
    privateDefault = "SearX";
    inherit engines;
  };
in
{
  imports = [
    ./addons/ublock.nix
    ./policies.nix
  ];
  programs = {
    firefox = {
      enable = true;
      profiles.async = {
        id = 0;
        name = "async";
        isDefault = true;
        bookmarks = [
          {
            name = "Youtube";
            tags = [ "youtube" ];
            url = "https://www.youtube.com";
          }
          {
            name = "Javascript";
            toolbar = true;
            bookmarks = [
              {
                name = "Youtube -> yewtu.be";
                tags = [
                  "redirect"
                  "youtube"
                  "yewtu.be"
                ];
                url = "javascript:(function(){if (location.host.endsWith('.youtube.com')) location.host='yewtu.be';})()";
              }
              {
                name = "Obsidian web clipper";
                tags = [
                  "obsidian"
                  "web clipper"
                ];
                url = "javascript:(function()%7Bjavascript%3A%20Promise.all(%5Bimport('https%3A%2F%2Funpkg.com%2Fturndown%406.0.0%3Fmodule')%2C%20import('https%3A%2F%2Funpkg.com%2F%40tehshrike%2Freadability%400.2.0')%2C%20%5D).then(async%20(%5B%7B%0A%20%20%20%20default%3A%20Turndown%0A%7D%2C%20%7B%0A%20%20%20%20default%3A%20Readability%0A%7D%5D)%20%3D%3E%20%7B%0A%0A%20%20%2F*%20Optional%20vault%20name%20*%2F%0A%20%20const%20vault%20%3D%20%22%22%3B%0A%0A%20%20%2F*%20Optional%20folder%20name%20such%20as%20%22Clippings%2F%22%20*%2F%0A%20%20const%20folder%20%3D%20%2202%20Source%20Material%2FClippings%2F%22%3B%0A%0A%20%20%2F*%20Optional%20tags%20%20*%2F%0A%20%20let%20tags%20%3D%20%22clippings%22%3B%0A%0A%20%20%2F*%20Parse%20the%20site's%20meta%20keywords%20content%20into%20tags%2C%20if%20present%20*%2F%0A%20%20if%20(document.querySelector('meta%5Bname%3D%22keywords%22%20i%5D'))%20%7B%0A%20%20%20%20%20%20var%20keywords%20%3D%20document.querySelector('meta%5Bname%3D%22keywords%22%20i%5D').getAttribute('content').split('%2C')%3B%0A%0A%20%20%20%20%20%20keywords.forEach(function(keyword)%20%7B%0A%20%20%20%20%20%20%20%20%20%20let%20tag%20%3D%20'%20'%20%2B%20keyword.split('%20').join('')%3B%0A%20%20%20%20%20%20%20%20%20%20tags%20%2B%3D%20tag%3B%0A%20%20%20%20%20%20%7D)%3B%0A%20%20%7D%0A%0A%20%20function%20getSelectionHtml()%20%7B%0A%20%20%20%20var%20html%20%3D%20%22%22%3B%0A%20%20%20%20if%20(typeof%20window.getSelection%20!%3D%20%22undefined%22)%20%7B%0A%20%20%20%20%20%20%20%20var%20sel%20%3D%20window.getSelection()%3B%0A%20%20%20%20%20%20%20%20if%20(sel.rangeCount)%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20var%20container%20%3D%20document.createElement(%22div%22)%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20for%20(var%20i%20%3D%200%2C%20len%20%3D%20sel.rangeCount%3B%20i%20%3C%20len%3B%20%2B%2Bi)%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20container.appendChild(sel.getRangeAt(i).cloneContents())%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20html%20%3D%20container.innerHTML%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%20else%20if%20(typeof%20document.selection%20!%3D%20%22undefined%22)%20%7B%0A%20%20%20%20%20%20%20%20if%20(document.selection.type%20%3D%3D%20%22Text%22)%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20html%20%3D%20document.selection.createRange().htmlText%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20return%20html%3B%0A%20%20%7D%0A%0A%20%20const%20selection%20%3D%20getSelectionHtml()%3B%0A%0A%20%20const%20%7B%0A%20%20%20%20%20%20title%2C%0A%20%20%20%20%20%20byline%2C%0A%20%20%20%20%20%20content%0A%20%20%7D%20%3D%20new%20Readability(document.cloneNode(true)).parse()%3B%0A%0A%20%20function%20getFileName(fileName)%20%7B%0A%20%20%20%20var%20userAgent%20%3D%20window.navigator.userAgent%2C%0A%20%20%20%20%20%20%20%20platform%20%3D%20window.navigator.platform%2C%0A%20%20%20%20%20%20%20%20windowsPlatforms%20%3D%20%5B'Win32'%2C%20'Win64'%2C%20'Windows'%2C%20'WinCE'%5D%3B%0A%0A%20%20%20%20if%20(windowsPlatforms.indexOf(platform)%20!%3D%3D%20-1)%20%7B%0A%20%20%20%20%20%20fileName%20%3D%20fileName.replace('%3A'%2C%20'').replace(%2F%5B%2F%5C%5C%3F%25*%7C%22%3C%3E%5D%2Fg%2C%20'-')%3B%0A%20%20%20%20%7D%20else%20%7B%0A%20%20%20%20%20%20fileName%20%3D%20fileName.replace('%3A'%2C%20'').replace(%2F%5C%2F%2Fg%2C%20'-').replace(%2F%5C%5C%2Fg%2C%20'-')%3B%0A%20%20%20%20%7D%0A%20%20%20%20return%20fileName%3B%0A%20%20%7D%0A%20%20const%20fileName%20%3D%20getFileName(title)%3B%0A%0A%20%20if%20(selection)%20%7B%0A%20%20%20%20%20%20var%20markdownify%20%3D%20selection%3B%0A%20%20%7D%20else%20%7B%0A%20%20%20%20%20%20var%20markdownify%20%3D%20content%3B%0A%20%20%7D%0A%0A%20%20if%20(vault)%20%7B%0A%20%20%20%20%20%20var%20vaultName%20%3D%20'%26vault%3D'%20%2B%20encodeURIComponent(%60%24%7Bvault%7D%60)%3B%0A%20%20%7D%20else%20%7B%0A%20%20%20%20%20%20var%20vaultName%20%3D%20''%3B%0A%20%20%7D%0A%0A%20%20const%20markdownBody%20%3D%20new%20Turndown(%7B%0A%20%20%20%20%20%20headingStyle%3A%20'atx'%2C%0A%20%20%20%20%20%20hr%3A%20'---'%2C%0A%20%20%20%20%20%20bulletListMarker%3A%20'-'%2C%0A%20%20%20%20%20%20codeBlockStyle%3A%20'fenced'%2C%0A%20%20%20%20%20%20emDelimiter%3A%20'*'%2C%0A%20%20%7D).turndown(markdownify)%3B%0A%0A%20%20var%20date%20%3D%20new%20Date()%3B%0A%0A%20%20function%20convertDate(date)%20%7B%0A%20%20%20%20var%20yyyy%20%3D%20date.getFullYear().toString()%3B%0A%20%20%20%20var%20mm%20%3D%20(date.getMonth()%2B1).toString()%3B%0A%20%20%20%20var%20dd%20%20%3D%20date.getDate().toString()%3B%0A%20%20%20%20var%20mmChars%20%3D%20mm.split('')%3B%0A%20%20%20%20var%20ddChars%20%3D%20dd.split('')%3B%0A%20%20%20%20return%20yyyy%20%2B%20'-'%20%2B%20(mmChars%5B1%5D%3Fmm%3A%220%22%2BmmChars%5B0%5D)%20%2B%20'-'%20%2B%20(ddChars%5B1%5D%3Fdd%3A%220%22%2BddChars%5B0%5D)%3B%0A%20%20%7D%0A%0A%20%20const%20today%20%3D%20convertDate(date)%3B%0A%0A%20%20%2F%2F%20Utility%20function%20to%20get%20meta%20content%20by%20name%20or%20property%0A%20%20function%20getMetaContent(attr%2C%20value)%20%7B%0A%20%20%20%20%20%20var%20element%20%3D%20document.querySelector(%60meta%5B%24%7Battr%7D%3D'%24%7Bvalue%7D'%5D%60)%3B%0A%20%20%20%20%20%20return%20element%20%3F%20element.getAttribute(%22content%22).trim()%20%3A%20%22%22%3B%0A%20%20%7D%0A%0A%20%20%2F%2F%20Fetch%20byline%2C%20meta%20author%2C%20property%20author%2C%20or%20site%20name%0A%20%20var%20author%20%3D%20byline%20%7C%7C%20getMetaContent(%22name%22%2C%20%22author%22)%20%7C%7C%20getMetaContent(%22property%22%2C%20%22author%22)%20%7C%7C%20getMetaContent(%22property%22%2C%20%22og%3Asite_name%22)%3B%0A%0A%20%20%2F%2F%20Check%20if%20there's%20an%20author%20and%20add%20brackets%0A%20%20var%20authorBrackets%20%3D%20author%20%3F%20%60%22%5B%5B%24%7Bauthor%7D%5D%5D%22%60%20%3A%20%22%22%3B%0A%0A%0A%20%20%2F*%20Try%20to%20get%20published%20date%20*%2F%0A%20%20var%20timeElement%20%3D%20document.querySelector(%22time%22)%3B%0A%20%20var%20publishedDate%20%3D%20timeElement%20%3F%20timeElement.getAttribute(%22datetime%22)%20%3A%20%22%22%3B%0A%0A%20%20if%20(publishedDate%20%26%26%20publishedDate.trim()%20!%3D%3D%20%22%22)%20%7B%0A%20%20%20%20%20%20var%20date%20%3D%20new%20Date(publishedDate)%3B%0A%20%20%20%20%20%20var%20year%20%3D%20date.getFullYear()%3B%0A%20%20%20%20%20%20var%20month%20%3D%20date.getMonth()%20%2B%201%3B%20%2F%2F%20Months%20are%200-based%20in%20JavaScript%0A%20%20%20%20%20%20var%20day%20%3D%20date.getDate()%3B%0A%0A%20%20%20%20%20%20%2F%2F%20Pad%20month%20and%20day%20with%20leading%20zeros%20if%20necessary%0A%20%20%20%20%20%20month%20%3D%20month%20%3C%2010%20%3F%20'0'%20%2B%20month%20%3A%20month%3B%0A%20%20%20%20%20%20day%20%3D%20day%20%3C%2010%20%3F%20'0'%20%2B%20day%20%3A%20day%3B%0A%0A%20%20%20%20%20%20var%20published%20%3D%20year%20%2B%20'-'%20%2B%20month%20%2B%20'-'%20%2B%20day%3B%0A%20%20%7D%20else%20%7B%0A%20%20%20%20%20%20var%20published%20%3D%20''%0A%20%20%7D%0A%0A%20%20%2F*%20YAML%20front%20matter%20as%20tags%20render%20cleaner%20with%20special%20chars%20%20*%2F%0A%20%20const%20fileContent%20%3D%20%0A%20%20%20%20%20%20'---%5Cn'%0A%20%20%20%20%20%20%2B%20'tags%3A%20%22%5B%5BClippings%5D%5D%22%5Cn'%0A%20%20%20%20%20%20%2B%20'author%3A%20'%20%2B%20authorBrackets%20%2B%20'%5Cn'%0A%20%20%20%20%20%20%2B%20'title%3A%20%22'%20%2B%20title%20%2B%20'%22%5Cn'%0A%20%20%20%20%20%20%2B%20'source%3A%20'%20%2B%20document.URL%20%2B%20'%5Cn'%0A%20%20%20%20%20%20%2B%20'clipped%3A%20'%20%2B%20today%20%2B%20'%5Cn'%0A%20%20%20%20%20%20%2B%20'published%3A%20'%20%2B%20published%20%2B%20'%5Cn'%20%0A%20%20%20%20%20%20%2B%20'topics%3A%20%5Cn'%0A%20%20%20%20%20%20%2B%20'tags%3A%20%5B'%20%2B%20tags%20%2B%20'%5D%5Cn'%0A%20%20%20%20%20%20%2B%20'---%5Cn%5Cn'%0A%20%20%20%20%20%20%2B%20markdownBody%20%3B%0A%0A%20%20%20document.location.href%20%3D%20%22obsidian%3A%2F%2Fnew%3F%22%0A%20%20%20%20%2B%20%22file%3D%22%20%2B%20encodeURIComponent(folder%20%2B%20fileName)%0A%20%20%20%20%2B%20%22%26content%3D%22%20%2B%20encodeURIComponent(fileContent)%0A%20%20%20%20%2B%20vaultName%20%3B%0A%0A%7D)%7D)()%3B";
              }
            ];
          }
        ];
        inherit search;
        extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.betterfox}/user.js")
          # doh
          ''
            user_pref("network.trr.mode", 3);
            user_pref("network.trr.uri", "https://dns.nextdns.io/7eb5d1/Firefox"); // TRR/DoH
          ''
          # userchrome
          ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("svg.context-properties.content.enabled", true);
            user_pref("layout.css.color-mix.enabled", true);
            user_pref("layout.css.light-dark.enabled", true);
            user_pref("layout.css.has-selector.enabled", true);
          ''
          # edgyarc-fr
          ''
            user_pref("uc.tweak.rounded-corners", true);
            user_pref("uc.tweak.hide-tabs-bar", true);
            user_pref("uc.tweak.hide-forward-button", true);
            user_pref("uc.tweak.floating-tabs", true);
            user_pref("uc.tweak.show-tab-close-button-on-hover", true);

            user_pref("af.edgyarc.thin-navbar", false);
            user_pref("af.edgyarc.centered-url", true);
            user_pref("af.sidebery.edgyarc-theme", true);
            user_pref("af.edgyarc.edge-sidebar", true);
          ''
          ''
            user_pref("browser.startup.page", 3); // 0102
            // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
            // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
            user_pref("privacy.clearOnShutdown.history", false); // 2811
            // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del
          ''
          ''
            //user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
            user_pref("browser.download.useDownloadDir", false);
          ''
          ''
            /****************************************************************************************
             * OPTION: NATURAL SMOOTH SCROLLING V4                                                 *
            ****************************************************************************************/
            ///  NATURAL SMOOTH SCROLLING V4 "SHARP" - AveYo, 2020-2022             preset     [default]
            ///  copy into firefox/librewolf profile as user.js, add to existing, or set in about:config
            user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS",   12);//NSS    [120]
            user_pref("general.smoothScroll.msdPhysics.enabled",                    true);//NSS  [false]
            user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant",   200);//NSS   [1250]
            user_pref("general.smoothScroll.msdPhysics.regularSpringConstant",       250);//NSS   [1000]
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS",           25);//NSS     [12]
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio",     "2.0");//NSS    [1.3]
            user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant",      250);//NSS   [2000]
            user_pref("general.smoothScroll.currentVelocityWeighting",             "1.0");//NSS ["0.25"]
            user_pref("general.smoothScroll.stopDecelerationWeighting",            "1.0");//NSS  ["0.4"]

            /// adjust multiply factor for mousewheel - or set to false if scrolling is way too fast
            user_pref("mousewheel.system_scroll_override.horizontal.factor",         200);//NSS    [200]
            user_pref("mousewheel.system_scroll_override.vertical.factor",           200);//NSS    [200]
            user_pref("mousewheel.system_scroll_override_on_root_content.enabled",  true);//NSS   [true]
            user_pref("mousewheel.system_scroll_override.enabled",                  true);//NSS   [true]

            /// adjust pixels at a time count for mousewheel - cant do more than a page at once if <100
            user_pref("mousewheel.default.delta_multiplier_x",                       100);//NSS    [100]
            user_pref("mousewheel.default.delta_multiplier_y",                       100);//NSS    [100]
            user_pref("mousewheel.default.delta_multiplier_z",                       100);//NSS    [100]

            ///  this preset will reset couple extra variables for consistency
            user_pref("apz.allow_zooming",                                          true);//NSS   [true]
            user_pref("apz.force_disable_desktop_zooming_scrollbars",              false);//NSS  [false]
            user_pref("apz.paint_skipping.enabled",                                 true);//NSS   [true]
            user_pref("apz.windows.use_direct_manipulation",                        true);//NSS   [true]
            user_pref("dom.event.wheel-deltaMode-lines.always-disabled",           false);//NSS  [false]
            user_pref("general.smoothScroll.durationToIntervalRatio",                200);//NSS    [200]
            user_pref("general.smoothScroll.lines.durationMaxMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.lines.durationMinMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.other.durationMaxMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.other.durationMinMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.pages.durationMaxMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.pages.durationMinMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.pixels.durationMaxMS",                   150);//NSS    [150]
            user_pref("general.smoothScroll.pixels.durationMinMS",                   150);//NSS    [150]
            user_pref("general.smoothScroll.scrollbars.durationMaxMS",               150);//NSS    [150]
            user_pref("general.smoothScroll.scrollbars.durationMinMS",               150);//NSS    [150]
            user_pref("general.smoothScroll.mouseWheel.durationMaxMS",               200);//NSS    [200]
            user_pref("general.smoothScroll.mouseWheel.durationMinMS",                50);//NSS     [50]
            user_pref("layers.async-pan-zoom.enabled",                              true);//NSS   [true]
            user_pref("layout.css.scroll-behavior.spring-constant",                "250");//NSS    [250]
            user_pref("mousewheel.transaction.timeout",                             1500);//NSS   [1500]
            user_pref("mousewheel.acceleration.factor",                               10);//NSS     [10]
            user_pref("mousewheel.acceleration.start",                                -1);//NSS     [-1]
            user_pref("mousewheel.min_line_scroll_amount",                             5);//NSS      [5]
            user_pref("toolkit.scrollbox.horizontalScrollDistance",                    5);//NSS      [5]
            user_pref("toolkit.scrollbox.verticalScrollDistance",                      3);//NSS      [3]
            ///
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
