{
	disko.devices = {
		disk = {
			vda = {
				type = "disk";
				device = "/dev/vda";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							label = "boot";
							name = "ESP";
							size = "512M";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [
									"defaults"
								];
							};
						};
						luks = {
							size = "100%";
							label = "luks";
							content = {
								type = "luks";
								name = "cryptroot";
								extraOpenArgs = [
									"--allow-discards"
									"--perf-no_read_workqueue"
									"--perf-no_write_workqueue"
								];

								content = {
									type = "btrfs";
									extraArgs = ["-L" "nixos" "-f"];
									subvolumes = {
										"/root" = {
											mountpoint = "/";
											mountOptions = [ "subvol=root" "compress=zstd" ];
										};
										"/home" = {
											mountpoint = "/home";
											mountOptions = [ "subvol=home" "compress=zstd" ];
										};
										"/nix" = {
											mountpoint = "/nix";
											mountOptions = [ "subvol=nix" "compress=zstd" "noatime" ];
										};
										"/swap" = {
											mountpoint = "/swap";
											swap.swapfile.size = "32G";
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
}

