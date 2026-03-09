class MacDeploy < Formula
  desc "macOS workstation security hardening and audit tools"
  homepage "https://davidwhittington.github.io/mac-deploy"
  url "https://github.com/davidwhittington/mac-deploy/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "3c3d0cb245e416063cf36e5f12760295da01443aab845eb376ff511a9f269b94"
  license "MIT"
  version "0.5.0"

  def install
    bin.install "scripts/audit/security-audit.sh"    => "mac-deploy-audit"
    bin.install "scripts/harden-sshd.sh"             => "mac-deploy-harden-ssh"
    bin.install "scripts/enable-stealth-firewall.sh" => "mac-deploy-firewall"
    bin.install "scripts/first-run.sh"               => "mac-deploy-first-run"
    bin.install "pkgs/capture.sh"                    => "mac-deploy-capture"
    bin.install "pkgs/deploy.sh"                     => "mac-deploy-deploy"
  end

  def caveats
    <<~EOS
      mac-deploy tools installed:

        mac-deploy-audit        Run a full security posture audit (outputs Markdown)
        mac-deploy-harden-ssh   Apply SSH hardening config (requires sudo)
        mac-deploy-firewall     Enable Application Firewall + stealth mode (requires sudo)
        mac-deploy-first-run    Interactive bootstrap for a new Mac
        mac-deploy-capture      Snapshot current Homebrew and shell config
        mac-deploy-deploy       Restore a saved machine profile

      Quick start (new machine):
        sudo mac-deploy-first-run

      Or step by step:
        mac-deploy-audit --brief
        sudo mac-deploy-harden-ssh
        sudo mac-deploy-firewall

      Full documentation: https://davidwhittington.github.io/mac-deploy
      Source repo:        https://github.com/davidwhittington/mac-deploy
    EOS
  end

  test do
    system "#{bin}/mac-deploy-audit", "--brief"
  end
end
