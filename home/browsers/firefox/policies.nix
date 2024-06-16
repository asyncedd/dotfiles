{ ... }: {
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
        "https://github.com/gorhill/uBlock/releases/download/1.58.1b6/uBlock0_1.58.1b6.firefox.signed.xpi" # Ublock origin
        "https://github.com/mbnuqw/sidebery/releases/download/v5.0.0/sidebery-5.0.0.1.xpi" # Sidebery
        "https://github.com/ajayyy/SponsorBlock/releases/download/5.6/FirefoxSignedInstaller.xpi" # SponsorBlock
        "https://addons.mozilla.org/firefox/downloads/file/3912447/userchrome_toggle-1.2.xpi" # userchrome toggle
        "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi" # Return Youtube Dislikes
        "https://github.com/bpc-clone/bpc_updates/releases/download/latest/bypass_paywalls_clean-latest.xpi" # BPC
        "https://addons.mozilla.org/firefox/downloads/file/3920533/skip_redirect-2.3.6.xpi" # skip_redirect
        "https://addons.mozilla.org/firefox/downloads/file/3912447/userchrome_toggle-1.2.xpi" # userchrome toggle
        "https://addons.mozilla.org/firefox/downloads/file/4045009/auto_tab_discard-0.6.7.xpi" # auto tab discard
        "https://github.com/ajayyy/DeArrow/releases/download/1.6.2/FirefoxSignedInstaller.xpi" # dearrow
        "https://addons.mozilla.org/firefox/downloads/file/4269135/enhancer_for_youtube-2.0.124.2.xpi" # enhancer for youtube
      ];
    };
    SearchEngines = {
      Remove = [ "Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" ];
    };
  };
}
