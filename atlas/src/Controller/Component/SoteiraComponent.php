<?php

namespace App\Controller\Component;

use Cake\Controller\Component;
use Cake\Utility\Security;
use Cake\ORM\TableRegistry;
use Cake\Event\Event;
use Cake\Network\Exception\UnauthorizedException;

define("SOTEIRA_SALT_LEN", 40);
define("SOTEIRA_SALT_TPL", "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");

class SoteiraComponent extends Component
{
	public $private_actions = array();

	public $components = ['Security'];

	public function addPrivates(array $privates) {
		$this->private_actions = array_merge($this->private_actions, $privates);
	}

	public function generateSalt() {
		$l = strlen(SOTEIRA_SALT_TPL);		
		$s = '';
		for ($i=0; $i<SOTEIRA_SALT_LEN; $i++) {
			$r = rand(0, $l);
			$s .= substr(SOTEIRA_SALT_TPL,$r,1);
		}
		return $s;
	}

    public function hashPassword($password, $salt) {

    	return Security::hash($password, 'sha256', $salt);
    }

    public function generateToken() {
    	return Security::hash(uniqid(mt_rand(), true), 'md5', '');
    }

    public function newUser($id,$username,$password,$email, $fname, $lname, $role) {
    	$usersTable = TableRegistry::get('Users');
    	$salt = $this->generateSalt();
    	$pwd = $this->hashPassword($password,$salt);

    	$user = $usersTable->newEntity();
    	$user->id = $id;
    	$user->username = $username;
    	$user->email = $email;
    	$user->password = $pwd;
    	$user->salt = $salt;
    	$user->fname = $fname;
    	$user->lname = $lname;
    	$user->role = $role;
    	$user->created = new \Datetime("now");
    	$user->updated = null;

    	return $user;
    }

    public function newToken($id, $user_id) {
    	$tokensTable = TableRegistry::get('Tokens');
        $token = $tokensTable->newEntity();
        $token->token = $this->generateToken();
        $token->id = $id;
        $token->user_id = $user_id;
        $token->created = new \Datetime("now");
        $token->expires = new \Datetime("tomorrow");
        return $token;
    }

    public function clearAllTokens() {
    	$tokensTable = TableRegistry::get('Tokens');
    	$count = $tokensTable->find()->count();
    	$tokensTable->deleteAll(array());
    	return array('deleted' => $count);
    }

    public function login($username, $password) {
    	$o = array('error' => 0, 'message' => 'OK', 'user' => null,'token' => null);

    	$usersTable = TableRegistry::get('Users');
    	$tokensTable = TableRegistry::get('Tokens');
    	$user = $usersTable->find()->where(['username' => $username])->first();
    	if ($user) {
	    	$salt = $user->salt;
	    	$pwd = $this->hashPassword($password, $salt);
	    	if ($pwd === $user->password) {

	    		$token = $this->newToken(null, $user->id);
	    		$tokensTable->save($token);
	    		return $tokensTable->get($token->id);
	    	} else {
	    		throw new UnauthorizedException("Pasword invalid");
	    	}
    	} else {
	    	throw new UnauthorizedException("User does not exists");
    	}
    	return $o;
    }

    public function beforeFilter(Event $event) {
    	//$controller = $event->subject();
    	$tokensTable = TableRegistry::get('Tokens');
    	$token_string = $this->request->header('Token');
    	if (is_null($token_string)) {
	    	foreach ($this->private_actions as $pv) {
		    	if ($this->request->params['action'] == $pv) {
		    		throw new UnauthorizedException("Authorization Empty, Access denied $pv");
		    	}
	    	}
    	} else {
    		$token = $tokensTable->find()->where(['token' => $token_string])->first();
    		if ($token) {
    			//Everything is fine, continue
    		} else {
    			throw new UnauthorizedException("Token $token_string invalid");
    		}
    	}
    }
}

?>