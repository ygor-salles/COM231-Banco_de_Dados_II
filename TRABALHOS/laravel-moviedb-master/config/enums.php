<?php

return [
    'roles' =>
    [
        'SUPER_ADMIN' => ['id' => 1, 'name' => 'super_admin', 'display_name' => 'Super Administrador', 'guard_name' => 'web'],
        'ADMIN' => ['id' => 2, 'name' => 'admin', 'display_name' => 'Administrador', 'guard_name' => 'web'],
        'PREMIUM' => ['id' => 3, 'name' => 'premium', 'display_name' => 'Usuário premium', 'guard_name' => 'web'],
        'REGULAR' => ['id' => 4, 'name' => 'regular', 'display_name' => 'Usuário comum', 'guard_name' => 'web'],
    ],
];
