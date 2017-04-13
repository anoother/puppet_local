node 'shadow' {
  include desktop
  include multigpu
  include opal
}

node 'deskside' {
  include multigpu
}
