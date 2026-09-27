class Rlsspec < Formula
  desc "Check Postgres Row Level Security against a spec of expected access"
  homepage "https://github.com/matheusspacifico/rlsspec"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.0/rlsspec-aarch64-apple-darwin.tar.xz"
      sha256 "dd0ad2fdd4b413f7741256b6db5601f214b7046912d8568a705b5eaae5cd00fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.0/rlsspec-x86_64-apple-darwin.tar.xz"
      sha256 "cd3ea40d8286e38c6b04e7615b6ab5a6ede396e70c0a83c82659be2aba1e1ba5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.0/rlsspec-aarch64-unknown-linux-musl.tar.xz"
      sha256 "153cd71ed8c263bf484fbb2f4a03d253f90f882852d363068bdb80508f7e333b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/matheusspacifico/rlsspec/releases/download/v0.1.0/rlsspec-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8479bd06ef1129a35be9808a1f3cf3c0aa51b075841ec3e68122877248b6938d"
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
