class LanaAT410 < Formula
  desc "Verified register-based language with explicit uncertainty"
  homepage "https://github.com/oponite/lana"
  url "https://github.com/oponite/lana/releases/download/v4.1.0/lana-4.1.0-source.tar.gz"
  sha256 "792f066b4b8f62577494e55f1e385331c0597c109d6ca74508debdc40f688c89"
  license "Apache-2.0"

  keg_only "exact releases must not replace the default lana command"

  depends_on "python@3.14" => :build
  depends_on "rust" => :build

  def install
    system "python3", "tools/build.py", "install", "--prefix", prefix
  end

  test do
    assert_match "Lana #{version} (LABC v2,", shell_output("#{bin}/lana version")
    system bin/"lana", "new", "hello-lana"
    Dir.chdir("hello-lana") do
      system bin/"lana", "build"
      system bin/"lana", "run"
    end
  end
end
