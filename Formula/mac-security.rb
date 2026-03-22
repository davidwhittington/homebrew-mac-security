class MacSecurity < Formula
  desc "macOS workstation security hardening and audit tools"
  homepage "https://davidwhittington.github.io/mac-security"
  url "https://github.com/davidwhittington/mac-security/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "0bc7c4b60bb101f823dbc4c7a0977636ba2f9c943f6d628f1f84c53a9072153b"
  license "MIT"
  version "0.9.0"

  def install
    bin.install "scripts/audit/security-audit.sh"    => "mac-security-audit"
    bin.install "scripts/harden-sshd.sh"             => "mac-security-harden-ssh"
    bin.install "scripts/enable-stealth-firewall.sh" => "mac-security-firewall"
    bin.install "scripts/first-run.sh"               => "mac-security-first-run"
    bin.install "scripts/apply-configs.sh"           => "mac-security-configs"
    bin.install "scripts/apply-defaults.sh"          => "mac-security-defaults"
    bin.install "scripts/brew-upgrade.sh"            => "mac-security-upgrade"
    bin.install "pkgs/capture.sh"                    => "mac-security-capture"
    bin.install "pkgs/deploy.sh"                     => "mac-security-deploy"
  end

  def caveats
    <<~EOS
      mac-security tools installed:

        mac-security-audit        Run a full security posture audit (outputs Markdown)
        mac-security-harden-ssh   Apply SSH hardening config (requires sudo)
        mac-security-firewall     Enable Application Firewall + stealth mode (requires sudo)
        mac-security-first-run    Interactive bootstrap for a new Mac
        mac-security-configs      Render and deploy app config templates
        mac-security-defaults     Apply hardened macOS system preferences
        mac-security-upgrade      Upgrade all Homebrew packages and log changes
        mac-security-capture      Snapshot current Homebrew and shell config
        mac-security-deploy       Restore a saved machine profile

      Quick start (new machine):
        sudo mac-security-first-run

      Or step by step:
        mac-security-audit --brief
        sudo mac-security-harden-ssh
        sudo mac-security-firewall
        mac-security-configs --list
        mac-security-configs --dry-run
        mac-security-configs

      Config templating note:
        mac-security-configs expects a configs/ directory alongside the script.
        For full template support, clone the repo:
          git clone https://github.com/davidwhittington/mac-security.git
          cd mac-security && bash scripts/apply-configs.sh

      Full documentation: https://davidwhittington.github.io/mac-security
      Source repo:        https://github.com/davidwhittington/mac-security
    EOS
  end

  test do
    system "#{bin}/mac-security-audit", "--brief"
  end
end
