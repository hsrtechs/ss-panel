<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\Node;

class NodeController extends AdminController
{
    public function index($request, $response, $args)
    {
        $nodes = Node::all();
        return $this->view()->assign('nodes', $nodes)->display('admin/node/index.tpl');
    }

    public function create($request, $response, $args)
    {
        return $this->view()->display('admin/node/create.tpl');
    }

    public function add($request, $response, $args)
    {
        $node = new Node();
        $node->name = $request->getParam('name');
        $node->server = $request->getParam('server');
        $node->method = $request->getParam('method');
        $node->custom_method = $request->getParam('custom_method');
        $node->traffic_rate = $request->getParam('rate');
        $node->info = $request->getParam('info');
        $node->type = $request->getParam('type');
        $node->status = $request->getParam('status');
        $node->sort = $request->getParam('sort');
        if (!$node->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "Failed to add";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "Successfully Added";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        if ($node == null) {

        }
        return $this->view()->assign('node', $node)->display('admin/node/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);

        $node->name = $request->getParam('name');
        $node->server = $request->getParam('server');
        $node->method = $request->getParam('method');
        $node->custom_method = $request->getParam('custom_method');
        $node->traffic_rate = $request->getParam('rate');
        $node->info = $request->getParam('info');
        $node->type = $request->getParam('type');
        $node->status = $request->getParam('status');
        $node->sort = $request->getParam('sort');
        if (!$node->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "Failed to modify";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "Successfully modified";
        return $response->getBody()->write(json_encode($rs));
    }


    public function delete($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        if (!$node->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "Failed to delete";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "Successfully deleted";
        return $response->getBody()->write(json_encode($rs));
    }

    public function deleteGet($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        $node->delete();
        return $this->redirect($response, '/admin/node');
    }
}
