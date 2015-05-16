<?php

namespace App\Model\Entity;

use Cake\ORM\Entity;

class User extends Entity
{


    public function __toString() {
    	return json_encode(array(
    		'id' => $this->id,
    		'username' => $this->username,
    		'email' => $this->email,
    		'fname' => $this->fname,
    		'lname' => $this->lname,
    		'role' => $this->role,
    		'created' => time("Y-m-d H:i:s",$this->created)
    	));
    }
}

?>