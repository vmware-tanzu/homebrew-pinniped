class PinnipedCli < Formula
    desc "Pinniped CLI for Kubernetes cluster authentication"
    homepage "https://pinniped.dev/"
    url "https://github.com/vmware-tanzu/pinniped.git",
        tag:      "v0.13.0",
        revision: "dea9bf9b90217f11aa3992b351fee72ef45fe1c5"
    license "Apache-2.0"
    head "https://github.com/vmware-tanzu/pinniped.git", branch: "main"
    
    depends_on "go" => :build
    depends_on "libtool"
  
    def install
      rm_rf ".brew_home"
      unless version.to_s.include? "HEAD"
        ENV["KUBE_GIT_VERSION"] = "v#{version.to_s}" 
      end 
      system "go build -o #{bin}/pinniped -ldflags \"$(hack/get-ldflags.sh)\" cmd/pinniped/main.go"
    end
  
    test do
      run_output = shell_output("#{bin}/pinniped")
      assert_match "pinniped is the client-side binary for use with Pinniped-enabled Kubernetes clusters.", run_output
    end
  end