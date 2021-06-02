module SearchKeyCmp = Belt.Id.MakeComparable({
  type t = string
  let cmp = (a, b) => Pervasives.compare(a, b)
})

let parseSearchParams = (url: RescriptReactRouter.url) => {
  url.search
    -> Js.String2.split("&")
    -> Js.Array2.filter((v) => v -> Js.String2.match_(%re("/.*=.*/")) != None)
    -> Js.Array2.reduce((acc, item) => {
      let kv = item -> Js.String2.split("=")
      Belt.Map.set(acc, kv[0], kv[1])
    }, Belt.Map.make(~id=module(SearchKeyCmp)))
}
