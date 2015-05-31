<?php
namespace App\Controller;

use Cake\Controller\Controller;


define("APP_ACCEPT_JSON",'application/json');

class AppController extends Controller
{

    public function initialize()
    {
        parent::initialize();
        $this->loadComponent('Flash');
        $this->layout = 'blank';
    }

    protected function return_json($data) {
        $this->set('data', $data);
        $this->set('_serialize','data');
    }

    protected function return_unauthorized($data) {
        $this->set('data', $data);
        $this->set('_serialize','data');
    }

    protected function get_payload() {
        $body = file_get_contents("php://input");
        $json = json_decode($body, true);
        if (!is_array($json)) return array();
        return $json;
    }

    protected function get_request() {
        $payload = $this->get_payload();
        $query = array_merge($payload, $this->request->query);
        $post = array_merge($query, $this->request->data);
        return $post;
    }

    protected function get_accept() {
        $accept = $this->request->header('Accept');
        $accarr = array_map('trim', explode(',', $accept));
        if (in_array(APP_ACCEPT_JSON, $accarr)) {
            return 'json';
        } else {
            return 'default';
        }
    }
}
