cask "pult" do
  version "1.1.1"
  sha256 "2345bd1116c51a49fddd391a57323f556f017a30a4e8a94b07880b5fa6c5b8dc"

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
