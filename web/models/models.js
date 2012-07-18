var Schema = mongoose.Schema
  , ObjectId = Schema.ObjectId
  , Mixed = Schema.Types.ObjectId;

/**
 * Transformations
 */
function toLower (v) {
  return v.toLowerCase();
}

/**
 * User
 */
var UserSchema = new Schema(
  {
      _id:           ObjectId
    , email:         {type:    String, index:  {unique:  true}, required: true,
                      set: toLower, validate: /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/}
    , password:      {type:    String, index:  true, required: true}
    , name:          {type:    String, index:  true}
    , phone:         {type:    String, index:  true}
    , preferences:   Mixed
    , associations:  Mixed
    , confirmed:     Boolean
    , needsreset:    Boolean
    , created:       {type:    Date, index:    true}
    , updated:       {type:    Date, index:    true}
    , session:       String
    , sessionExp:    Date
  }
  , {strict: true}
);

/**
 * Group
 */
var GroupSchema = new Schema(
  {
      _id:       ObjectId
    , parent:    {type:         ObjectId, index:  true, required:  true}
    // TODO: Validate that using embedded-docs would work for insertions, etc.
    , children:  [GroupSchema]
    , owner:     {type:         ObjectId, index:  true, required:  true}
    , members:   [{type:        ObjectId, ref:    'User'}]
    , created:   {type:         Date, index:      true}
    , updated:   {type:         Date, index:      true}
  }
  , {strict: true}
);

/**
 * Prompt
 */
var PromptSchema = new Schema(
  {
    _id: ObjectId
    // TODO: Fill out the rest of this
  }
  , {strict: true}
);


module.exports = {
  User: mongoose.model('User', UserSchema),
  Group: mongoose.model('Group', GroupSchema),
  Prompt: mongoose.model('Prompt', PromptSchema)
}
