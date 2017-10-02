node deskside {
  include autogpu
  include nvidia
  include boinc
  include opal
  include desktop
}

node shadow {
  include desktop
  include laptop
  include autogpu
  include gvt
  include vega
  include opal
  include boinc
}
