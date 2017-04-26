node deskside {
  include multigpu
  include nvidia
}

node shadow {
  include desktop
  include multigpu
  include nvidia
  include opal
}
