<?php

namespace App\Controllers\MuV2;

use App\Controllers\BaseController;
use App\Models\Node;
use App\Models\TrafficLog;
use App\Models\User;
use App\Services\Config;
use App\Services\Logger;
use App\Storage\Dynamodb\TrafficLog as DynamoTrafficLog;
use App\Utils\Check;
use App\Utils\Hash;
use App\Utils\Http;
use App\Utils\Tools;

class UserController extends BaseController
{
    // Register Error Code
    const IllegalEmail = 502;
    const PasswordTooShort = 511;
    const EmailUsed = 521;
    const InvalidDownloadLimit = 531;
    const InvalidUploadLimit = 532;
    const InvalidUserID = 533;

    private $errors;

    // User List
    public function index($request, $response, $args)
    {
        $users = User::all();
        $res = [
            "msg" => "ok",
            "data" => $users
        ];
        return $this->echoJson($response, $res);
    }

    //   Update Traffic
    public function addTraffic($request, $response, $args)
    {
        // $data = json_decode($request->getParsedBody(),true);
        $id = $args['id'];
        $u = $request->getParam('u');
        $d = $request->getParam('d');
        $nodeId = $request->getParam('node_id');
        $node = Node::find($nodeId);
        $rate = $node->traffic_rate;
        $user = User::find($id);

        $user->t = time();
        $user->u = $user->u + ($u * $rate);
        $user->d = $user->d + ($d * $rate);
        if (!$user->save()) {
            $res = [
                "msg" => "update failed",
            ];
            return $this->echoJson($response, $res, 400);
        }
        // log
        $totalTraffic = Tools::flowAutoShow(($u + $d) * $rate);
        $traffic = new TrafficLog();
        $traffic->user_id = $id;
        $traffic->u = $u;
        $traffic->d = $d;
        $traffic->node_id = $nodeId;
        $traffic->rate = $rate;
        $traffic->traffic = $totalTraffic;
        $traffic->log_time = time();
        $traffic->save();

        $res = [
            "ret" => 1,
            "msg" => "ok",
        ];
        if (Config::get('log_traffic_dynamodb')) {
            try {
                $client = new DynamoTrafficLog();
                $id = $client->store($u, $d, $nodeId, $id, $totalTraffic, $rate);
                $res["id"] = $id;
            } catch (\Exception $e) {
                $res["msg"] = $e->getMessage();
                Logger::error($e->getMessage());
            }
        }
        return $this->echoJson($response, $res);
    }

    public function create($request, $response, $args)
    {
        $name = $request->getParam('name');
        $email = strtolower($request->getParam('email'));
        $download = $request->getParam('d');
        $upload = $request->getParam('u');
        $passwd = $request->getParam('password');

        if (!Check::isEmailLegal($email)) {
            $this->setErrors(self::IllegalEmail,"The email is not valid.");
        }
        $user = User::where('email', $email)->first();

        if ($user != null) {
           $this->setErrors(self::EmailUsed,"The email is already in use.");
        }

        // check pwd length
        if (strlen($passwd) < 8) {
            $this->setErrors(self::PasswordTooShort,"The Password is too short.");
        }
        
        // check pwd length
        if (!is_numeric($download)) {
            $this->setErrors(self::InvalidDownloadLimit,"The Download limit is not valid.");
        }
        
        if (!is_numeric($upload)) {
            $this->setErrors(self::InvalidUploadLimit,"The Upload limit is not valid.");
        }

        if(!$this->errors)
        {
            $user = new User();
            $user->user_name = $name;
            $user->email = $email;
            $user->pass = Hash::passwordHash($passwd);
            $user->passwd = $passwd;
            $user->port = Tools::getLastPort() + 1;
            $user->t = 0;
            $user->u = $upload;
            $user->d = $download;
            $user->transfer_enable = Tools::toGB(Config::get('defaultTraffic'));
            $user->invite_num = Config::get('inviteNum');
            $user->reg_ip = Http::getClientIP();
            $user->ref_by = 1;

            if (!$user->save())
            {
                $this->setErrors(532,"There was an error creating user.");
            }

        }
        $this->Response($response,$user);
    }


    public function ChangePassword($request, $response, $args)
    {
        $userid = $request->getParam('id');
        $password = $request->getParam('password');

        if(empty($password) || strlen($password) < 8)
            $this->setErrors(self::PasswordTooShort,'The Password is not valid.');

        $password = $request->getParam('password');
        $user = User::find($userid);

        if($user == NULL)
            $this->setErrors(self::InvalidUserID,'The User Id is not valid.');
        else{
            $user->update(['passwd' => $password]);
        }

        return $this->Response($response);
    }


    public function Suspend($request, $response, $args)
    {
        $userid = $request->getParam('id');

        $user = User::find($userid);

        if($user == NULL)
            $this->setErrors(self::InvalidUserID,'The User Id is not valid.');
        else{
            $user->delete();
        }

        return $this->Response($response);
    }


    public function Terminate($request, $response, $args)
    {
        $userid = $request->getParam('id');

        $user = User::find($userid);

        if($user == NULL)
            $this->setErrors(self::InvalidUserID,'The User Id is not valid.');
        else{
            $user->delete();
        }

        return $this->Response($response);
    }


    public function setErrors($code,$value){
        $this->errors[$code] = ['code' => $code,'error' => $value];
    }

    public function getErrors()
    {
        return $this->errors;
    }

    public function Response($response, $data = [])
    {
        if(count($this->errors) > 0)
            return $this->echoJson($response,['ret' => false,'msg' => 'error', 'errors' => $this->errors]);
        else
            return $this->echoJson($response,['ret' => true,'msg' => 'sucessfull', 'data' => $data]);
    }

}