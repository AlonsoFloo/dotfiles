# To learn more about how to use Nix to configure your environment
# see: https://firebase.google.com/docs/studio/customize-workspace
{ pkgs, ... }: {
  channel = "stable-24.05";

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python3
    pkgs.pre-commit
  ];

  # Sets environment variables in the workspace
  env = {
    # PATH modifications if required
    # PATH = [ "/some/custom/bin" ];
  };

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];

    # Enable previews
    previews = {
      enable = true;
      previews = {
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };
      };
    };

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Example: install JS dependencies from NPM
        # npm-install = "npm install";

        # files to open when the workspace is first opened.
        default.openFiles = [ "README.md" ];
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";

        # Install pre-commit
        pre-commit-install = "pre-commit install";

        # Load all submodules
        git-submodules = "git submodule update --init --recursive";

        # Load aliases of git 
        git-config-aliases-st = "git config --global alias.st status";
        git-config-aliases-unstage = "git config --global alias.unstage reset HEAD --";
        git-config-aliases-diffc = "git config --global alias.diffc diff --cached";
      };
    };
  };
}
