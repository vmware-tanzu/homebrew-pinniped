class PinnipedCli < Formula
    desc "Pinniped CLI for Kubernetes cluster authentication"
    homepage "https://pinniped.dev/"
    url "https://github.com/vmware-tanzu/pinniped.git",
        tag:      "v0.35.0",
        revision: "aa70ff13f404753f12ff52590fd5a70f3aa10de0"
    license "Apache-2.0"
    head "https://github.com/vmware-tanzu/pinniped.git", branch: "main"
    
    depends_on "go" => :build
    depends_on "libtool"
  
    def install
      rm_rf ".brew_home"
      unless version.to_s.include? "HEAD"
        ENV["KUBE_GIT_VERSION"] = "v#{version.to_s}" 
      end 
      system "go build -o #{bin}/pinniped -ldflags \"$(hack/get-ldflags.sh)\" ./cmd/pinniped"
    end
  
    test do
      run_output = shell_output("#{bin}/pinniped")
      assert_match "pinniped is the client-side binary for use with Pinniped-enabled Kubernetes clusters.", run_output
    end
  end