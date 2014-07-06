require "formula"

class Tecsgen < Formula
  homepage "http://www.toppers.jp/tecs.html"
  url "https://github.com/NSaitoNmiri/tecsgen.git", :using => :git
  # url "http://www.toppers.jp/download.cgi/MrubyBridgePluginPackage-130616.tgz"
  sha1 ""
  version "1.1.0.26"

  # depends_on "ruby"
  # depends_on "runit"
  depends_on "racc" => :ruby

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    prefix.install Dir["*"]

    bin.mkpath

    genDst = Pathname("tecsgen").expand_path(bin)
    genSrc = Pathname("tecsgen/tecsgen.rb").expand_path(bin.parent)
    FileUtils.ln_sf genSrc.relative_path_from(genDst.parent), genDst

    mergeDst = Pathname("tecsmerge").expand_path(bin)
    mergeSrc = Pathname("tecsgen/tecsmerge.rb").expand_path(bin.parent)
    FileUtils.ln_sf mergeSrc.relative_path_from(mergeDst.parent), mergeDst

    ohai "To use tecsgen, an environment variable must be set."
    ohai "RUBYLIB=/usr/local/opt/tecsgen/tecsgen"
    ohai "TECSPATH=/usr/local/opt/tecsgen/tecs"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test tecsgen`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
