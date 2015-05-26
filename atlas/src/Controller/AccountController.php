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
    	$admin->created = new \Datetime("now");

    	$usersTable->save($admin);

    	$result = array(
    		'input' => $admin,
    		'output' => $usersTable->get(1)
    	);

    	$this->return_json($result);
    }

    public function create_token() {
        
        $tokensTable = TableRegistry::get('Tokens');
        $token = $tokensTable->newEntity();
        $token->token = $this->Soteira->generateToken();
        $token->id = null;
        $token->user_id = 1;
        $token->created = new \Datetime("now");
        $token->expires = new \Datetime("tomorrow");

        $tokensTable->save($token);
        
        $this->return_json($token);
    }

    public function login() {
    	$input = $this->get_payload();
    	$this->log($input);
    	
    	$usersTable = TableRegistry::get('Users');

    	$username = $input['username'];
    	$password = $input['password'];

    	$user = $usersTable->find()->where(['username' => $username])->first();
    	$this->log($user);
    	$salt = $user->salt;
    	$pwd = $this->Soteira->hashPassword($password, $salt);

    	$o = ['message' => "OK", 'errnum' => 0];
    	if ($pwd != $user->password) {
    		$o['message'] = "Username or password invalid";
    		$o['errnum'] = 1;
    	}
    	
    	$data = [
    		'input' => $input,
    		'output' => $o
    	];
    	$this->return_json($data);
    }

    public function logout() {

    }
}

?>