var redis = require("redis");
// var bluebird = require("bluebird");
// bluebird.promisifyAll(redis.RedisClient.prototype);
// console.log("Starting test.js");
// var client = redis.createClient({host: "127.0.0.1", port: 6379, db : 0});
// console.log("Started");

var ip = require('ip');

//handleDedup conns cacheExpiry cacheName tasks = do
//  let conn = lookup cacheName conns
//  pts <- case conn of
//          Just (Redis cache) -> do
//            for tasks \(ProcessTracker task) -> do
//                case unNullOrUndefined task.id of 
//                  Just taskId -> do
//                    resp <- set cache [taskId, taskId, "NX", "PX", (show cacheExpiry)]
//                    case resp of
//                      Right result -> do
//                        _ <- pure $ spy result
//                        pure (Just (ProcessTracker task))
//                      Left error -> pure (spy error) *> pure Nothing
//                  Nothing -> pure Nothing
//          _ -> pure []
//  (pure <<< spy) (foldl fProcessTracker [] pts)


// var lock = function() {
//     client.set(["some", "B", "NX", "PX", "30000"], function(err,res){
//         console.log("Err",err);
//         console.log("Response",res);
//     });
// }

// var lockP = function() {
//     client.setAsync(["some4", "B", "NX", "PX", "30000"]).then(function (a) {
//         console.log("res",a);
//     }).catch(function (err) {
//         console.log("err", err);
//     })
// }

// .then(function(res){
//     console.log("Response",res);
// }).catch(function(err) {
//     console.log("Err",err);
// });
// lockP();
// setInterval(lockP(), 1000)

console.log(ip.fromLong(ip.toLong(ip.address())));