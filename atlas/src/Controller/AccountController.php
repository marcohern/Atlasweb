<?php

namespace App\Controller;

use Cake\ORM\TableRegistry;

use App\Model\Entity\User;

use App\Controller\Component;

use Cake\Event\Event;
use Cake\Datasource\ConnectionManager;

use Cake\Datasource\Exception\RecordNotFoundException;

class AccountController extends AppController {

    private function login_view() {

    }

    private function login_request() {
        $input = $this->get_payload();
        
        $username = $input['username'];
        $password = $input['password'];

        $token = $this->Soteira->login($username, $password);

        $this->return_json($token);
    }

	public function initialize()
    {
        parent::initialize();

        $this->layout = 'GioOne/default';

        $this->Soteira->allow(['create_admin','create_token','create_app','clear_all_tokens','login']);
    }

    public function create_app() {

        $appsTable = TableRegistry::get('Apps');
        
        try {
            $x = $appsTable->get(1);
            $appsTable->delete($x);
        } catch (RecordNotFoundException $ex) {
            $this->log($ex);
        }

        $app = $appsTable->newEntity();
        $app->id = 1;
        $app->code = "Atlas";
        $app->sender_id = uniqid();
        $app->sender_secret = $this->Soteira->generateSalt();
        $app->permissions = "users,places,events,routes";
        $app->created = new \Datetime("now");
        $appsTable->save($app);

        $this->return_json($app);
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
    	if ($this->get_accept() == 'json') {
            $this->login_request();
        } else {
            $this->login_view();
        }
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