<?php

// In src/Error/AppError.php
namespace App\Error;

use Cake\Error\BaseErrorHandler;

class AppError extends BaseErrorHandler
{
    public function _displayError($error, $debug)
    {
        return 'There has been an error!';
    }
    public function _displayException($exception)
    {
        return 'There has been an exception!';
    }
}