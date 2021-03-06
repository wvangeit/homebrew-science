class Igv < Formula
  desc "Interactive Genomics Viewer"
  homepage "https://www.broadinstitute.org/software/igv"
  # tag "bioinformatics"
  # doi "10.1093/bib/bbs017"
  url "https://www.broadinstitute.org/igv/projects/downloads/IGV_2.3.94.zip"
  sha256 "483f3ec065498dd67117faa51b632cbd8d25c470ac0433d65fb3411aa021439b"
  head "https://github.com/broadinstitute/IGV.git"

  devel do
    url "https://www.broadinstitute.org/igv/projects/downloads/snapshot/IGV_snapshot.zip"
    sha256 "a294f35c1255cfe1716d381925db69a5b009f528a151a311fdc5be24a79f7501"
    version "2017-05-19"
  end

  bottle :unneeded

  depends_on :java

  def install
    inreplace "igv.sh", /^prefix=.*/, "prefix=#{prefix}"
    prefix.install Dir["igv.sh", "*.jar"]
    bin.install_symlink prefix/"igv.sh" => "igv"
    doc.install "readme.txt" unless build.devel?
  end

  test do
    ENV.append "_JAVA_OPTIONS", "-Duser.home=#{testpath}/java_cache"
    (testpath/"script").write "exit"
    # This command returns 0 on Circle and Travis but 1 on BrewTestBot.
    assert_match "Version", `#{bin}/igv -b script`
  end
end
