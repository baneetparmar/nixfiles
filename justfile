set quiet

add:
  just format
  @echo "Adding git files...."
  git add .

#updates user packages via home-manager
dup:
  just add
  @echo "Updating home-manager...."
  home-manager switch --flake ~/.nixfiles
  @echo "Done!...."

# same as dup but backups configs before overwriting
dupb:
  just add
  @echo "Backing up configs.... \n Done!. \n Updating home-manager...."
  home-manager switch -b backup --flake ~/.nixfiles 
  @echo "Done!...."

[no-cd]
format:
  @echo "Formatting files...."
  nixpkgs-fmt ~/.nixfiles
  npx prettier --ignore-unknown  --no-error-on-unmatched-pattern --log-level silent --write "/home/bane/.nixfiles/**/*.{css,js,ts,json,yaml,toml}"
  @echo "Done!...."

commit message="update":
  just add
  @echo "Commiting git files...."
  git commit -m "{{message}}"

push message="update":
  just commit "{{message}}"
  @echo "Pushing git files...."
  git push
  @echo "Done!..."

