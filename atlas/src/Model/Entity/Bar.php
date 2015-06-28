<?php

namespace App\Model\Entity;

use Cake\ORM\Entity;

class Bar extends Entity
{
	protected $_virtual = ['image_url'];

	protected function _getImageUrl()
    {
    	if (array_key_exists('slug', $this->_properties)) {
        	return '/img/bar-headers/'.$this->_properties['slug'].'-hd.png';
        }
        return '';
    }
}
