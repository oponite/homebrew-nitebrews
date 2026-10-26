class LanaAT201 < Formula
  desc "Verified register-based language with explicit uncertainty"
  homepage "https://github.com/oponite/lana"
  url "https://github.com/oponite/lana/releases/download/v2.0.1/lana-2.0.1-source.tar.gz"
  sha256 "ba01015c8526c91728e0d2c454b1566bc6eda428e9440504537a65d7379292f9"
  license "Apache-2.0"

  keg_only "exact releases must not replace the default lana command"

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
    assert_match "Lana #{version} (LABC v2,", shell_output("#{bin}/lana version")
    system bin/"lana", "new", "hello-lana"
    Dir.chdir("hello-lana") do
      system bin/"lana", "build"
      system bin/"lana", "run"
    end
  end
end
