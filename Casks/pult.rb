cask "pult" do
  version "1.1.0"
  sha256 "65959ca285aafb513a5b8a577280120b3d3e015ea10cb9104c84adcef89d1032"

  url "https://getpult.app/download/Pult-#{version}.dmg"
  name "Pult"
  desc "Serial console broker for humans and AI agents"
  homepage "https://getpult.app/"

  livecheck do
    url "https://getpult.app/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Pult.app"
  binary "#{appdir}/Pult.app/Contents/Helpers/pult"

  # The daemon runs from the app bundle; Pult registers it again the next time it opens,
  # so an upgrade (brew reopens the app) keeps it and the login item.
  uninstall launchctl: "dev.pult.app.daemon",
            quit:      "dev.pult.app"

  zap trash: [
    "~/.config/pult",
    "~/Library/Application Support/Pult",
    "~/Library/Caches/dev.pult.app",
    "~/Library/HTTPStorages/dev.pult.app",
    "~/Library/Logs/Pult",
    "~/Library/Preferences/dev.pult.app.plist",
  ]
end
