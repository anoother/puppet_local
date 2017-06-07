node deskside {
  include autogpu
  include nvidia
  include boinc
}

node shadow {
  include desktop
  include autogpu
  include nvidia
  include opal
  include boinc
}
