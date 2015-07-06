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
        $this->loadComponent('RequestHandler');
        $this->loadComponent('Soteira');
        $this->layout = 'blank';
    }

    protected function return_json($data) {
        if (empty($data)) $data=[];
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

    private function get_query_int($param, $default) {
        $result = $default;
        if (array_key_exists($param, $this->request->query)) {
            $result = $this->request->query[$param];
        }
        if (empty($result)) {
            return $default;
        }
        return 0+$result;
    }

    private function get_query_string($param, $default) {
        $result = $default;
        if (array_key_exists($param, $this->request->query)) {
            $result = $this->request->query[$param];
        }
        if (!is_string($result)) {
            return $default;
        }
        return $result;
    }

    protected function get_query_numeric($param, $default) {
        $result = $default;
        if (array_key_exists($param, $this->request->query)) {
            $result = $this->request->query[$param];
        }
        $result = 0+$result;
        if (empty($result)) {
            return $default;
        }
        return 0+$result;
    }

    protected function get_qlimit() {
        return $this->get_query_int('l', 10);
    }

    protected function get_qoffset() {
        return $this->get_query_int('o', 0);
    }

    protected function get_q() {
        return $this->get_query_string('q', '');
    }

    protected function is_count() {
        if (array_key_exists('count', $this->request->query)) {
            return true;
        }
        return false;
    }

    protected function is_extended() {
        if (array_key_exists('extended', $this->request->query)) {
            return true;
        }
        return false;
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
