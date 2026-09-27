class Rlsspec < Formula
  desc "Check Postgres Row Level Security against a spec of expected access"
  homepage "https://github.com/matheusspacifico/rlsspec"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.1/rlsspec-aarch64-apple-darwin.tar.xz"
      sha256 "4eec69ee24d1d0a748968c3170f48ab660357f3698dc2fc8de2c10f2fd5920d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.1/rlsspec-x86_64-apple-darwin.tar.xz"
      sha256 "8593506f39a7806432d5e38d8c2d64adf2bfdc993e96d450e921180ef1e19fcd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.1/rlsspec-aarch64-unknown-linux-musl.tar.xz"
      sha256 "7140277db9d858d619a04e063cfb3a8b8cfdc820dfd48af68c5fde60dd681ca9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.1/rlsspec-x86_64-unknown-linux-musl.tar.xz"
      sha256 "57b959a788e53880896b1826a6ea1848d93dd902b6c73a7a9765701de0ab2fb3"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rlsspec"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rlsspec"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rlsspec"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rlsspec"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
