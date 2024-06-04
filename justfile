default:
  @just --list

format:
  nixpkgs-fmt ~/.nixfiles
  npx prettier --ignore-unknown --write ~/.nixfiles

add:
  just format
  git add .

commit message="update":
  just add
  git commit -m "{{message}}"

push message="update":
  just commit message="{{message}}"
  git push

