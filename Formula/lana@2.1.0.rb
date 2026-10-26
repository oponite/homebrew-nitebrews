class LanaAT210 < Formula
  desc "Verified register-based language with explicit uncertainty"
  homepage "https://github.com/oponite/lana"
  url "https://github.com/oponite/lana/releases/download/v2.1.0/lana-2.1.0-source.tar.gz"
  sha256 "dbdf5b3ba4e1dbfea144150c13d9328b24884ff1458835a60f4a0ac2d539df08"
  license "Apache-2.0"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "python@3.14" => :build
  depends_on "pkgconf" => :build
  depends_on "libffi"
  depends_on "openssl@3"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--parallel"
    system "cmake", "--install", "build"
    libexec.install bin/"lana-compiler.labc"
    (bin/"lana").rename bin/"lana-bin"
    (bin/"lana").write <<~EOS
      #!/bin/sh
      export LANA_COMPILER_LABC="#{libexec}/lana-compiler.labc"
      exec "#{bin}/lana-bin" "$@"
    EOS
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
