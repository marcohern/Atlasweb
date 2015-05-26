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

        $this->Soteira->addPrivates(['private_action']);
    }

    public function create_admin() {
    	$usersTable = TableRegistry::get('Users');
    	
    	try {
    		$x = $usersTable->get(1);
    		$usersTable->delete($x);
    	} catch (RecordNotFoundException $ex) {
    		$this->log($ex);
    	}

    	$admin = $this->Soteira->newUser(1, 'marcohern','password',
            'marcohern@gmail.com','Marco','Hernandez','ADMIN');

    	$usersTable->save($admin);

    	$result = array(
    		'input' => $admin,
    		'output' => $usersTable->get(1),
            'auth' => $this->request->header('Token')
    	);

    	$this->return_json($result);
    }

    public function create_token() {
        
        $tokensTable = TableRegistry::get('Tokens');
        
        $token = $this->Soteira->newToken(null, 1);

        $tokensTable->save($token);

        $this->return_json($token);
    }

    public function clear_all_tokens() {
        $results = $this->Soteira->clearAllTokens();
        $this->return_json($results);
    }

    public function login() {
    	$input = $this->get_payload();
    	
    	$username = $input['username'];
    	$password = $input['password'];

    	$token = $this->Soteira->login($username, $password);

    	$this->return_json($token);
    }

    public function logout() {

    }

    public function private_action() {
        $this->return_json(array(
            'message' => 'This is a private action'
        ));
    }
}

?>