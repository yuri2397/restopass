<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RestoController;
use App\Http\Controllers\VigilController;
use App\Http\Controllers\CompteController;
use App\Http\Controllers\PayTechController;
use App\Http\Controllers\EtudiantController;
use App\Http\Controllers\Admin\Auth\AuthController;

/**
 * AUTH ROUTES
 */

Route::prefix('admin')->middleware(['auth:admin', 'cors'])->group(function () {
    Route::post('/login', [AuthController::class, 'login'])
        ->name('admin-login')
        ->withoutMiddleware('auth:admin');

    Route::post('/register', [AuthController::class, 'register'])
        ->name('admin-register');

    Route::post('admin/logout', [AuthController::class, 'logout'])
        ->name("admin-logout");

    Route::post('affecter-vigil', [VigilController::class, 'affecterA']);
});




Route::prefix('resto')->middleware(['auth:admin'])->group(function () {
    Route::get('/', [RestoController::class, 'index']);
});

Route::prefix('etudiant')->middleware(['auth:api'])->group(function () {
    Route::post('/register', [EtudiantController::class, 'store'])->withoutMiddleware('auth:api');
    Route::post('/login', [EtudiantController::class, 'login'])->withoutMiddleware('auth:api');
    Route::get('/', [EtudiantController::class, 'user']);

    Route::post('pin', [CompteController::class, 'createPin']);
    Route::patch('pin', [CompteController::class, 'setPin']);
    Route::patch('code', [CompteController::class, 'setAccountCode']);

    Route::post('transfert', [CompteController::class, 'transfert']);
    Route::get('transfert', [CompteController::class, 'transferts']);

    Route::get('/payments', [RestoController::class, 'userPayments']);

    Route::post('/edit-password', [EtudiantController::class, 'editPassword']);
    Route::post('/edit-pin', [CompteController::class, 'editPin']);
    Route::post('/reset-pin', [CompteController::class, 'resetPin'])->withoutMiddleware('auth:api');

    // demande de réinitialisation de mot de passe
    Route::post('/reset-password', [EtudiantController::class, 'resetPassword'])->withoutMiddleware('auth:api');
    Route::post('/new-password', [EtudiantController::class, 'newPassword'])->withoutMiddleware('auth:api');
});

Route::prefix('vigil')->middleware(['auth:controller'])->group(function () {
    Route::post('/register', [VigilController::class, 'store'])->withoutMiddleware('auth:controller');
    Route::post('/login', [VigilController::class, 'login'])->withoutMiddleware('auth:controller');
    Route::post('/logout', [VigilController::class, 'logout']);

    Route::get('/', [VigilController::class, 'user']);
    Route::post('/scanner', [VigilController::class, 'scanner']);
});

Route::get('tarifs',  [RestoController::class, 'tarifs'])->middleware(['auth:controller']);

Route::middleware(['auth:api'])->group(function () {
    Route::post('/payment', [PayTechController::class, 'payment']);

    Route::post('/pay-ipn', [PayTechController::class, 'ipn'])->withoutMiddleware('auth:api');
    Route::get('/pay-cancel', [PayTechController::class, 'cancel'])->withoutMiddleware('auth:api');
    Route::get('/pay-success', [PayTechController::class, 'succss'])->withoutMiddleware('auth:api');
});
