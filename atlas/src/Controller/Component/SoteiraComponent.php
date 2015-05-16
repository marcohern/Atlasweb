<?php

namespace App\Controller\Component;

use Cake\Controller\Component;
use Cake\Utility\Security;

define("SOTEIRA_SALT_LEN", 40);

class SoteiraComponent extends Component
{

	public $components = ['Security'];

	public function generateSalt() {
		$m = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		$l = strlen($m);		
		$s = '';
		for ($i=0; $i<SOTEIRA_SALT_LEN; $i++) {
			$r = rand(0, $l);
			$s .= substr($m,$r,1);
		}
		return $s;
	}

    public function hashPassword($password, $salt) {
    	//$this->loadComponent('Security');

    	return Security::hash($password, 'sha256', $salt);
    }
}

?>