class config::repositories {

  repository { "${::boxen_srcdir}/map_tile_loader":
    source => 'lonelyplanet/map_tile_loader',
  }

  repository { "${::boxen_srcdir}/lpos-chef-repo":
    source => 'lonelyplanet/lpos-chef-repo',
  }

  repository { "${::boxen_srcdir}/spp_dashboard":
    source => 'lonelyplanet/spp_dashboard',
  }

  repository { "${::boxen_srcdir}/spp_aws":
    source => 'lonelyplanet/spp_aws',
  }

  repository { "${::boxen_srcdir}/deployment_tools":
    source => 'lonelyplanet/deployment_tools',
  }

  repository { "${::boxen_srcdir}/blog":
    source => 'lonelyplanet/blog',
  }
}
