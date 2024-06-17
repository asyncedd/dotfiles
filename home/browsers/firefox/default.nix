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
  '';
  userContent = ''
    @import "${inputs.edgyarc-fr}/chrome/userContent.css";
  '';
  search = {
    force = true;
    default = "Searx";
    privateDefault = "Searx";
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

            user_pref("af.edgyarc.thin-navbar", false);
            user_pref("af.edgyarc.centered-url", true);
            user_pref("af.sidebery.edgyarc-theme", true)
          ''
          ''
            user_pref("browser.startup.page", 3); // 0102
            // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
            // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
            user_pref("privacy.clearOnShutdown.history", false); // 2811
            // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

            user_pref("gfx.webrender.all", true);
            user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
            user_pref("browser.download.useDownloadDir", false);

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


            /****************************************************************************
             * SECTION: GFX RENDERING TWEAKS                                            *
             ****************************************************************************/
            user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", true);

            // PREF: Webrender tweaks
            // [1] https://searchfox.org/mozilla-central/rev/6e6332bbd3dd6926acce3ce6d32664eab4f837e5/modules/libpref/init/StaticPrefList.yaml#6202-6219
            // [2] https://hacks.mozilla.org/2017/10/the-whole-web-at-maximum-fps-how-webrender-gets-rid-of-jank/
            // [3] https://www.reddit.com/r/firefox/comments/tbphok/is_setting_gfxwebrenderprecacheshaders_to_true/i0bxs2r/
            // [4] https://www.reddit.com/r/firefox/comments/z5auzi/comment/ixw65gb?context=3
            // [5] https://gist.github.com/RubenKelevra/fd66c2f856d703260ecdf0379c4f59db?permalink_comment_id=4532937#gistcomment-4532937
            user_pref("gfx.webrender.all", true); // enables WR + additional features
            user_pref("gfx.webrender.precache-shaders", true); // longer initial startup time
            user_pref("gfx.webrender.compositor", true); // DEFAULT WINDOWS macOS
            user_pref("gfx.webrender.compositor.force-enabled", true); // enforce

            user_pref("media.av1.enabled", false);

            /****************************************************************************
             * SECTION: SPECULATIVE LOADING                                            *
            ****************************************************************************/

            // These are connections that are not explicitly asked for (e.g., clicked on).
            // [1] https://developer.mozilla.org/en-US/docs/Web/Performance/Speculative_loading

            // [NOTE] FF85+ partitions (isolates) pooled connections, prefetch connections,
            // pre-connect connections, speculative connections, TLS session identifiers,
            // and other connections. We can take advantage of the speed of pre-connections
            // while preserving privacy. Users may relax hardening to maximize their preference.
            // For more information, see SecureFox: "PREF: State Paritioning" and "PREF: Network Partitioning".
            // [NOTE] To activate and increase network predictions, go to settings in uBlock Origin and uncheck:
            // - "Disable pre-fetching (to prevent any connection for blocked network requests)"
            // [NOTE] Add prefs to "MY OVERRIDES" section and uncomment to enable them in your user.js.

            // PREF: link-mouseover opening connection to linked server
            // When accessing content online, devices use sockets as endpoints.
            // The global limit on half-open sockets controls how many speculative
            // connection attempts can occur at once when starting new connections [3].
            // If the user follows through, pages can load faster since some
            // work was done in advance. Firefox opens predictive connections
            // to sites when hovering over New Tab thumbnails or starting a
            // URL Bar search [1] and hyperlinks within a page [2].
            // [NOTE] DNS (if enabled), TCP, and SSL handshakes are set up in advance,
            // but page contents are not downloaded until a click on the link is registered.
            // [1] https://support.mozilla.org/en-US/kb/how-stop-firefox-making-automatic-connections?redirectslug=how-stop-firefox-automatically-making-connections&redirectlocale=en-US#:~:text=Speculative%20pre%2Dconnections
            // [2] https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests
            // [3] https://searchfox.org/mozilla-central/rev/028c68d5f32df54bca4cf96376f79e48dfafdf08/modules/libpref/init/all.js#1280-1282
            // [4] https://www.keycdn.com/blog/resource-hints#prefetch
            // [5] https://3perf.com/blog/link-rels/#prefetch
            //user_pref("network.http.speculative-parallel-limit", 20); // DEFAULT (FF127+?)

            // PREF: DNS prefetching <link rel="dns-prefetch">
            // Used for cross-origin connections to provide small performance improvements.
            // Disable DNS prefetching to prevent Firefox from proactively resolving
            // hostnames for other domains linked on a page. This may eliminate
            // unnecessary DNS lookups, but can increase latency when following external links.
            // [1] https://bitsup.blogspot.com/2008/11/dns-prefetching-for-firefox.html
            // [2] https://css-tricks.com/prefetching-preloading-prebrowsing/#dns-prefetching
            // [3] https://www.keycdn.com/blog/resource-hints#2-dns-prefetching
            // [4] http://www.mecs-press.org/ijieeb/ijieeb-v7-n5/IJIEEB-V7-N5-2.pdf
            // [5] https://bugzilla.mozilla.org/show_bug.cgi?id=1596935
            user_pref("network.dns.disablePrefetch", false);
            user_pref("network.dns.disablePrefetchFromHTTPS", false); // (FF127+ false)

            // PREF: enable <link rel="preconnect"> tag and Link: rel=preconnect response header handling
            //user_pref("network.preconnect", true); // DEFAULT

            // PREF: preconnect to the autocomplete URL in the address bar
            // Whether to warm up network connections for autofill or search results.
            // Firefox preloads URLs that autocomplete when a user types into the address bar.
            // Connects to destination server ahead of time, to avoid TCP handshake latency.
            // [NOTE] Firefox will perform DNS lookup (if enabled) and TCP and TLS handshake,
            // but will not start sending or receiving HTTP data.
            // [1] https://www.ghacks.net/2017/07/24/disable-preloading-firefox-autocomplete-urls/
            //user_pref("browser.urlbar.speculativeConnect.enabled", false);

            // PREF: mousedown speculative connections on bookmarks and history [FF98+]
            // Whether to warm up network connections for places:menus and places:toolbar.
            //user_pref("browser.places.speculativeConnect.enabled", false);

            // PREF: network preload <link rel="preload"> [REMOVED]
            // Used to load high-priority resources faster on the current page, for strategic
            // performance improvements.
            // Instructs the browser to immediately fetch and cache high-priority resources
            // for the current page to improve performance. The browser downloads resources
            // but does not execute scripts or apply stylesheets - it just caches them for
            // instant availability later.
            // Unlike other pre-connection tags (except modulepreload), this tag is
            // mandatory for the browser.
            // [1] https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/preload
            // [2] https://w3c.github.io/preload/
            // [3] https://3perf.com/blog/link-rels/#preload
            // [4] https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf
            // [5] https://www.smashingmagazine.com/2016/02/preload-what-is-it-good-for/#how-can-preload-do-better
            // [6] https://www.keycdn.com/blog/resource-hints#preload
            // [7] https://github.com/arkenfox/user.js/issues/1098#issue-791949341
            // [8] https://yashints.dev/blog/2018/10/06/web-perf-2#preload
            // [9] https://web.dev/preload-critical-assets/
            //user_pref("network.preload", true); // [REMOVED]

            // PREF: network module preload <link rel="modulepreload"> [FF115+]
            // High-priority loading of current page JavaScript modules.
            // Used to preload high-priority JavaScript modules for strategic performance improvements.
            // Module preloading allows developers to fetch JavaScript modules and dependencies
            // earlier to accelerate page loads. The browser downloads, parses, and compiles modules
            // referenced by links with this attribute in parallel with other resources, rather
            // than sequentially waiting to process each. Preloading reduces overall download times.
            // Browsers may also automatically preload dependencies without firing extra events.
            // Unlike other pre-connection tags (except rel=preload), this tag is mandatory for the browser.
            // [1] https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel/modulepreload
            //user_pref("network.modulepreload", true); // DEFAULT

            // PREF: link prefetching <link rel="prefetch">
            // Pre-populates the HTTP cache by prefetching same-site future navigation
            // resources or subresources used on those pages.
            // Enabling link prefetching allows Firefox to preload pages tagged as important.
            // The browser prefetches links with the prefetch-link tag, fetching resources
            // likely needed for the next navigation at low priority. When clicking a link
            // or loading a new page, prefetching stops and discards hints. Prefetching
            // downloads resources without executing them.
            // [NOTE] Since link prefetch uses the HTTP cache, it has a number of issues
            // with document prefetches, such as being potentially blocked by Cache-Control headers
            // (e.g. cache partitioning).
            // [1] https://developer.mozilla.org/en-US/docs/Glossary/Prefetch
            // [2] http://www.mecs-press.org/ijieeb/ijieeb-v7-n5/IJIEEB-V7-N5-2.pdf
            // [3] https://timkadlec.com/remembers/2020-06-17-prefetching-at-this-age/
            // [4] https://3perf.com/blog/link-rels/#prefetch
            // [5] https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ
            user_pref("network.prefetch-next", true);

            // PREF: Fetch Priority API [FF119+]
            // Indicates whether the `fetchpriority` attribute for elements which support it.
            // [1] https://web.dev/articles/fetch-priority
            // [2] https://nitropack.io/blog/post/priority-hints
            // [2] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/fetchPriority
            // [3] https://developer.mozilla.org/en-US/docs/Web/API/HTMLLinkElement/fetchPriority
            //user_pref("network.fetchpriority.enabled", true);

            // PREF: early hints [FF120+]
            // [1] https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/103
            // [2] https://developer.chrome.com/blog/early-hints/
            // [3] https://blog.cloudflare.com/early-hints/
            // [4] https://blog.cloudflare.com/early-hints-performance/
            //user_pref("network.early-hints.enabled", true);

            // PREF: `Link: rel=preconnect` in 103 Early Hint response [FF120+]
            // Used to warm most critical cross-origin connections to provide
            // performance improvements when connecting to them.
            // [NOTE] When 0, this is limited by "network.http.speculative-parallel-limit".
            user_pref("network.early-hints.preconnect.enabled", true);
            //user_pref("network.early-hints.preconnect.max_connections", 10); // DEFAULT

            // PREF: Network Predictor (NP)
            // When enabled, it trains and uses Firefox's algorithm to preload page resource
            // by tracking past page resources. It uses a local file (history) of needed images,
            // scripts, etc. to request them preemptively when navigating.
            // [NOTE] By default, it only preconnects, doing DNS, TCP, and SSL handshakes.
            // No data sends until clicking. With "network.predictor.enable-prefetch" enabled,
            // it also performs prefetches.
            // [1] https://wiki.mozilla.org/Privacy/Reviews/Necko
            // [2] https://www.ghacks.net/2014/05/11/seer-disable-firefox/
            // [3] https://github.com/dillbyrne/random-agent-spoofer/issues/238#issuecomment-110214518
            // [4] https://www.igvita.com/posa/high-performance-networking-in-google-chrome/#predictor
            user_pref("network.predictor.enabled", true);

            // PREF: Network Predictor fetch for resources ahead of time
            // Prefetch page resources based on past user behavior.
            //user_pref("network.predictor.enable-prefetch", false); // DEFAULT

            // PREF: make Network Predictor active when hovering over links
            // When hovering over links, Network Predictor uses past resource history to
            // preemptively request what will likely be needed instead of waiting for the document.
            // Predictive connections automatically open when hovering over links to speed up
            // loading, starting some work in advance.
            //user_pref("network.predictor.enable-hover-on-ssl", false); // DEFAULT
            user_pref("network.predictor.enable-hover-on-ssl", true); // DEFAULT

            // PREF: assign Network Predictor confidence levels
            // [NOTE] Keep in mind that Network Predictor must LEARN your browsing habits.
            // Editing these lower will cause more speculative connections to occur,
            // which reduces accuracy over time and has privacy implications.
            //user_pref("network.predictor.preresolve-min-confidence", 60); // DEFAULT
            //user_pref("network.predictor.preconnect-min-confidence", 90); // DEFAULT
            //user_pref("network.predictor.prefetch-min-confidence", 100); // DEFAULT

            // PREF: other Network Predictor values
            // [NOTE] Keep in mmind that Network Predictor must LEARN your browsing habits.
            //user_pref("network.predictor.prefetch-force-valid-for", 10); // DEFAULT; how long prefetched resources are considered valid and usable (in seconds) for the prediction modeling
            //user_pref("network.predictor.prefetch-rolling-load-count", 10); // DEFAULT; the maximum number of resources that Firefox will prefetch in memory at one time based on prediction modeling
            //user_pref("network.predictor.max-resources-per-entry", 250); // default=100
            //user_pref("network.predictor.max-uri-length", 1000); // default=500

            /****************************************************************************
             * SECTION: EXPERIMENTAL                                                    *
            ****************************************************************************/

            // PREF: CSS Masonry Layout [NIGHTLY]
            // [1] https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Masonry_Layout
            user_pref("layout.css.grid-template-masonry-value.enabled", true);

            // PREF: Prioritized Task Scheduling API [NIGHTLY]
            // [1] https://blog.mozilla.org/performance/2022/06/02/prioritized-task-scheduling-api-is-prototyped-in-nightly/
            // [2] https://medium.com/airbnb-engineering/building-a-faster-web-experience-with-the-posttask-scheduler-276b83454e91
            user_pref("dom.enable_web_task_scheduling", true);

            // PREF: HTML Sanitizer API [NIGHTLY]
            // [1] https://developer.mozilla.org/en-US/docs/Web/API/Sanitizer
            // [2] https://caniuse.com/mdn-api_sanitizer
            user_pref("dom.security.sanitizer.enabled", true);

            // PREF: WebGPU [HIGHLY EXPERIMENTAL!]
            // [WARNING] Do not enable unless you are a web developer!
            // [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1746245
            // [2] https://developer.chrome.com/docs/web-platform/webgpu/
            // [3] https://github.com/gpuweb/gpuweb/wiki/Implementation-Status
            // [4] https://hacks.mozilla.org/2020/04/experimental-webgpu-in-firefox/
            //user_pref("dom.webgpu.enabled", true);
                //user_pref("gfx.webgpu.force-enabled", true); // enforce
            // enable WebGPU indirect draws/dispatches:
            //user_pref("dom.webgpu.indirect-dispatch.enabled", true);

            /****************************************************************************
             * SECTION: TAB UNLOAD                                                      *
            ****************************************************************************/

            // PREF: unload tabs on low memory
            // [ABOUT] about:unloads
            // Firefox will detect if your computer’s memory is running low (less than 200MB)
            // and suspend tabs that you have not used in awhile.
            // [1] https://support.mozilla.org/en-US/kb/unload-inactive-tabs-save-system-memory-firefox
            // [2] https://hacks.mozilla.org/2021/10/tab-unloading-in-firefox-93/
            //user_pref("browser.tabs.unloadOnLowMemory", true); // DEFAULT

            // PREF: determine when tabs unload [WINDOWS] [LINUX]
            // Notify TabUnloader or send the memory pressure if the memory resource
            // notification is signaled AND the available commit space is lower than
            // this value.
            // Set this to some high value, e.g. 2/3 of total memory available in your system:
            // 4GB=2640, 8GB=5280, 16GB=10560, 32GB=21120, 64GB=42240
            // [1] https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
            user_pref("browser.low_commit_space_threshold_mb", 2640); // default=200; WINDOWS LINUX

            // PREF: determine when tabs unload [LINUX]
            // On Linux, Firefox checks available memory in comparison to total memory,
            // and use this percent value (out of 100) to determine if Firefox is in a
            // low memory scenario.
            // [1] https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
            user_pref("browser.low_commit_space_threshold_percent", 33); // default=5; LINUX

            // PREF: determine how long (in ms) tabs are inactive before they unload
            // 60000=1min; 300000=5min; 600000=10min (default)
            //user_pref("browser.tabs.min_inactive_duration_before_unload", 300000); // 5min; default=600000

            /****************************************************************************
             * SECTION: PROCESS COUNT                                                  *
            ****************************************************************************/

            // PREF: process count
            // [ABOUT] View in about:processes.
            // With Firefox Quantum (2017), CPU cores = processCount. However, since the
            // introduction of Fission [2], the number of website processes is controlled
            // by processCount.webIsolated. Disabling fission.autostart or changing
            // fission.webContentIsolationStrategy reverts control back to processCount.
            // [1] https://www.reddit.com/r/firefox/comments/r69j52/firefox_content_process_limit_is_gone/
            // [2] https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#web-content-processes
            //user_pref("dom.ipc.processCount", 8); // DEFAULT; Shared Web Content
            user_pref("dom.ipc.processCount.webIsolated", 1); // default=4; Isolated Web Content

            // PREF: use one process for process preallocation cache
            user_pref("dom.ipc.processPrelaunch.fission.number", 1); // default=3; Process Preallocation Cache

            // PREF: configure process isolation
            // [1] https://hg.mozilla.org/mozilla-central/file/tip/dom/ipc/ProcessIsolation.cpp#l53
            // [2] https://www.reddit.com/r/firefox/comments/r69j52/firefox_content_process_limit_is_gone/

            // OPTION 1: isolate all websites
            // Web content is always isolated into its own `webIsolated` content process
            // based on site-origin, and will only load in a shared `web` content process
            // if site-origin could not be determined.
            //user_pref("fission.webContentIsolationStrategy", 1); // DEFAULT
            //user_pref("browser.preferences.defaultPerformanceSettings.enabled", true); // DEFAULT
                //user_pref("dom.ipc.processCount.webIsolated", 1); // one process per site origin

            // OPTION 2: isolate only "high value" websites
            // Only isolates web content loaded by sites which are considered "high
            // value". A site is considered high value if it has been granted a
            // `highValue*` permission by the permission manager, which is done in
            // response to certain actions.
            //user_pref("fission.webContentIsolationStrategy", 2);
            /user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
                /user_pref("dom.ipc.processCount.webIsolated", 1); // one process per site origin (high value)
                //user_pref("dom.ipc.processCount", 8); // determine by number of CPU cores/processors

            // OPTION 3: do not isolate websites
            // All web content is loaded into a shared `web` content process. This is
            // similar to the non-Fission behavior; however, remote subframes may still
            // be used for sites with special isolation behavior, such as extension or
            // mozillaweb content processes.
            user_pref("fission.webContentIsolationStrategy", 0);
            user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
            user_pref("dom.ipc.processCount", 8); // determine by number of CPU cores/processors

            /****************************************************************************
             * SECTION: FONT APPEARANCE                                                 *
            ****************************************************************************/

            // PREF: smoother font
            // [1] https://reddit.com/r/firefox/comments/wvs04y/windows_11_firefox_v104_font_rendering_different/?context=3
            /user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);

            // PREF: use DirectWrite everywhere like Chrome [WINDOWS]
            // [1] https://kb.mozillazine.org/Thunderbird_6.0,_etc.#Font_rendering_and_performance_issues
            // [2] https://reddit.com/r/firefox/comments/wvs04y/comment/ilklzy1/?context=3
            //user_pref("gfx.font_rendering.cleartype_params.rendering_mode", 5);
            //user_pref("gfx.font_rendering.cleartype_params.cleartype_level", 100);
            //user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_for_families", "");
            //user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_max_size", 6);
            //user_pref("gfx.font_rendering.directwrite.use_gdi_table_loading", false);
            // Some users find these helpful:
                //user_pref("gfx.font_rendering.cleartype_params.gamma", 1750);
                //user_pref("gfx.font_rendering.cleartype_params.enhanced_contrast", 100);
                //user_pref("gfx.font_rendering.cleartype_params.pixel_structure", 1);

            // PREF: use macOS Appearance Panel text smoothing setting when rendering text [macOS]
            //user_pref("gfx.use_text_smoothing_setting", true);

            /****************************************************************************
             * SECTION: NETWORK                                                         *
            ****************************************************************************/

            // PREF: use bigger packets
            // [WARNING] Cannot open HTML files bigger than 4MB if changed [2].
            // Reduce Firefox's CPU usage by requiring fewer application-to-driver data transfers.
            // However, it does not affect the actual packet sizes transmitted over the network.
            // [1] https://www.mail-archive.com/support-seamonkey@lists.mozilla.org/msg74561.html
            // [2] https://github.com/yokoffing/Betterfox/issues/279
            user_pref("network.buffer.cache.size", 262144); // 256 kb; default=32768 (32 kb)
            user_pref("network.buffer.cache.count", 128); // default=24

            // PREF: increase the absolute number of HTTP connections
            // [1] https://kb.mozillazine.org/Network.http.max-connections
            // [2] https://kb.mozillazine.org/Network.http.max-persistent-connections-per-server
            // [3] https://www.reddit.com/r/firefox/comments/11m2yuh/how_do_i_make_firefox_use_more_of_my_900_megabit/jbfmru6/
            user_pref("network.http.max-connections", 1800); // default=900
            user_pref("network.http.max-persistent-connections-per-server", 10); // default=6; download connections; anything above 10 is excessive
                user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // default=3
                //user_pref("network.http.max-persistent-connections-per-proxy", 48); // default=32
            //user_pref("network.websocket.max-connections", 200); // DEFAULT

            // PREF: pacing requests [FF23+]
            // Controls how many HTTP requests are sent at a time.
            // Pacing HTTP requests can have some benefits, such as reducing network congestion,
            // improving web page loading speed, and avoiding server overload.
            // Pacing requests adds a slight delay between requests to throttle them.
            // If you have a fast machine and internet connection, disabling pacing
            // may provide a small speed boost when loading pages with lots of requests.
            // false=Firefox will send as many requests as possible without pacing
            // true=Firefox will pace requests (default)
            // user_pref("network.http.pacing.requests.enabled", false);
            user_pref("network.http.pacing.requests.enabled", true);
                //user_pref("network.http.pacing.requests.min-parallelism", 10); // default=6
                //user_pref("network.http.pacing.requests.burst", 14); // default=10

            // PREF: increase DNS cache
            // [1] https://developer.mozilla.org/en-US/docs/Web/Performance/Understanding_latency
            user_pref("network.dnsCacheEntries", 1000); // default=400

            // PREF: adjust DNS expiration time
            // [ABOUT] about:networking#dns
            // [NOTE] These prefs will be ignored by DNS resolver if using DoH/TRR.
            user_pref("network.dnsCacheExpiration", 3600); // keep entries for 1 hour
                //user_pref("network.dnsCacheExpirationGracePeriod", 240); // default=60; cache DNS entries for 4 minutes after they expire

            // PREF: the number of threads for DNS
            user_pref("network.dns.max_high_priority_threads", 40); // DEFAULT [FF 123?]
            user_pref("network.dns.max_any_priority_threads", 24); // DEFAULT [FF 123?]

            // PREF: increase TLS token caching
            user_pref("network.ssl_tokens_cache_capacity", 10240); // default=2048; more TLS token caching (fast reconnects)
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
