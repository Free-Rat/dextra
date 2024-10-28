# flake.nix
{
	outputs = { self, nixpkgs, flake-utils, }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = nixpkgs.legacyPackages.${system};

				lib-path = with pkgs; lib.makeLibraryPath [
					swift
					swiftpm
					swiftPackages.Foundation
					swift-corelibs-libdispatch
					ncurses6
				];
			in
				{
				devShells.default = pkgs.mkShell.override { stdenv = pkgs.swift.stdenv; } {
					buildInputs = with pkgs;[
						swift
						swiftpm
						swiftPackages.Foundation
						ncurses6
						# darwin.apple_sdk.frameworks.AppKit
					];

					shellHook = ''
			export PS1='\n\[\033[1;32m\][nix-shell:\w]\$\[\033[0m\] '

			export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
			export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}

					'';
				};
			});
}
