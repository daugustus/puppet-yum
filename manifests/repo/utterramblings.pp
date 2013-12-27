# = Class: yum::repo::utterramblings
#
# This class installs the utterramblings repo
#
class yum::repo::utterramblings (
	$mirror_url = 'http://www.jasonlitka.com/EL5/\$basearch',
	$enabled = 1,
	$gpgcheck = 0,
	$gpgkey = undef,
	$priority = 1,
	$exclude = '',
) {

#  if $mirror_url {
#    validate_re(
#      $mirror_url,
#      '^(?:https?|ftp):\/\/[\da-zA-Z-][\da-zA-Z\.-]*\.[a-zA-Z]{2,6}\.?(?:\/[\w~-]*)*$',
#      '$mirror must be a Clean URL with no query-string, a fully-qualified hostname and no trailing slash.'
#    )
#  }

  # Workaround for Facter < 1.7.0
  $osver = split($::operatingsystemrelease, '[.]')

  case $::operatingsystem {
    'RedHat','CentOS','Scientific': {
      $release = "el${osver[0]}"
    }
    default: {
      fail("${title}: Operating system '${::operatingsystem}' is not currently supported")
    }
  }

	$baseurl_urepo = $mirror_url ? {
		undef	=> undef,
		default => "${mirror_url}/\$basearch",
	}

  yum::managed_yumrepo { 'utterramblings':
    descr			=> 'Utterramblings packages',
    baseurl		=> "${mirror_url}",
    enabled		=> $enabled,
    gpgcheck	=> $gpgcheck,
		gpgkey		=> $gpgkey,
    priority  => $priority,
    exclude		=> $exclude,
  }
}
