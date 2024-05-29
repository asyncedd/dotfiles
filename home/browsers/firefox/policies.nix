{...}: {
  programs.firefox.policies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = true;
    DisableProfileImport = true;
    DisableSetDesktopBackground = true;
    DisableFeedbackCommands = true;
    DisableFirefoxScreenshots = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    PasswordManagerEnabled = false;
    FirefoxHome = {
      Pocket = false;
      Snippets = false;
      TopSites = false;
      Highlights = false;
      Locked = true;
    };
    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
    Cookies = {
      Behavior = "accept";
      Locked = false;
    };
    ExtensionSettings = {
      "google@search.mozilla.org".installation_mode = "blocked";
      "bing@search.mozilla.org".installation_mode = "blocked";
      "amazondotcom@search.mozilla.org".installation_mode = "blocked";
      "ebay@search.mozilla.org".installation_mode = "blocked";
      "wikipedia@search.mozilla.org".installation_mode = "blocked";
    };
    Extensions = {
      Uninstall = [
        "google@search.mozilla.org"
        "bing@search.mozilla.org"
        "amazondotcom@search.mozilla.org"
        "ebay@search.mozilla.org"
        "twitter@search.mozilla.org"
        "wikipedia@search.mozilla.org"
      ];
      Install = [
        "https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-latest.xpi" # Ublock origin
        "https://github.com/mbnuqw/sidebery/releases/download/v5.0.0/sidebery-5.0.0.1.xpi" # Sidebery
        "https://github.com/ajayyy/SponsorBlock/releases/download/5.6/FirefoxSignedInstaller.xpi" # SponsorBlock
        "https://addons.mozilla.org/firefox/downloads/file/4218010/keepassxc_browser-1.8.11.xpi" # KeePassXC Browser
        "https://addons.mozilla.org/firefox/downloads/file/3912447/userchrome_toggle-1.2.xpi" # userchrome toggle
        "https://addons.mozilla.org/firefox/downloads/file/3786185/arc_dark_theme_we-2021.6.2.xpi" # Arc Dark Theme
        "https://addons.mozilla.org/firefox/downloads/file/3743190/ddg_bangs_but_faster-0.2.2.xpi" # DuckDuckGo !bangs but Faster
        "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi" # Return Youtube Dislikes
        "https://github.com/bpc-clone/bpc_updates/releases/download/latest/bypass_paywalls_clean-latest.xpi" # BPC
        "https://addons.mozilla.org/firefox/downloads/file/4254118/dearrow-1.5.11.xpi" # dearrow
        "https://addons.mozilla.org/firefox/downloads/file/3009842/enhanced_h264ify-2.1.0.xpi" # enhanced h269ify
      ];
    };
    SearchEngines = {
      Remove = [
        "Google"
        "Bing"
        "Amazon.com"
        "eBay"
        "Twitter"
        "Wikipedia"
      ];
    };
  };
}
