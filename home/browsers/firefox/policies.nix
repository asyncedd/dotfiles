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
        "https://addons.mozilla.org/firefox/downloads/file/4210197/youtube_recommended_videos-1.6.3.xpi" # Unhook
        "https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-latest.xpi" # Ublock origin
        "https://github.com/mbnuqw/sidebery/releases/download/v5.0.0/sidebery-5.0.0.1.xpi" # Sidebery
        "https://addons.mozilla.org/firefox/downloads/file/4202411/sponsorblock-5.4.29.xpi" # SponsorBlock
        "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi" # Return Youtube Dislike
        "https://addons.mozilla.org/firefox/downloads/file/4156831/github_file_icons-1.5.1.xpi" # Github File Icons
        "https://addons.mozilla.org/firefox/downloads/file/4219626/refined_github-24.1.10.xpi" # Redefined Github
        "https://gitlab.com/magnolia1234/bpc-uploads/-/raw/master/bypass_paywalls_clean-latest.xpi" # Bypass Paywalls Clean
        "https://addons.mozilla.org/firefox/downloads/file/4218010/keepassxc_browser-1.8.11.xpi" # KeePassXC Browser
        "https://addons.mozilla.org/firefox/downloads/file/4205769/soundfixer-1.4.1.xpi" # Soundfixer
        "https://addons.mozilla.org/firefox/downloads/file/3912447/userchrome_toggle-1.2.xpi" # userchrome toggle
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
