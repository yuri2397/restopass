<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Compte;
use Illuminate\Http\Request;

class PayTechController extends Controller
{
    const URL_BASE = "https://paytech.sn/api";
    const COMMAND_NAME = "Achat de tickets";
    const HOST = "https://restopass-senegal.herokuapp.com";
    const PAYTECH = "https://paytech.sn";
    private $api_key;
    private $secret_key;

    public function __construct()
    {
        $this->api_key = env('PAYTECH_API_KEY');
        $this->secret_key = env('PAYTECH_SECRET_KEY');
    }

    /**
     * Apres payement
     */
    public function succss(Request $request)
    {
        return "AFTER PAYEMENT";
    }

    /**
     * ANNULATION
     */
    public function cancel(Request $request)
    {
        return "PAYEMENT ANNULER";
    }

    /**
     * IPN
     */
    public function ipn(Request $request)
    {
        # code...
    }

    public function payment(Request $request)
    {
        $this->validate($request, [
            'phone_number' => 'required',
            'amount' => 'required|numeric'
        ]);

        $user = User::find(auth()->id());
        $ref = $user->matricule . '_' . time();

        $customfield = json_encode([
            'email' => $user->email,
            'amount' => $request->amount,
            'phone_number' => $request->phone_number,
            'ref' => $ref,
        ]);

        $data = [
            'item_price' => $request->amount,
            "currency"     => "xof",
            "ref_command" => $ref,
            'item_name' => self::COMMAND_NAME,
            'command_name' =>  self::COMMAND_NAME,
            "success_url"  =>  self::HOST . '/api/pay-success',
            "ipn_url"      =>  self::HOST . '/api/pay-ipn',
            "cancel_url"   =>  self::HOST . '/api/pay-cancel',
            'env' => 'test',
            "custom_field" =>   $customfield,
        ];
        return $this->requestPayment($data);
    }

    private function requestPayment($data){
        $ch = curl_init(self::URL_BASE . "/payment/request-payment");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array_merge([
            "API_KEY: {$this->api_key}",
            "API_SECRET: {$this->secret_key}"
        ], [
            'Content-Type: application/x-www-form-urlencoded;charset=utf-8',
            'Content-Length: ' . mb_strlen(http_build_query($data))
        ]));

        $rawResponse = curl_exec($ch);

        $jsonResponse = json_decode($rawResponse, true);

        if($jsonResponse != null && $jsonResponse['success'] === 1){
            return response()->json($jsonResponse, 200);
        }
        else{
            return response()->json([
                "message" => "Une erreur c'est produit. Merci de réessayer plustard.",
                "code" => 500,
            ], 500);
        }
    }
}
