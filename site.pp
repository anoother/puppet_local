node deskside {
  include autogpu
  include nvidia
}

node shadow {
  include desktop
  include autogpu
  include nvidia
  include opal
}
