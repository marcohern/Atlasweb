<?php

namespace App\Controller;

use Cake\ORM\TableRegistry;

use App\Model\Entity\User;

use App\Controller\Component;

use Cake\Event\Event;
use Cake\Datasource\ConnectionManager;

use Cake\Datasource\Exception\RecordNotFoundException;

class AccountController extends AppController {

	public function initialize()
    {
        parent::initialize();
        $this->loadComponent('RequestHandler');
        $this->loadComponent('Soteira');
    }

    public function create_admin() {
    	$usersTable = TableRegistry::get('Users');
    	
    	try {
    		$x = $usersTable->get(1);
    		$usersTable->delete($x);
    	} catch (RecordNotFoundException $ex) {
    		$this->log($ex);
    	}

    	$salt = $this->Soteira->generateSalt();
    	$pwd = $this->Soteira->hashPassword('password',$salt);

    	$admin = $usersTable->newEntity();
    	$admin->id = 1;
    	$admin->username = 'marcohern';
    	$admin->email = 'marcohern@gmail.com';
    	$admin->password = $pwd;
    	$admin->salt = $salt;
    	$admin->fname = 'Marco';
    	$admin->lname = 'Hernandez';
    	$admin->role = 'ADMIN';
    	$admin->created = time("Y-m-d H:i:s");

    	$usersTable->save($admin);

    	$result = array(
    		'input' => $admin,
    		'output' => $usersTable->get(1)
    	);

    	$this->return_json($result);
    }
}

?>