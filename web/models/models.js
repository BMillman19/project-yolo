var Schema = mongoose.Schema
  , ObjectId = Schema.ObjectId
  , Mixed = Schema.Types.ObjectId;

var UserSchema = new Schema({
      _id:           ObjectId
    , username:      {type:    String, index:  {unique:  true}}
    , password:      {type:    String, index:  true}
    , name:          {type:    String, index:  true}
    , email:         {type:    String, index:  true}
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

module.exports = {
  User: mongoose.model('User', UserSchema)
}
