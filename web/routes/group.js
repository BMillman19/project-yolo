// Helper method to 
function getChildren(groupid, allDescendents) {
  var all = existsOrElse(allDescendents, false)
    , r;
  if (all) {
    // All descendents
    r = new RegExp(groupid + ',' );
  } else {
    // Only immediate children
    r = new RegExp(groupid + '$');
  }
  Models.Group.find({
    path: r
  }, function (err, data) {
    if (err) {
      exception.sendUnkE(res, err);
    } else {
      return data;
    }
  });
}

/**
 * GET /group/:id
 * Returns a single group with owner
 * @param req req.params.id should be the ObjectId for the desired group
 */
exports.getGroup = function (req, res) {
  var params = req.params;
  // TODO: Check view permissions
  Models.Group.findOne({_id: params.id})
    .populate('owner', ['_id', 'email', 'name'])
    .exec( function (err, data) {
      if (err) { exception.sendUnkE(res, err); return; }
      if (!data) {
        exception.sendE(res, 'NOT_FOUND_EXCEPTION', {group: params.id});
        return;
      }
      res.json(data);
    });
}

/**
 * GET /group/tree/:id
 * Returns a group + its descendents
 * @param req req.params.id should be the ObjectId for the root group
 */
exports.getGroupTree = function (req, res) {
  var params = req.params;
  // TODO: this method lolz
}

/**
 * POST /group/create
 * Creates a new group with a given parent or as an independent group
 * @param req req.body should have name and owner; optionally specify parent and members
 */
exports.createGroup = function (req, res) {
  var params = req.body;
  params = _(params).pick(
    'parent',
    'name',
    'owner',
    'members'
  );
  // TODO: Check authorization for admin access to parent node
  // TODO: Verify that group names with same parent don't conflict
  if (exists(params.parent)) {
    // Find parent in order to inherit path
    Models.Group.findOne({
      _id: params.parent
    }, function (err, data) {
      if (err) { exception.sendUnkE(res, err); return; }
      if (!data) {
        exception.sendE(res, 'NOT_FOUND_EXCEPTION', {group: params.parent});
        return;
      }
      var newPath;
      if (exists(data.path) && data.path.length > 0) {
        newPath = data.path + ',' + data._id;
      } else {
        newPath = data._id;
      }
      var groupParams = _.extend({}, params, {path: newPath})
        , group = new Models.Group(groupParams);
      console.log(newPath);
      group.save(function (err) {
        if (err) {
          exception.sendE(res, 'VALIDATION_EXCEPTION', err.errors);
        } else {
          res.send(201);
        }
      });
    });
  } else {
    // If no parent specified, treat group as root
    group = new Models.Group(_.extend({}, params, {path: ''}));
    group.save(function (err) {
      if (err) {
        exception.sendE(res, 'VALIDATION_EXCEPTION', err.errors);
      } else {
        res.send(201);
      }
    });
  }
}
