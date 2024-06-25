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
    @import "${inputs.shyfox}/chrome/userChrome.css";
    @import "${inputs.edge-frfox}/chrome/icons/icons.css";
    @import "${inputs.edge-frfox}/chrome/global/popup.css";
    @import "${inputs.edge-frfox}/chrome/global/tree.css";
    @import "${inputs.edge-frfox}/chrome/global/tweaks.css";

    :root {
      --outline: 0;
    }
  '';
  userContent = ''
    @import "${inputs.shyfox}/chrome/userContent.css";

    @-moz-document regexp("^moz-extension://.*?/sidebar/sidebar.html")
    {
      #nav_bar {
        box-shadow: none !important;
      }

      #icon_settings path {
        d: path("M8 0a8.02 8.02 0 0 0-1.672.174.474.474 0 0 0-.367.377L5.617 2.44a.942.942 0 0 1-1.242.717L2.57 2.512a.47.47 0 0 0-.508.127A7.998 7.998 0 0 0 .386 5.537a.47.47 0 0 0 .143.504l1.463 1.242a.94.94 0 0 1 0 1.433L.529 9.958a.471.471 0 0 0-.143.504 7.988 7.988 0 0 0 1.676 2.898.47.47 0 0 0 .508.127l1.805-.644a.941.941 0 0 1 1.242.717l.344 1.889c.034.187.18.337.367.377A8.022 8.022 0 0 0 8 15.999c.567 0 1.126-.057 1.672-.173a.472.472 0 0 0 .366-.377l.345-1.89a.942.942 0 0 1 1.242-.717l1.805.645a.47.47 0 0 0 .508-.127 7.998 7.998 0 0 0 1.676-2.898.47.47 0 0 0-.143-.504l-1.463-1.242a.94.94 0 0 1 0-1.433l1.463-1.242a.471.471 0 0 0 .143-.504 7.988 7.988 0 0 0-1.676-2.898.47.47 0 0 0-.508-.127l-1.805.645a.941.941 0 0 1-1.242-.717L10.037.55a.472.472 0 0 0-.365-.376A8.027 8.027 0 0 0 8 0zm0 .941c.395 0 .786.032 1.17.096l.285 1.572a1.88 1.88 0 0 0 2.486 1.434l1.502-.537c.5.605.897 1.289 1.172 2.025l-1.219 1.033a1.883 1.883 0 0 0 0 2.87l1.22 1.034a7.043 7.043 0 0 1-1.173 2.025l-1.502-.537a1.882 1.882 0 0 0-2.486 1.433l-.285 1.572a7.135 7.135 0 0 1-2.342 0l-.283-1.572a1.88 1.88 0 0 0-2.486-1.433l-1.502.537a7.054 7.054 0 0 1-1.172-2.025l1.219-1.033a1.883 1.883 0 0 0 0-2.871L1.384 5.53a7.046 7.046 0 0 1 1.173-2.025l1.502.537a1.882 1.882 0 0 0 2.486-1.434l.283-1.572A7.132 7.132 0 0 1 8 .941zm0 4.56A2.5 2.5 0 1 0 8 10.5a2.5 2.5 0 0 0 0-5zm0 1a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3z") !important;
      }

      /* selected tab outline */
      .Tab[data-pin="true"][data-active="true"] .body {
        border: 0 !important;
        background-color: var(--tabs-activated-bg) !important;
      }

      /* NAVBAR */

      #root.root {--nav-btn-width: 25px;}
      #root.root {--nav-btn-height: 25px;}
      #root.root {--nav-btn-margin: 2px;}
      #root.root {--toolbar-bg: transparent;}

      .PinnedTabsBar {margin: 10px 0px;}
    }
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
          # edge-frfox
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
            user_pref("browser.urlbar.suggest.calculator", true);
            user_pref("browser.urlbar.unitConversion.enabled", true);
            user_pref("browser.urlbar.trimHttps", true);
            user_pref("browser.urlbar.trimURLs", true);
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
             * OPTION: SHARPEN SCROLLING                                                           *
            ****************************************************************************************/
            // credit: https://github.com/black7375/Firefox-UI-Fix
            // only sharpen scrolling
            user_pref("apz.overscroll.enabled", false); // DEFAULT NON-LINUX
            user_pref("general.smoothScroll", true); // DEFAULT
            user_pref("mousewheel.min_line_scroll_amount", 10); // 10-40; adjust this number to your liking; default=5
            user_pref("general.smoothScroll.mouseWheel.durationMinMS", 80); // default=50
            user_pref("general.smoothScroll.currentVelocityWeighting", "0.15"); // default=.25
            user_pref("general.smoothScroll.stopDecelerationWeighting", "0.6"); // default=.4
            // Firefox Nightly only:
            // [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1846935
            user_pref("general.smoothScroll.msdPhysics.enabled", false); // [FF122+ Nightly]
            user_pref("apz.gtk.pangesture.page_delta_mode_multiplier", 0.5);
          ''
          ''
            user_pref("privacy.query_stripping.strip_list", "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid");
          ''
          # remove spyware
          ''
            user_pref("browser.selfsupport.url", "");
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
