class vega {

require apt

  $firmware_source = "https://people.freedesktop.org/~agd5f/radeon_ucode/vega10"
  wget::fetch { [
    "${firmware_source}/vega10_acg_smc.bin",
    "${firmware_source}/vega10_asd.bin",
    "${firmware_source}/vega10_ce.bin",
    "${firmware_source}/vega10_gpu_info.bin",
    "${firmware_source}/vega10_me.bin",
    "${firmware_source}/vega10_mec.bin",
    "${firmware_source}/vega10_mec2.bin",
    "${firmware_source}/vega10_pfp.bin",
    "${firmware_source}/vega10_rlc.bin",
    "${firmware_source}/vega10_sdma.bin",
    "${firmware_source}/vega10_sdma1.bin",
    "${firmware_source}/vega10_smc.bin",
    "${firmware_source}/vega10_sos.bin",
    "${firmware_source}/vega10_uvd.bin",
    "${firmware_source}/vega10_vce.bin",
  ]:
      destination => '/lib/firmware/amdgpu/',
  }

  apt::ppa { 'ppa:paulo-miguel-dias/mesa':
    before =>  Exec['apt_update'], 
  } ->

  package {[
    'xserver-xorg-core-hwe-16.04'
  ]: ensure => purged,
  }

}
