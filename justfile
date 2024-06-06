add:
  just format
  git add .

#updates user packages via home-manager
dup:
  just add
  home-manager switch --flake ~/.nixfiles

# same as dup but backups configs before overwriting
dupb:
  just add
  home-manager switch -b backup --flake ~/.nixfiles 

[no-cd]
format:
  nixpkgs-fmt ~/.nixfiles
  npx prettier --ignore-unknown --write "/home/bane/.nixfiles/**/*.{css,js,ts,json,yaml,toml}"

commit message="update":
  just add
  git commit -m "{{message}}"

push message="update":
  just commit "{{message}}"
  git push

