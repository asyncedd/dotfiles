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
    Extensions = {
      Uninstall = [
        "google@search.mozilla.org"
        "bing@search.mozilla.org"
        "amazondotcom@search.mozilla.org"
        "ebay@search.mozilla.org"
        "twitter@search.mozilla.org"
      ];
      Install = [
        "https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-latest.xpi" # Ublock origin
        "https://github.com/mbnuqw/sidebery/releases/download/v5.0.0/sidebery-5.0.0.1.xpi" # Sidebery
        "https://addons.mozilla.org/firefox/downloads/file/4202411/sponsorblock-5.4.29.xpi" # SponsorBlock
        "https://addons.mozilla.org/firefox/downloads/file/4218010/keepassxc_browser-1.8.11.xpi" # KeePassXC Browser
        "https://addons.mozilla.org/firefox/downloads/file/3912447/userchrome_toggle-1.2.xpi" # userchrome toggle
        "https://addons.mozilla.org/firefox/downloads/file/3786185/arc_dark_theme_we-2021.6.2.xpi" # Arc Dark Theme
        "https://addons.mozilla.org/firefox/downloads/file/4250017/enhancer_for_youtube-2.0.123.xpi" # enhancer for youtube
        "https://addons.mozilla.org/firefox/downloads/file/3743190/ddg_bangs_but_faster-0.2.2.xpi" # DuckDuckGo !bangs but Faster
        "https://github.com/bpc-clone/bpc_updates/releases/download/latest/bypass_paywalls_clean-latest.xpi" # BPC
      ];
    };
    SearchEngines = {
      Remove = [
        "Google"
        "Bing"
        "Amazon.com"
        "eBay"
        "Twitter"
      ];
    };
  };
}
