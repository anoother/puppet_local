node deskside {
  include autogpu
  include nvidia
  include opal
}

node shadow {
  include desktop
  include autogpu
  include nvidia
  include opal
}
