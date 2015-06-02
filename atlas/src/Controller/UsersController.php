<?php

namespace App\Controller;

class UsersController extends AppController {
	public function initialize() {
		parent::initialize();
	}

	public function index() {
		$users = $this->Users->find('all');

		$this->return_json($users);
	}

	public function view($id) {
		$user = $this->Users->find()->where(['id' => $id])->first();
		$this->return_json($user);
	}

	public function add() {
		$data = $this->get_payload();
		$user = $this->Users->newEntity($data);
		if ($this->Users->save($user)) {
			$this->return_json(['added' => true, 'id' => $user->id]);
		} else {
			throw new AppError('unable to add user');
		}
	}

	public function edit($id) {
		$data = $this->get_payload();
		$oldUser = $this->Users->get($id);
		if ($oldUser) {
			$newUser = $this->Users->newEntity($data);
			$this->Users->save($newUser);
			$this->return_json($newUser);
		} else {
			throw new AppError('unable to edit user');
		}
	}

	public function delete($id) {
		$user = $this->Users->get($id);
		if ($user) {
			$this->Users->delete($user);
			$this->return_json(['deleted' => true, 'id' => $user->id]);
		} else {
			throw new AppError('User not found');
		}
	}
}