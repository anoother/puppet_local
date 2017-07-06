node deskside {
  include autogpu
  include nvidia
  include boinc
  include opal
}

node shadow {
  include desktop
  include autogpu
  include gvt
  include nvidia
  include opal
  include boinc
}
