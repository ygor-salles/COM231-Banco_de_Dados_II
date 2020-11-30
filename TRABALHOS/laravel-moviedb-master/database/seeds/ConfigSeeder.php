<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ConfigSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Roles
        $roles = array_map('addTimestamp', array_values(config('enums.roles')));
        DB::table('roles')->insert($roles);

        // Super admin user
        DB::table('users')->insert(['name' => 'Super Admin', 'email' => 'super@admin.com', 'password' => bcrypt('123456'), 'created_at' => DB::raw('CURRENT_TIMESTAMP'), 'updated_at' => DB::raw('CURRENT_TIMESTAMP')]);
        DB::table('model_has_roles')->insert(['role_id' => config('enums.roles.SUPER_ADMIN.id'), 'model_type' => 'App\User','model_id' => 1]);
   
        // Regular user
        DB::table('users')->insert(['name' => 'Rodrigo Porto', 'email' => 'rodrigo@comum.com', 'password' => bcrypt('123456'), 'created_at' => DB::raw('CURRENT_TIMESTAMP'), 'updated_at' => DB::raw('CURRENT_TIMESTAMP')]);
        DB::table('model_has_roles')->insert(['role_id' => config('enums.roles.REGULAR.id'), 'model_type' => 'App\User','model_id' => 2]);
      
        // Super admin user
        DB::table('users')->insert(['name' => 'Fábio Piovani', 'email' => 'fabio@premium.com', 'password' => bcrypt('123456'), 'created_at' => DB::raw('CURRENT_TIMESTAMP'), 'updated_at' => DB::raw('CURRENT_TIMESTAMP')]);
        DB::table('model_has_roles')->insert(['role_id' => config('enums.roles.PREMIUM.id'), 'model_type' => 'App\User','model_id' => 3]);
    }
}
