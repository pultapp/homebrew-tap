cask "pult" do
  version "1.0.4"
  sha256 "562a07f3c297384810088a77df8cb294e3c7b75fa365bc9f953c0146c41011b7"

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
