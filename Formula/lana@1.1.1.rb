class LanaAT111 < Formula
  desc "Verified register-based language with explicit uncertainty"
  homepage "https://github.com/oponite/lana"
  url "https://github.com/oponite/lana/releases/download/v1.1.1/lana-1.1.1-source.tar.gz"
  sha256 "619115f268d7298ea9d9620f2191efa7f203e55ab95c50100918ecb6b2d2835d"
  license "Apache-2.0"

  keg_only :versioned_formula

  depends_on "cmake" => :build

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
    assert_match "Lana #{version} (LABC v1,", shell_output("#{bin}/lana version")
    system bin/"lana", "new", "hello-lana"
    Dir.chdir("hello-lana") do
      system bin/"lana", "build"
      system bin/"lana", "run"
    end
  end
end
