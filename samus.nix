{
  hardware = {
    pulseaudio.enable=true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };
  boot.extraModprobeConfig = ''
    options snd_soc_sst_bdw_rt5677_mach index=0
    options snd-hda-intel index=1
  '';
}