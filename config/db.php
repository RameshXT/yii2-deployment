<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => 'pgsql:host=yii2db.catigkm00gyz.us-east-1.rds.amazonaws.com;port=5432;dbname=your_database_name',
    'username' => 'yii2db',
    'password' => 'yii2db*28',
    'charset' => 'utf8',

    // Schema cache options (for production environment)
    'enableSchemaCache' => true,
    'schemaCacheDuration' => 60,
    'schemaCache' => 'cache',
];
