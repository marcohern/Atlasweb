<?php

namespace App\Model\Table;

use Cake\ORM\Table;

class TokensTable extends Table {

	public function initialize(array $config)
    {
        $this->table('tokens');
        $this->primaryKey('id');
    }

    
}