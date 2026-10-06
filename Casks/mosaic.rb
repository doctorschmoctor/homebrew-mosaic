cask "mosaic" do
  version "0.3.0"
  sha256 "d22ee183856c45bffc608f940d3372066e53253e1030c049cf3145c634b123f7"

  url "https://github.com/doctorschmoctor/Mosaic/releases/download/v#{version}/Mosaic-#{version}.dmg"
  name "Mosaic"
  desc "Several Messages conversations side by side in one window"
  homepage "https://github.com/doctorschmoctor/Mosaic"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Mosaic.app"

  # The app is signed locally, not notarized: without this, macOS would refuse the first launch
  # until it is allowed in System Settings. Installing from this tap is the user's choice of source.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Mosaic.app"]
  end

  zap trash: [
    "~/Library/Application Support/Mosaic",
    "~/Library/Messages/.mosaic-outgoing",
    "~/Library/Preferences/com.doctorschmoctor.Mosaic.plist",
  ]

  caveats <<~CAVEATS
    Open Mosaic and follow Connect Messages: add Mosaic.app under
    System Settings > Privacy & Security > Full Disk Access, then reopen it.
    After an upgrade, macOS may ask for Full Disk Access again.
  CAVEATS
end
